'use strict'

util = require '../util'
log = require '../log'
assert = require '../assert'

log = log.scope 'Binding'

{isArray} = Array

MAX_LOOPS = 50

getPropHandlerName = do ->
    cache = Object.create null
    toHandlerName = (prop) ->
        if prop[0] is '$'
            prop = "$#{util.capitalize(prop.slice(1))}"
        else
            prop = util.capitalize(prop)
        "on#{prop}Change"
    (prop) ->
        cache[prop] ||= toHandlerName(prop)

class Connection
    pool = []

    @factory = (binding, item, prop, parent = null) ->
        if pool.length > 0 and (elem = pool.pop())
            Connection.call elem, binding, item, prop, parent
            elem
        else
            new Connection binding, item, prop, parent

    constructor: (@binding, item, @prop, @parent) ->
        @handlerName = getPropHandlerName @prop
        @isItemConnected = false

        if isArray(item)
            @itemId = ''
            @child = Connection.factory @binding, item[0], item[1], @
            @item = @child.getValue()
        else
            @itemId = item
            @child = null
            @item = @binding.getItemById item
        @connect()

        Object.seal @

    getSignalChangeListener: do ->
        withParent = ->
            @parent.updateItem()
            return

        noParent = ->
            @binding.update()
            return

        ->
            if @parent
                withParent
            else
                noParent

    update: ->
        @getSignalChangeListener().call @

    connect: ->
        unless @isItemConnected
            handler = @item?[@handlerName]
            if handler
                handler.connect @getSignalChangeListener(), @
                @isItemConnected = true
        return

    disconnect: ->
        if @isItemConnected
            listener = @getSignalChangeListener()
            @item[@handlerName].disconnect listener, @
            @isItemConnected = false
        return

    updateItem: ->
        oldItem = @item
        if @child
            item = @child.getValue()
        else
            item = @binding.getItemById @itemId

        if oldItem isnt item or (item and not @isItemConnected)
            @disconnect()
            @item = item
            @connect()
            unless @parent
                @binding.update()

        if @parent
            @parent.updateItem()
        return

    getValue: ->
        if @item
            @item[@prop]
        else
            null

    destroy: ->
        @disconnect()
        @child?.destroy()
        pool.push @
        return

module.exports =
class Binding
    @New = (binding, ctx, target) ->
        target ?= new Binding binding, ctx
        Object.seal target

        # connections
        {connections} = target
        for elem in binding[1]
            if isArray(elem)
                connections.push Connection.factory target, elem[0], elem[1]

        target

    constructor: (binding, @ctx) ->
        assert.lengthOf binding, 2
        assert.isFunction binding[0]
        assert.isArray binding[1]

        # properties
        @func = binding[0]
        @args = null
        @connections ||= []

        # update
        if process.env.NODE_ENV is 'development'
            @updatePending = false
            @updateLoop = 0

    getItemById: (item) ->
        throw new Error "Not implemented"

    getValue: ->
        throw new Error "Not implemented"

    getDefaultValue: ->
        switch typeof @getValue()
            when 'string'
                ''
            when 'number'
                0
            when 'boolean'
                false
            else
                null

    setValue: (val) ->
        throw new Error "Not implemented"

    onError: (err) ->

    update: ->
        if process.env.NODE_ENV is 'development'
            if @updatePending
                if @updateLoop > MAX_LOOPS
                    return
                if ++@updateLoop is MAX_LOOPS
                    log.error @getLoopDetectedErrorMessage()
                    return
            else
                @updateLoop = 0

        result = util.tryFunction @func, @ctx, @args
        if result instanceof Error
            @onError result
            result = @getDefaultValue()

        if process.env.NODE_ENV is 'development'
            @updatePending = true

        @setValue result

        if process.env.NODE_ENV is 'development'
            @updatePending = false
        return

    getLoopDetectedErrorMessage: ->
        "Potential loop detected"

    destroy: ->
        # destroy connections
        while connection = @connections.pop()
            connection.destroy()

        # clear props
        @args = null
        return
