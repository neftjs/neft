'use strict'

utils = require 'src/utils'
assert = require 'src/assert'
log = require 'src/log'
eventLoop = require 'src/eventLoop'

assert = assert.scope 'View.Use'
log = log.scope 'View', 'Use'

module.exports = (File) -> class Use
    @__name__ = 'Use'
    @__path__ = 'File.Use'

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Use) - 1

    i = 1
    JSON_NODE = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            node = file.node.getChildByAccessPath arr[JSON_NODE]
            obj = new Use file, node
        obj

    visibilityChangeListener = (oldValue) ->
        value = not oldValue
        isHidden = if value then -1 else 1
        @hiddenDepth += isHidden
        if @file.isRendered and not @isRendered
            @renderImmediate()
        if @file.isRendered and @isRendered and @hiddenDepth > 0
            @revert()
        return

    propsChangeListener = (name) ->
        if name is 'n-component'
            @name = @node.props['n-component']

            if @isRendered
                @revert()
                @renderImmediate()
        return

    queue = []
    queuePending = false

    runQueue = ->
        style = queue.shift()
        file = queue.shift()

        if style.isRendered
            style.renderComponent file

        if queue.length
            requestAnimationFrame runQueue
        else
            queuePending = false
        return

    constructor: (@file, @node) ->
        assert.instanceOf @file, File
        assert.instanceOf @node, File.Element

        @name = @node.props['n-component']
        @refName = @node.props.ref
        @usedComponent = null
        @isRendered = false
        @isRenderPending = false
        @hiddenDepth = 0
        @_renderImmediateCallback = utils.bindFunctionContext @_renderImmediateCallback, @

        do =>
            elem = @node
            while elem
                if 'n-if' of elem.props
                    elem.onVisibleChange visibilityChangeListener, @
                elem = elem.parent

        @node.onPropsChange propsChangeListener, @

        `//<development>`
        if @constructor is Use
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

    render: (file) ->
        assert.instanceOf file, File if file?

        return if @hiddenDepth > 0

        if @isRendered
            @revert()

        @isRendered = true

        useAsync = process.env.NEFT_PLATFORM isnt 'node'
        useAsync &&= @node.props.has 'n-async'
        useAsync &&= @node.props['n-async'] isnt false
        if useAsync
            queue.push @, file
            unless queuePending
                requestAnimationFrame runQueue
                queuePending = true
        else
            @renderComponent file

        return

    renderComponent: (file) ->
        component = @file.components[@name]
        if not file and not component and not File._files[@name]
            return

        usedComponent = file or File.factory(component or @name)

        if file
            file.parentUse?.detachUsedComponent()

        unless usedComponent.isClone
            usedComponent = usedComponent.clone()

        unless usedComponent.isRendered
            usedComponent = usedComponent.render null, @file.context, @

        usedComponent.node.parent = @node
        @usedComponent = usedComponent

        # signal
        usedComponent.parentUse = @
        usedComponent.onReplaceByUse.emit @
        File.emitNodeSignal usedComponent, 'n-onReplaceByUse', @

        # ref
        if @refName
            @file.inputRefs._set @refName, usedComponent.scope

        return

    revert: ->
        return unless @isRendered

        # ref
        if @refName
            @file.inputRefs._set @refName, @file.refs[@refName]

        # destroy used component
        if @usedComponent
            @usedComponent.revert().destroy()

        @isRendered = false
        return

    detachUsedComponent: ->
        assert.isDefined @usedComponent

        @usedComponent.node.parent = null
        @usedComponent.parentUse = null
        @usedComponent = null
        return

    clone: (original, file) ->
        node = original.node.getCopiedElement @node, file.node

        new Use file, node

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NODE] = @node.getAccessPath @file.node
        arr
