'use strict'

utils = require '../../../../../util'
assert = require '../../../../../assert'
log = require '../../../../../log'
{setImmediate} = require '../../../../../event-loop'

log = log.scope 'Renderer', 'ParallelAnimation'

module.exports = (Renderer, Impl, itemUtils) -> class ParallelAnimation extends Renderer.Animation
    @__name__ = 'ParallelAnimation'

    @New = (opts) ->
        item = new ParallelAnimation
        itemUtils.Object.initialize item, opts
        item

    constructor: ->
        super()
        @_children = []
        @_runningChildren = 0
        @onStart.connect onStartImmediate
        @onStop.connect onStopImmediate

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
        return if not @_running
        unless @_children.length
            @running = false
            return
        @_runningChildren = @_children.length
        for child in @_children
            child.onStop.connect onChildStop, @
            child.running = true
        return

    onStop = ->
        return if @_running
        for child in @_children
            child.onStop.disconnect onChildStop, @
            child.running = false
        return

    onStartImmediate = ->
        setImmediate => onStart.call @

    onStopImmediate = ->
        setImmediate => onStop.call @

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
