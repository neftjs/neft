'use strict'

assert = require 'src/assert'
utils = require 'src/utils'
log = require 'src/log'

assert = assert.scope 'View.StateChange'
log = log.scope 'View', 'StateChange'

module.exports = (File) -> class StateChange
    @__name__ = 'StateChange'
    @__path__ = 'File.StateChange'

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(StateChange) - 1

    i = 1
    JSON_NODE = i++
    JSON_NAME = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            node = file.node.getChildByAccessPath arr[JSON_NODE]
            obj = new StateChange file, node, arr[JSON_NAME]
        obj

    constructor: (@file, @node, @name) ->
        assert.instanceOf @file, File
        assert.instanceOf @node, File.Element
        assert.isString @name
        assert.notLengthOf @name, 0

        @_defaultValue = undefined

        @update()
        @node.onVisibleChange onVisibleChange, @
        @node.onPropsChange onPropsChange, @

        `//<development>`
        if @constructor is StateChange
            Object.seal @
        `//</development>`

    update: ->
        {inputState} = @file
        val = if @node.visible then @node.props.value else @_defaultValue
        if val isnt undefined
            inputState.set @name, val
        else if inputState.has(@name)
            inputState.pop @name
        return

    render: ->
        @_defaultValue = @file.inputState[@name]
        @update()

    onVisibleChange = ->
        @update()

    onPropsChange = (name, oldValue) ->
        if name is 'name'
            throw new Error 'Dynamic <state /> name is not supported yet'
        else if name is 'value'
            @update()
        return

    clone: (original, file) ->
        node = original.node.getCopiedElement @node, file.node

        new StateChange file, node, @name

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NODE] = @node.getAccessPath @file.node
        arr[JSON_NAME] = @name
        arr
