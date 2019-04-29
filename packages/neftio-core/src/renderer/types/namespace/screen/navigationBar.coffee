'use strict'

{SignalsEmitter} = require '../../../../signal'

module.exports = (Renderer, Impl, itemUtils) ->
    class NavigationBar extends SignalsEmitter
        constructor: ->
            super()
            @_height = 0

            Object.preventExtensions @

        itemUtils.defineProperty
            constructor: @
            name: 'height'
