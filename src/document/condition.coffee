'use strict'

assert = require 'src/assert'

module.exports = (File) -> class Condition
    @__name__ = 'Condition'
    @__path__ = 'File.Condition'

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Condition) - 1

    i = 1
    JSON_NODE = i++
    JSON_ELSE_NODE = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            node = file.node.getChildByAccessPath arr[JSON_NODE]
            if arr[JSON_ELSE_NODE]
                elseNode = file.node.getChildByAccessPath arr[JSON_ELSE_NODE]
            obj = new Condition file, node, elseNode
        obj

    onPropsChange = (name) ->
        if name is 'n-if'
            @update()
        return

    constructor: (@file, @node, @elseNode=null) ->
        assert.instanceOf @file, File
        assert.instanceOf @node, File.Element
        if elseNode?
            assert.instanceOf @elseNode, File.Element

        @node.onPropsChange onPropsChange, @

        `//<development>`
        if @constructor is Condition
            Object.preventExtensions @
        `//</development>`

    update: ->
        visible = @node.visible = !!@node.props['n-if']
        @elseNode?.visible = not visible
        return

    render: ->
        @update()

    clone: (original, file) ->
        node = original.node.getCopiedElement @node, file.node
        if @elseNode
            elseNode = original.node.getCopiedElement @elseNode, file.node

        new Condition file, node, elseNode

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NODE] = @node.getAccessPath @file.node
        arr[JSON_ELSE_NODE] = @elseNode?.getAccessPath @file.node
        arr
