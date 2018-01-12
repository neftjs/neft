'use strict'

utils = require 'src/utils'
assert = require 'src/assert'
eventLoop = require 'src/eventLoop'

module.exports = (impl) ->
    {Types, Renderer} = impl
    {now} = Date
    {round} = Math

    pending = []
    nowTime = now()

    vsync = ->
        nowTime = now()

        eventLoop.lock()
        i = 0; n = pending.length
        while i < n
            anim = pending[i]

            if anim._running and not anim._paused
                updateAnimation anim, Renderer.PropertyAnimation.ON_PENDING
                i++
            else
                pending.splice i, 1
                anim._impl.pending = false
                n--

        if pending.length > 0
            requestAnimationFrame vsync

        eventLoop.release()
        return

    updateAnimation = (anim, stateFlags) ->
        data = anim._impl

        progress = (nowTime - data.startTime) / anim._duration
        if progress < 0
            progress = 0
        else if progress > 1
            progress = 1
        data.progress = progress
        running = progress isnt 1 or (anim._running and anim._loop and anim._when)

        fromVal = if data.reversed then data.to else data.from
        toVal = if data.reversed then data.from else data.to

        if progress is 1
            val = toVal
        else
            val = data.easing(
                anim._duration * progress,
                fromVal,
                (toVal - fromVal),
                anim._duration
            )

        target = anim._target
        property = anim._property

        if progress is 1
            stateFlags |= Renderer.PropertyAnimation.ON_STOP

        if val is val and target and property # isNaN hack
            if (anim._updateProperty & stateFlags) > 0 or not data.propertySetter
                anim._updatePending = true
                target[property] = val
                anim._updatePending = false
            else
                impl[data.propertySetter].call target, val

        if progress is 1
            if running
                data.startTime += anim._loopDelay + anim._duration
            else
                data.startTime = 0
                anim.running = false
        return

    addAnimationIntoPending = (anim) ->
        data = anim._impl
        unless data.pending
            if pending.length is 0
                requestAnimationFrame vsync
            pending.push anim
            data.pending = true
        return

    DATA =
        type: 'number'
        pending: false
        startTime: 0
        pauseTime: 0
        from: 0
        to: 0

    DATA: DATA

    createData: impl.utils.createDataCloner 'PropertyAnimation', DATA

    create: (data) ->
        impl.Types.PropertyAnimation.create.call @, data

    startAnimation: do (_super = impl.startAnimation) -> ->
        _super.call @
        if @_impl.type is 'number'
            data = @_impl
            data.from = @_from
            data.to = @_to
            addAnimationIntoPending @

            data.startTime = now()
            updateAnimation @, Renderer.PropertyAnimation.ON_START

            data.startTime += @_startDelay
        return

    stopAnimation: do (_super = impl.stopAnimation) -> ->
        _super.call @
        data = @_impl
        if data.type is 'number' and data.startTime isnt 0
            updateAnimation @, Renderer.PropertyAnimation.ON_STOP
            data.startTime = 0
        return

    resumeAnimation: do (_super = impl.resumeAnimation) -> ->
        _super.call @
        if @_impl.type is 'number'
            data = @_impl
            addAnimationIntoPending @

            data.startTime += Date.now() - data.pauseTime
            data.pauseTime = 0
        return

    pauseAnimation: do (_super = impl.pauseAnimation) -> ->
        _super.call @
        data = @_impl
        if data.type is 'number'
            data.pauseTime = Date.now()
        return
