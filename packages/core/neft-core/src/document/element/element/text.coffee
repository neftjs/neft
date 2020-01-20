'use strict'

utils = require '../../../util'
assert = require '../../../assert'
{SignalsEmitter} = require '../../../signal'
styles = require '../styles'

assert = assert.scope 'View.Element.Text'

module.exports = (Element) -> class Text extends Element
    @__name__ = 'Text'

    JSON_CTOR_ID = @JSON_CTOR_ID = Element.JSON_CTORS.push(Text) - 1

    i = Element.JSON_ARGS_LENGTH
    JSON_TEXT = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (arr, obj) ->
        Element._fromJSON arr, obj
        if obj
            obj._text = arr[JSON_TEXT]
        else
            obj = new Text arr[JSON_TEXT]

        if process.env.NEFT_MODE is 'web'
            styles.onSetText obj, arr[JSON_TEXT]

        obj

    constructor: (text = '') ->
        super()

        @_text = text

        if process.env.NEFT_MODE is 'web'
            @_element = document.createTextNode @_text

        if process.env.NODE_ENV isnt 'production' and @constructor is Text
            Object.seal @

    clone: (clone = new Text(@_text)) ->
        super clone
        clone

    opts = utils.CONFIGURABLE
    utils.defineProperty @::, 'text', opts, ->
        @_text
    , (value) ->
        assert.isString value

        old = @_text
        if old is value
            return false

        # set text
        @_text = value

        # trigger event
        @emit 'onTextChange', old

        if process.env.NEFT_MODE is 'universal'
            Element.Tag.query.checkWatchersDeeply @

        styles.onSetText @

        true

    SignalsEmitter.createSignal @, 'onTextChange'

    toJSON: (arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        super arr
        arr[JSON_TEXT] = @text
        arr
