# Extension

    'use strict'

    utils = require 'src/utils'
    signal = require 'src/signal'
    assert = require 'src/assert'

    module.exports = (Renderer, Impl, itemUtils) -> class Extension extends itemUtils.Object
        @__name__ = 'Extension'

        constructor: ->
            super()
            @_target = null
            @_running = false

## *Item* Extension::target

## *Signal* Extension::onTargetChange(*Item* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'target'
            defaultValue: null

## *Boolean* Extension::running

## *Signal* Extension::onRunningChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'running'
            defaultValue: false
            setter: (_super) -> (val) ->
                assert.isBoolean val

                oldVal = @_running
                _super.call @, val
                if oldVal and not val
                    @_disable()
                if not oldVal and val
                    @_enable()
                return

        _enable: ->

        _disable: ->
