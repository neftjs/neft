# coffeelint: disable=no_debugger

'use strict'

utils = require 'src/utils'
assert = require 'src/assert'
signal = require 'src/signal'

module.exports = (File) -> class Log
    @__name__ = 'Log'
    @__path__ = 'File.Log'

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Log) - 1

    i = 1
    JSON_NODE = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            node = file.node.getChildByAccessPath arr[JSON_NODE]
            obj = new Log file, node
        obj

    listenOnTextChange = (node, log) ->
        if node instanceof File.Element.Text
            node.onTextChange log.renderOnChange, log
        else
            for child in node.children
                listenOnTextChange child, log
        return

    constructor: (@file, @node) ->
        assert.instanceOf @file, File
        assert.instanceOf @node, File.Element

        @isRenderPending = false
        @log = utils.bindFunctionContext @log, @

        @node.onPropsChange @renderOnChange, @
        listenOnTextChange @node, @

        `//<development>`
        if @constructor is Log
            Object.preventExtensions @
        `//</development>`

    renderOnChange: ->
        if @file.isRendered
            @render()

    render: ->
        unless @isRenderPending
            @isRenderPending = true
            signal.setImmediate @log
        return

    log: ->
        @isRenderPending = false

        if utils.isEmpty(@node.props)
            console.log @node.stringifyChildren()
        else
            {props} = @node
            log = []
            if content = @node.stringifyChildren()
                log.push content
            for key, val of props when props.hasOwnProperty(key)
                log.push key, '=', val
            console.log.apply console, log
        return

    clone: (original, file) ->
        node = original.node.getCopiedElement @node, file.node

        new Log file, node

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NODE] = @node.getAccessPath @file.node
        arr
