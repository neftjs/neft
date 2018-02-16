'use strict'

utils = require 'src/utils'
assert = require 'src/assert'
List = require 'src/list'
log = require 'src/log'
eventLoop = require 'src/eventLoop'

{isArray} = Array

assert = assert.scope 'View.Iterator'
log = log.scope 'View', 'Iterator'

module.exports = (File) -> class Iterator
    @__name__ = 'Iterator'
    @__path__ = 'File.Iterator'

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Iterator) - 1

    i = 1
    JSON_NAME = i++
    JSON_NODE = i++
    JSON_TEXT = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            node = file.node.getChildByAccessPath arr[JSON_NODE]
            obj = new Iterator file, node, arr[JSON_NAME]
        obj.text = arr[JSON_TEXT]
        obj

    propsChangeListener = (name) ->
        if @file.isRendered and name is 'n-each'
            @revert()
            @renderImmediate()

    visibilityChangeListener = (oldValue) ->
        value = not oldValue
        isHidden = if value then -1 else 1
        @hiddenDepth += isHidden
        if @file.isRendered and not @isRendered
            @renderImmediate()
        if @file.isRendered and @isRendered and @hiddenDepth > 0
            @revert()
        return

    constructor: (@file, @node, @name) ->
        assert.instanceOf @file, File
        assert.instanceOf @node, File.Element
        assert.isString @name
        assert.notLengthOf @name, 0

        @usedComponents = []
        @text = ''
        @data = null
        @isRendered = false
        @isRenderPending = false
        @hiddenDepth = 0
        @inputProps = Object.create @file.inputProps
        @_renderImmediateCallback = utils.bindFunctionContext @_renderImmediateCallback, @

        @node.onPropsChange propsChangeListener, @

        do =>
            elem = @node
            while elem
                if 'n-if' of elem.props
                    elem.onVisibleChange visibilityChangeListener, @
                elem = elem.parent

        `//<development>`
        if @constructor is Iterator
            Object.preventExtensions @
        `//</development>`

    renderImmediate: ->
        unless @isRenderPending
            @isRenderPending = true
            eventLoop.setImmediate @_renderImmediateCallback
        return

    _renderImmediateCallback: ->
        @isRenderPending = false
        if not @isRendered and @file.isRendered
            @render()
        return

    render: ->
        return if @hiddenDepth > 0

        each = @node.props['n-each']

        # stop if nothing changed
        if each is @data
            return

        # stop if no data found
        if not isArray(each) and not (each instanceof List)
            # log.warn "Data is not an array nor List in '#{@text}':\n#{each}"
            return

        @isRendered = true

        # set as data
        @data = array = each

        # listen on changes
        if each instanceof List
            each.onChange @updateItem, @
            each.onInsert @insertItem, @
            each.onPop @popItem, @

        # add items
        for _, i in array
            @insertItem i

        null

    revert: ->
        {data} = @

        if data
            @clearData()

            if data instanceof List
                data.onChange.disconnect @updateItem, @
                data.onInsert.disconnect @insertItem, @
                data.onPop.disconnect @popItem, @

        @data = null
        @isRendered = false
        return

    update: ->
        @revert()
        @render()

    clearData: ->
        assert.isObject @data

        while length = @usedComponents.length
            @popItem length - 1

        @

    updateItem: (elem, i) ->
        unless i?
            i = elem

        assert.isObject @data
        assert.isInteger i

        @popItem i
        @insertItem i

        @

    insertItem: (elem, i) ->
        unless i?
            i = elem

        assert.isObject @data
        assert.isInteger i

        {data} = @

        usedComponent = File.factory @name
        @usedComponents.splice i, 0, usedComponent

        each = data
        item = data[i]

        # replace
        newChild = usedComponent.node
        newChild.parent = @node
        newChild.index = i

        # render component
        @inputProps.each = each
        @inputProps.index = i
        @inputProps.item = item
        usedComponent.scope = @file.scope
        usedComponent.render @inputProps, @file.context, null, @file.inputRefs

        # signal
        usedComponent.onReplaceByUse.emit @
        File.emitNodeSignal usedComponent, 'n-onReplaceByUse', @

        @

    popItem: (elem, i) ->
        unless i?
            i = elem

        assert.isObject @data
        assert.isInteger i

        usedComponent = @usedComponents[i]
        usedComponent.scope = null
        usedComponent.revert().destroy()
        @usedComponents.splice i, 1

        usedComponent.node.parent = undefined

        @

    clone: (original, file) ->
        node = original.node.getCopiedElement @node, file.node

        new Iterator file, node, @name

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NAME] = @name
        arr[JSON_NODE] = @node.getAccessPath @file.node
        arr[JSON_TEXT] = @text
        arr
