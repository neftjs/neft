'use strict'

Input = require '../input'

module.exports = class InputText extends Input
    constructor: (document, { element, interpolation, text }) ->
        super document, element, interpolation, text

    getValue: ->
        @element.text

    setValue: (val) ->
        unless val?
            val = ''
        else if typeof val isnt 'string'
            val += ''
        @element.text = val
