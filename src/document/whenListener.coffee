'use strict'

assert = require 'src/assert'
utils = require 'src/utils'
log = require 'src/log'

assert = assert.scope 'View.WhenListener'
log = log.scope 'View', 'WhenListener'

module.exports = (File) -> class WhenListener
    @__name__ = 'WhenListener'
    @__path__ = 'File.WhenListener'

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(WhenListener) - 1

    i = 1
    JSON_NODE = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            node = file.node.getChildByAccessPath arr[JSON_NODE]
            obj = new WhenListener file, node
        obj

    constructor: (@file, @node) ->
        assert.instanceOf @file, File
        assert.instanceOf @node, File.Element

        @node.onPropsChange onPropsChange, @

        `//<development>`
        if @constructor is WhenListener
            Object.seal @
        `//</development>`

    onPropsChange = (name, oldValue) ->
        if name is 'call'
            return
        unless @node.visible
            return
        {call} = @node.props
        if name is 'change'
            call?()
        return

    clone: (original, file) ->
        node = original.node.getCopiedElement @node, file.node

        new WhenListener file, node

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NODE] = @node.getAccessPath @file.node
        arr
