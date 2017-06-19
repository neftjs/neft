'use strict'

eventLoop = require 'src/eventLoop'
Binding = require 'src/binding'

module.exports = (impl) ->

    class RendererBinding extends Binding
        pool = []

        @factory = (obj, prop, binding, ctx) ->
            if elem = pool.pop()
                RendererBinding.call elem, obj, prop, binding, ctx
            RendererBinding.New obj, prop, binding, ctx, elem

        @New = (obj, prop, binding, ctx, target) ->
            target ?= new RendererBinding obj, prop, binding, ctx
            Binding.New binding, ctx, target
            target.update()
            target

        constructor: (@obj, @prop, binding, ctx) ->
            super binding, ctx

        getItemById: (item) ->
            if typeof item is 'object'
                item
            else if item is 'this'
                @ctx
            else if item is 'windowItem'
                impl.windowItem
            else
                impl.Renderer[item] or null

        update: ->
            eventLoop.lock()
            super()
            eventLoop.release()
            return

        getValue: ->
            @obj[@prop]

        setValue: (val) ->
            if not val? or val isnt val
                val = @getDefaultValue()
            @obj[@prop] = val
            return

        getLoopDetectedErrorMessage: ->
            """
                Potential loop detected. \
                Property binding '#{@prop}' on '#{@item.toString()}' has been disabled.
            """

        destroy: ->
            # remove from the list
            @obj._impl.bindings[@prop] = null

            super()

            pool.push @
            return

    setItemBinding: (prop, binding, ctx) ->
        data = @_impl
        data.bindings ?= {}

        data.bindings[prop]?.destroy()

        if binding?
            data.bindings[prop] = RendererBinding.factory @, prop, binding, ctx

        return
