'use strict'

assert = require '../../assert'
utils = require '../../util'
Input = require '../input'
{prefixTagClassOrIdProp} = require '../element/element/tag/util'

module.exports = class InputProp extends Input
    @isHandler = isHandler = (node, prop) ->
        if /(?:^|:)on[A-Z][A-Za-z0-9_$]*$/.test(prop)
            true
        else
            false

    constructor: (document, { element, @prop, interpolation, text }) ->
        super document, element, interpolation, text

        if isHandler(@element, @prop)
            @handlerFunc = createHandlerFunc @
            @element.props.set @prop, @handlerFunc
        else
            @handlerFunc = null

    getValue: ->
        @element.props[@prop]

    setValue: (val) ->
        if process.env.NEFT_MODE is 'web'
            val = prefixTagClassOrIdProp @prop, val, @document.uid

        @element.props.set @prop, val

    render: ->
        unless @handlerFunc
            super()

    revert: ->
        unless @handlerFunc
            super()

    createHandlerFunc = (input) ->
        ->
            unless input.document.rendered
                return
            r = input.interpolation.func.call input.document.exported, @
            if typeof r is 'function'
                r = r.apply @, arguments
            r
