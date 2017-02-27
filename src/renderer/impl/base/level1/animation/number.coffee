'use strict'

utils = require 'src/utils'
assert = require 'src/assert'
eventLoop = require 'src/eventLoop'

module.exports = (impl) ->
    {Types} = impl
    {now} = Date
    {round} = Math

    pending = []
    nowTime = now()

    vsync = ->
        eventLoop.lock()
        requestAnimationFrame vsync
        nowTime = now()

        i = 0; n = pending.length
        while i < n
            anim = pending[i]

            if anim._running and not anim._paused
                updateAnimation anim
                i++
            else
                # remove element in not ordered list
                # this array may change due loop
                pending[i] = pending[n - 1]
                pending[n - 1] = pending[pending.length - 1]
                pending.pop()
                anim._impl.pending = false
                n--
        eventLoop.release()
        return
    requestAnimationFrame? vsync

    updateAnimation = (anim) ->
        data = anim._impl

        progress = (nowTime - data.startTime) / anim._duration
        if progress < 0
            data.progress = 0
            return
        else if progress > 1
            progress = 1
        data.progress = progress
        running = progress isnt 1 or (anim._running and anim._loop and anim._when)

        if progress is 1
            val = data.to
        else
            val = data.easing anim._duration * progress, data.from, (data.to - data.from), anim._duration
        target = anim._target

        if val is val and target and (property = anim._property) # isNaN hack
            if not running or anim._updateProperty or not data.propertySetter
                anim._updatePending = true
                target[property] = val
                anim._updatePending = false

                # force impl update, because setter won't update if nothing change in data
                if progress is 1 and data.propertySetter and target[property] is val
                    impl[data.propertySetter].call target, val
            else
                impl[data.propertySetter].call target, val
                if anim._updateData
                    target[data.internalPropertyName] = val

        if progress is 1
            if running
                data.startTime += anim._loopDelay + anim._duration
            else
                data.startTime = 0
                anim.running = false
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
            unless data.pending
                pending.push @
                data.pending = true

            data.startTime = nowTime
            updateAnimation @

            data.startTime += @_startDelay
        return

    stopAnimation: do (_super = impl.stopAnimation) -> ->
        _super.call @
        data = @_impl
        if data.type is 'number' and data.startTime isnt 0
            data.startTime = 0
            updateAnimation @
        return

    resumeAnimation: do (_super = impl.resumeAnimation) -> ->
        _super.call @
        if @_impl.type is 'number'
            data = @_impl
            unless data.pending
                pending.push @
                data.pending = true

            data.startTime += Date.now() - data.pauseTime
            data.pauseTime = 0
        return

    pauseAnimation: do (_super = impl.pauseAnimation) -> ->
        _super.call @
        data = @_impl
        if data.type is 'number'
            data.pauseTime = Date.now()
        return
