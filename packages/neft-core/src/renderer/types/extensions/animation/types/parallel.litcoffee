# ParallelAnimation

    'use strict'

    utils = require '../../../../../util'
    assert = require '../../../../../assert'
    log = require '../../../../../log'

    log = log.scope 'Renderer', 'ParallelAnimation'

    module.exports = (Renderer, Impl, itemUtils) -> class ParallelAnimation extends Renderer.Animation
        @__name__ = 'ParallelAnimation'

## *ParallelAnimation* ParallelAnimation.New([*Object* options])

        @New = (opts) ->
            item = new ParallelAnimation
            itemUtils.Object.initialize item, opts
            item

## *ParallelAnimation* ParallelAnimation::constructor() : *Animation*

        constructor: ->
            super()
            @_children = []
            @_runningChildren = 0
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

        onChildrenStop = ->
            if @loop
                onStop.call @
                onStart.call @
            else
                @running = false
            return

        onChildStop = ->
            @_runningChildren -= 1
            if @_runningChildren is 0
                onChildrenStop.call @
            return

        onStart = ->
            unless @_children.length
                @running = false
                return
            @_runningChildren = @_children.length
            for child in @_children
                child.onStop.connect onChildStop, @
                child.running = true
            return

        onStop = ->
            for child in @_children
                child.onStop.disconnect onChildStop, @
                child.running = false
            return

        itemUtils.defineProperty
            constructor: @
            name: 'paused'
            setter: (_super) -> (val) ->
                _super.call @, val
                for child in @_children
                    child.paused = val
                return

        itemUtils.defineProperty
            constructor: @
            name: 'reversed'
            developmentSetter: (val) ->
                assert.isBoolean val
            setter: (_super) -> (val) ->
                _super.call @, val
                for child in @_children
                    child.reversed = val
                return

## ReadOnly *Animation[]* ParallelAnimation::children
