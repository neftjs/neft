'use strict'

{utils, signal} = Neft
{Impl} = Neft.Renderer
{Item} = Impl.Types

WHEEL_DIVISOR = 3
MIN_POINTER_DELTA = 7

###
Scroll container by given x and y deltas
###
scroll = (item, x = 0, y = 0) ->
    deltaX = getDeltaX item, x
    deltaY = getDeltaY item, y
    x = Math.round item._contentX - deltaX
    y = Math.round item._contentY - deltaY

    x = getLimitedX item, x
    y = getLimitedY item, y

    if item._contentX isnt x or item._contentY isnt y
        item.contentX = x
        item.contentY = y
        return true
    false

getDeltaX = (item, x) ->
    x / item._impl.globalScale

getDeltaY = (item, y) ->
    y / item._impl.globalScale

getLimitedX = (item, x) ->
    max = item._impl.contentItem._width - item._width
    Math.round Math.max(0, Math.min(max, x))

getLimitedY = (item, y) ->
    max = item._impl.contentItem._height - item._height
    Math.round Math.max(0, Math.min(max, y))

getItemGlobalScale = (item) ->
    val = item.scale
    while item = item.parent
        val *= item.scale
    val

createContinuous = (item, prop) ->

    velocity = 0
    amplitude = 0
    timestamp = 0
    target = 0
    reversed = false

    scrollAxis = do ->
        switch prop
            when 'x'
                (val) ->
                    scroll item, val, 0
            when 'y'
                (val) ->
                    scroll item, 0, val

    contentProp = do ->
        switch prop
            when 'x'
                '_contentX'
            when 'y'
                '_contentY'

    positionProp = do ->
        switch prop
            when 'x'
                '_x'
            when 'y'
                '_y'

    sizeProp = do ->
        switch prop
            when 'x'
                '_width'
            when 'y'
                '_height'

    anim = ->
        if amplitude isnt 0
            elapsed = Date.now() - timestamp
            delta = -amplitude * 0.7 * Math.exp(-elapsed / 325)
            if delta > 0.5 or delta < -0.5
                scrollAxis delta
                requestAnimationFrame anim
            else
                scrollAxis targetDelta
        return

    press: ->
        velocity = amplitude = 0
        reversed = false
        timestamp = Date.now()

    release: ->
        data = item._impl

        if Math.abs(velocity) < 5
            return

        amplitude = 0.8 * velocity
        timestamp = Date.now()
        target = item[contentProp] + amplitude * 4

        shouldAnimate = Math.abs(velocity) > 10
        if shouldAnimate
            anim()
        return

    update: (val) ->
        now = Date.now()
        elapsed = now - timestamp
        timestamp = now

        v = 100 * -val / (1 + elapsed)
        velocity = 0.8 * v + 0.2 * velocity
        return

DELTA_VALIDATION_PENDING = 1

pointerWindowMoveListeners = []
onImplReady = ->
    Impl.window.pointer.onMove (e) ->
        stop = false
        for listener in pointerWindowMoveListeners
            r = listener(e)
            if r is signal.STOP_PROPAGATION
                stop = true
                break
            if r is DELTA_VALIDATION_PENDING
                stop = true
        if stop
            signal.STOP_PROPAGATION

if Impl.window?
    onImplReady()
else
    Impl.onWindowReady onImplReady

pointerUsed = false
usePointer = (item) ->
    horizontalContinuous = createContinuous item, 'x'
    verticalContinuous = createContinuous item, 'y'

    focus = false
    listen = false
    dx = dy = 0

    moveMovement = (e) ->
        unless scroll(item, e.movementX + dx, e.movementY + dy)
            e.stopPropagation = false

    onImplReady = ->
        pointerWindowMoveListeners.push (e) ->
            if not listen
                return

            if not focus
                if pointerUsed
                    return

                dx += e.movementX
                dy += e.movementY

                limitedX = getLimitedX(item, -dx)
                limitedY = getLimitedY(item, -dy)
                if limitedX isnt item._contentX or limitedY isnt item._contentY
                    proceed = Math.abs(limitedX - item._contentX) < MIN_POINTER_DELTA
                    proceed &&= Math.abs(limitedY - item._contentY) < MIN_POINTER_DELTA
                    if proceed
                        return DELTA_VALIDATION_PENDING

                dx = dy = 0

            if moveMovement(e) is signal.STOP_PROPAGATION
                focus = true
                pointerUsed = true

                horizontalContinuous.update dx + e.movementX
                verticalContinuous.update dy + e.movementY
            signal.STOP_PROPAGATION

        Impl.window.pointer.onRelease (e) ->
            listen = false
            dx = dy = 0

            return unless focus
            focus = false
            pointerUsed = false

            moveMovement e

            horizontalContinuous.release()
            verticalContinuous.release()

            return

    if Impl.window?
        onImplReady()
    else
        Impl.onWindowReady onImplReady

    item.pointer.onPress (e) ->
        listen = true

        item._impl.globalScale = getItemGlobalScale item
        horizontalContinuous.press()
        verticalContinuous.press()
        return

wheelUsed = false
lastActionTimestamp = 0
useWheel = (item) ->
    i = 0
    used = false
    accepts = false
    pending = false
    clear = true
    lastAcceptedActionTimestamp = 0
    horizontalContinuous = createContinuous item, 'x'
    verticalContinuous = createContinuous item, 'y'
    x = y = 0
    minX = minY = maxX = maxY = 0

    timer = ->
        now = Date.now()
        if accepts or now - lastAcceptedActionTimestamp > 70
            pending = false
            accepts = true
            horizontalContinuous.update x
            verticalContinuous.update y
            horizontalContinuous.release()
            verticalContinuous.release()
        else
            requestAnimationFrame timer
        return

    item.pointer.onWheel (e) ->
        x = e.deltaX / WHEEL_DIVISOR
        y = e.deltaY / WHEEL_DIVISOR
        item._impl.globalScale = getItemGlobalScale item
        unless scroll(item, x, y)
            e.stopPropagation = false

    return

onWidthChange = (oldVal) ->
    if @contentItem.width < oldVal
        scroll @
    return

onHeightChange = (oldVal) ->
    if @contentItem.height < oldVal
        scroll @
    return

exports.create = (data) ->
    Item.create.call @, data
    Item.setItemClip.call @, true

    # signals
    usePointer @
    useWheel @
    return

exports.createData = ->
    utils.merge
        contentItem: null
        globalScale: 1
    , Item.DATA

exports.setScrollableContentItem = (val) ->
    if oldVal = @_impl.contentItem
        Impl.setItemParent.call oldVal, null
        oldVal.onWidthChange.disconnect onWidthChange, @
        oldVal.onHeightChange.disconnect onHeightChange, @

    if val
        if @children.length > 0
            Impl.insertItemBefore.call val, @children.first
        else
            Impl.setItemParent.call val, @

        @_impl.contentItem = val
        val.onWidthChange onWidthChange, @
        val.onHeightChange onHeightChange, @
    return

exports.setScrollableContentX = (val) ->
    if item = @_impl.contentItem
        Impl.setItemX.call item, -val
    return

exports.setScrollableContentY = (val) ->
    if item = @_impl.contentItem
        Impl.setItemY.call item, -val
    return
