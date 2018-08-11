# StatusBar

    'use strict'

    log = require 'src/log'
    utils = require 'src/utils'
    signal = require 'src/signal'
    assert = require 'src/assert'

    module.exports = (Renderer, Impl, itemUtils) ->
        class StatusBar extends signal.Emitter
            constructor: ->
                super()
                @_height = 0
                @_color = 'Dark'

                Object.preventExtensions @

## ReadOnly *Float* StatusBar.height = `0`

## *Signal* StatusBar.onHeightChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'height'

## ReadOnly *String* StatusBar.color = `'Dark'`

May contains: Light or Dark.

## *Signal* StatusBar.onColorChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'color'
                implementation: Impl.setScreenStatusBarColor
                implementationValue: (val) ->
                    val = utils.capitalize(val.toLowerCase())
                    if val not in ['Light', 'Dark']
                        log.warn("Unknown Screen.StatusBar.color `#{val}` given")
                        val = 'Dark'
                    val
                developmentSetter: (val) ->
                    assert.isString val
