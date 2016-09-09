'use strict'

assert = require 'src/assert'
utils = require 'src/utils'
log = require 'src/log'

assert = assert.scope 'View.PropChange'
log = log.scope 'View', 'PropChange'

module.exports = (File) -> class PropChange
    @__name__ = 'PropChange'
    @__path__ = 'File.PropChange'

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(PropChange) - 1

    i = 1
    JSON_NODE = i++
    JSON_TARGET = i++
    JSON_NAME = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            node = file.node.getChildByAccessPath arr[JSON_NODE]
            target = file.node.getChildByAccessPath arr[JSON_TARGET]
            obj = new PropChange file, node, target, arr[JSON_NAME]
        obj

    constructor: (@file, @node, @target, @name) ->
        assert.instanceOf @file, File
        assert.instanceOf @node, File.Element
        assert.instanceOf @target, File.Element
        assert.isString @name
        assert.notLengthOf @name, 0

        @_defaultValue = @target.props[@name]

        @update()
        @node.onVisibleChange onVisibleChange, @
        @node.onPropsChange onPropsChange, @

        `//<development>`
        if @constructor is PropChange
            Object.preventExtensions @
        `//</development>`

    update: ->
        val = if @node.visible then @node.props.value else @_defaultValue
        @target.props.set @name, val
        return

    onVisibleChange = ->
        @update()

    onPropsChange = (name, oldValue) ->
        if name is 'name'
            throw new Error 'Dynamic prop name is not implemented'
        else if name is 'value'
            @update()
        return

    clone: (original, file) ->
        node = original.node.getCopiedElement @node, file.node
        target = original.node.getCopiedElement @target, file.node

        new PropChange file, node, target, @name

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NODE] = @node.getAccessPath @file.node
        arr[JSON_TARGET] = @target.getAccessPath @file.node
        arr[JSON_NAME] = @name
        arr