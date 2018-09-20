'use strict'

assert = require '../../assert'
utils = require '../../util'
Input = require '../input'

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
            @registerBinding()

    getValue: ->
        @element.props[@prop]

    setValue: (val) ->
        @element.props.set @prop, val

    createHandlerFunc = (input) ->
        ->
            unless input.document.rendered
                return
            r = input.interpolation.func.apply input.target
            if typeof r is 'function'
                r = r.apply @, arguments
            r
