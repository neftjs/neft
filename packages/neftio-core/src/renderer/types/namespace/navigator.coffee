'use strict'

utils = require '../../../util'
{SignalsEmitter} = require '../../../signal'
assert = require '../../../assert'

module.exports = (Renderer, Impl, itemUtils) ->
    class Navigator extends SignalsEmitter
        constructor: ->
            super()
            @_impl = bindings: null
            @_language = 'en'
            @_browser = true
            @_online = true

            Object.preventExtensions @

        utils.defineProperty @::, 'language', null, ->
            @_language
        , null

        utils.defineProperty @::, 'browser', null, ->
            @_browser
        , null

        utils.defineProperty @::, 'native', null, ->
            not @_browser
        , null

        itemUtils.defineProperty
            constructor: @
            name: 'online'
            developmentSetter: (val) ->
                assert.isBoolean val

    navigator = new Navigator
    Impl.initNavigatorNamespace?.call navigator
    navigator
