'use strict'

utils = require 'src/utils'
assert = require 'src/assert'
log = require 'src/log'

module.exports = (File) -> class PropsToSet
    @__name__ = 'PropsToSet'
    @__path__ = 'File.PropsToSet'

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(PropsToSet) - 1

    i = 1
    JSON_NODE = i++
    JSON_ATTRS = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            node = file.node.getChildByAccessPath arr[JSON_NODE]
            obj = new PropsToSet file, node, arr[JSON_ATTRS]
        obj

    constructor: (@file, @node, @props) ->
        assert.instanceOf @file, File
        assert.instanceOf @node, File.Element
        assert.isPlainObject @props

        # set current props
        for prop of @props
            if @node.props[prop]?
                @setProp prop, null

        # listen on changes
        @node.onPropsChange @setProp, @

        `//<development>`
        if @constructor is PropsToSet
            Object.preventExtensions @
        `//</development>`

    setProp: (prop, oldValue) ->
        unless @props[prop]
            return

        val = @node.props[prop]
        if typeof @node[prop] is 'function' and @node[prop].connect
            if typeof oldValue is 'function'
                @node[prop].disconnect oldValue
            if typeof val is 'function'
                @node[prop] val
        else
            @node[prop] = val
        return

    clone: (original, file) ->
        node = original.node.getCopiedElement @node, file.node

        new PropsToSet file, node, @props

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NODE] = @node.getAccessPath @file.node
        arr[JSON_ATTRS] = @props
        arr
