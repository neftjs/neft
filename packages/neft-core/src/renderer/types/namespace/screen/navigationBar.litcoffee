# NavigationBar

    'use strict'

    {SignalsEmitter} = require '../../../../signal'

    module.exports = (Renderer, Impl, itemUtils) ->
        class NavigationBar extends SignalsEmitter
            constructor: ->
                super()
                @_height = 0

                Object.preventExtensions @

## ReadOnly *Float* NavigationBar.height = `0`

## *Signal* NavigationBar.onHeightChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'height'
