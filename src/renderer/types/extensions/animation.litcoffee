# Animation

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    signal = require 'src/signal'

    module.exports = (Renderer, Impl, itemUtils) -> class Animation extends Renderer.Extension
        @__name__ = 'Animation'

## *Animation* Animation::constructor() : *Renderer.Extension*

        constructor: ->
            super()
            @_loop = false
            @_paused = false
            @_reversed = false

## *Signal* Animation::onStart()

        signal.Emitter.createSignal @, 'onStart'

## *Signal* Animation::onStop()

        signal.Emitter.createSignal @, 'onStop'

        itemUtils.defineProperty
            constructor: @
            name: 'running'
            developmentSetter: (val) ->
                assert.isBoolean val
            setter: (_super) -> (val) ->
                @_when = val
                oldVal = @_running
                if oldVal is val
                    return

                _super.call @, val

                if val
                    Impl.startAnimation.call @
                    @onStart.emit()
                    if @_paused
                        Impl.pauseAnimation.call @
                else
                    if @_paused
                        @paused = false
                    Impl.stopAnimation.call @
                    @onStop.emit()
                return

## *Boolean* Animation::paused

## *Signal* Animation::onPausedChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'paused'
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

## *Boolean* Animation::reversed

## *Signal* Animation::onReversedChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'reversed'
            implementation: Impl.setAnimationReversed
            developmentSetter: (val) ->
                assert.isBoolean val

## *Boolean* Animation::loop

## *Signal* Animation::onLoopChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'loop'
            implementation: Impl.setAnimationLoop
            developmentSetter: (val) ->
                assert.isBoolean val

## Animation::start()

        start: ->
            @running = true
            @

## Animation::stop()

        stop: ->
            @running = false
            @

## Animation::pause()

        pause: ->
            if @running
                @paused = true
            @

## Animation::resume()

        resume: ->
            @paused = false
            @

        enable: ->
            @running = true

        disable: ->
            @running = false
