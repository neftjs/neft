'use strict'

utils = require 'src/utils'
assert = require 'src/assert'
log = require 'src/log'

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

    visibilityChangeListener = ->
        if @file.isRendered and not @isRendered
            @render()

    attrsChangeListener = (name) ->
        if name is 'component'
            @name = @node.attrs['component']

            if @isRendered
                @revert()
                @render()
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

        @name = @node.attrs.component
        @idName = @node.attrs.id
        @usedComponent = null
        @isRendered = false

        @node.onVisibleChange visibilityChangeListener, @
        @node.onAttrsChange attrsChangeListener, @

        `//<development>`
        if @constructor is Use
            Object.preventExtensions @
        `//</development>`

    render: (file) ->
        assert.instanceOf file, File if file?

        return unless @node.visible

        if @isRendered
            @revert()

        @isRendered = true

        useAsync = utils.isClient
        useAsync &&= @node.attrs.has 'n-async'
        useAsync &&= @node.attrs['n-async'] isnt false
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
            usedComponent = usedComponent.render null, @file.root, @

        usedComponent.node.parent = @node
        @usedComponent = usedComponent

        # signal
        usedComponent.parentUse = @
        usedComponent.onReplaceByUse.emit @
        File.emitNodeSignal usedComponent, 'n-onReplaceByUse', @

        # id
        if @idName
            @file.inputIds.set @idName, usedComponent.context

        return

    revert: ->
        return unless @isRendered

        # id
        if @idName
            @file.inputIds.set @idName, @file.ids[@idName]

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
