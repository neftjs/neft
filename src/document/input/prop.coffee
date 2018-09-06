'use strict'

assert = require 'src/assert'
utils = require 'src/utils'

module.exports = (File, Input) -> class InputProp extends Input
    @__name__ = 'InputProp'
    @__path__ = 'File.Input.Prop'

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(InputProp) - 1

    i = Input.JSON_ARGS_LENGTH
    {JSON_NODE, JSON_TEXT, JSON_BINDING} = Input
    JSON_ATTR_NAME = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            node = file.node.getChildByAccessPath arr[JSON_NODE]
            obj = new InputProp file, node, arr[JSON_TEXT], arr[JSON_BINDING], arr[JSON_ATTR_NAME]
        obj

    @isHandler = isHandler = (node, propName) ->
        if /(?:^|:)on[A-Z][A-Za-z0-9_$]*$/.test(propName)
            true
        else
            false

    constructor: (file, node, text, bindingConfig, @propName) ->
        assert.isString @propName
        assert.notLengthOf @propName, 0

        Input.call @, file, node, text, bindingConfig

        if isHandler(node, @propName)
            @handlerFunc = createHandlerFunc @
            node.props.set @propName, @handlerFunc
        else
            @handlerFunc = null
            if file.isClone
                @registerBinding()

        `//<development>`
        if @constructor is InputProp
            Object.seal @
        `//</development>`

    getValue: ->
        @node.props[@propName]

    setValue: (val) ->
        @node.props.set @propName, val

    createHandlerFunc = (input) ->
        ->
            unless input.file.isRendered
                return
            r = input.bindingConfig.func.apply input.target, input.file.scope
            if typeof r is 'function'
                r = r.apply @, arguments
            r

    clone: (original, file) ->
        node = original.node.getCopiedElement @node, file.node

        new InputProp file, node, @text, @bindingConfig, @propName

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        super key, arr
        arr[JSON_ATTR_NAME] = @propName
        arr
