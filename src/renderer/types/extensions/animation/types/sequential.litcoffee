# SequentialAnimation

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    log = require 'src/log'

    log = log.scope 'Renderer', 'SequentialAnimation'

    module.exports = (Renderer, Impl, itemUtils) -> class SequentialAnimation extends Renderer.Animation
        @__name__ = 'SequentialAnimation'

## *SequentialAnimation* SequentialAnimation.New([*Object* options])

        @New = (opts) ->
            item = new SequentialAnimation
            itemUtils.Object.initialize item, opts
            item

## *SequentialAnimation* SequentialAnimation::constructor() : *Animation*

        constructor: ->
            super()
            @_children = []
            @_runningChildIndex = -1
            @onStart onStart
            @onStop onStop

        itemUtils.defineProperty
            constructor: @
            name: 'target'
            setter: (_super) -> (val) ->
                for child in @_children
                    child.target = val
                _super.call @, val
                return

        shouldStop = ->
            @_runningChildIndex >= @_children.length or @_runningChildIndex < 0

        runNext = ->
            unless @_running
                return
            if @_runningChildIndex >= 0
                @_children[@_runningChildIndex].onStop.disconnect runNext, @
            @_runningChildIndex += if @_reversed then -1 else 1
            if @_loop and shouldStop.call(@)
                @_runningChildIndex = if @_reversed then @_children.length - 1 else 0
            if shouldStop.call(@)
                @running = false
            else
                child = @_children[@_runningChildIndex]
                child.onStop runNext, @
                child.running = true
                child.paused = @_paused
            return

        onStart = ->
            unless @_children.length
                @running = false
                return
            runNext.call @
            return

        onStop = ->
            @_children[@_runningChildIndex]?.running = false
            @_runningChildIndex = -1
            return

        itemUtils.defineProperty
            constructor: @
            name: 'paused'
            setter: (_super) -> (val) ->
                _super.call @, val
                @_children[@_runningChildIndex]?.paused = val
                return

        itemUtils.defineProperty
            constructor: @
            name: 'reversed'
            developmentSetter: (val) ->
                assert.isBoolean val
            setter: (_super) -> (val) ->
                _super.call @, val
                return

## ReadOnly *Animation[]* SequentialAnimation::children
