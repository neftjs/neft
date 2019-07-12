'use strict'

utils = require '../../../util'
assert = require '../../../assert'
{SignalsEmitter} = require '../../../signal'

module.exports = (Renderer, Impl, itemUtils) -> class Animation extends Renderer.Extension
    @__name__ = 'Animation'

    constructor: ->
        super()
        @_loop = false
        @_paused = false
        @_reversed = false

    SignalsEmitter.createSignal @, 'onStart'

    SignalsEmitter.createSignal @, 'onStop'

    itemUtils.defineProperty
        constructor: @
        name: 'paused'
        defaultValue: false
        developmentSetter: (val) ->
            assert.isBoolean val
        setter: (_super) -> (val) ->
            oldVal = @_paused
            if oldVal is val
                return

            _super.call @, val

            if val
                Impl.pauseAnimation.call @
            else
                Impl.resumeAnimation.call @
            return

    itemUtils.defineProperty
        constructor: @
        name: 'reversed'
        defaultValue: false
        implementation: Impl.setAnimationReversed
        developmentSetter: (val) ->
            assert.isBoolean val

    itemUtils.defineProperty
        constructor: @
        name: 'loop'
        defaultValue: false
        implementation: Impl.setAnimationLoop
        developmentSetter: (val) ->
            assert.isBoolean val

    start: ->
        @running = true
        @

    stop: ->
        @running = false
        @

    pause: ->
        if @running
            @paused = true
        @

    resume: ->
        @paused = false
        @

    _enable: ->
        Impl.startAnimation.call @
        @emit 'onStart'
        if @_paused
            Impl.pauseAnimation.call @

    _disable: ->
        if @_paused
            @paused = false
        Impl.stopAnimation.call @
        @emit 'onStop'
