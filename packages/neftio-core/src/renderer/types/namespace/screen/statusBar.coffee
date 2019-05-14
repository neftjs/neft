'use strict'

log = require '../../../../log'
utils = require '../../../../util'
{SignalsEmitter} = require '../../../../signal'
assert = require '../../../../assert'

module.exports = (Renderer, Impl, itemUtils) ->
    class StatusBar extends SignalsEmitter
        constructor: ->
            super()
            @_height = 0
            @_color = 'Dark'

            Object.preventExtensions @

        itemUtils.defineProperty
            constructor: @
            name: 'height'

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
