'use strict'

utils = require '../../../../../util'
signal = require '../../../../../signal'
eventLoop = require '../../../../../event-loop'

{sin, cos} = Math
{emitSignal} = signal.Emitter

isPointInBox = (ex, ey, x, y, w, h) ->
    ex >= x and ey >= y and ex < x + w and ey < y + h

module.exports = (impl) ->
    PROPAGATE_UP = 1<<0
    STOP_ASIDE_PROPAGATION = 1<<1
    STOP_PROPAGATION = 1<<2

    captureItems = do ->
        checkItem = (item, ex, ey, onItem, parentX, parentY, parentScale) ->
            result = 0
            x = y = w = h = scale = rotation = t1 = t2 = rey = rsin = rcos = 0.0

            # omit not visible children
            unless item._visible
                return result

            # omit children with no pointer events listeners
            data = item._impl

            # omit children with disabled pointer
            pointer = item._pointer
            if pointer and not pointer._enabled
                return result

            # get coordinates
            x = parentX + item._x * parentScale
            y = parentY + item._y * parentScale
            w = item._width * parentScale
            h = item._height * parentScale
            scale = item._scale
            rotation = item._rotation
            fullScale = scale * parentScale

            # add scale
            if scale isnt 1
                t1 = w * scale
                t2 = h * scale
                x += (w - t1) / 2
                y += (h - t2) / 2
                w = t1
                h = t2

            # add rotation
            if rotation isnt 0
                rsin = sin -rotation
                rcos = cos -rotation
                t1 = x + w / 2
                t2 = y + h / 2
                rey = rcos * (ex - t1) - rsin * (ey - t2) + t1
                ey = rsin * (ex - t1) + rcos * (ey - t2) + t2
                ex = rey

            # omit outer point for clipped items
            if item._clip and not isPointInBox(ex, ey, x, y, w, h)
                return result

            unless result & STOP_ASIDE_PROPAGATION
                # test children
                if item._children
                    child = item._children.topChild
                    while child
                        result = checkItem(child, ex, ey, onItem, x, y, fullScale)
                        if result & STOP_PROPAGATION
                            return result
                        if result & STOP_ASIDE_PROPAGATION
                            break
                        child = child.belowSibling

            # test this child
            if result & PROPAGATE_UP or isPointInBox(ex, ey, x, y, w, h)
                itemX = (ex - x) / fullScale
                itemY = (ey - y) / fullScale
                result = onItem(item, itemX, itemY)

            return result

        (item, ex, ey, onItem) ->
            if item
                return checkItem item, ex, ey, onItem, 0, 0, 1
            return 0

    itemsToRelease = []
    itemsToMove = []
    pressedItems = []
    hoverItems = []

    impl.Renderer.onReady ->
        {Device} = impl.Renderer
        {event} = impl.Renderer.Item.Pointer

        getEventStatus = ->
            if event._checkSiblings
                PROPAGATE_UP
            else
                PROPAGATE_UP | STOP_ASIDE_PROPAGATION

        # support press event
        Device.onPointerPress do ->
            onItem = (item, itemX, itemY) ->
                {capturePointer} = item._impl
                if capturePointer & CLICK
                    pressedItems.push item
                if capturePointer & PRESS
                    event._ensureRelease = true
                    event._ensureMove = true
                    event._itemX = itemX
                    event._itemY = itemY
                    emitSignal item.pointer, 'onPress', event
                    if event._ensureRelease
                        itemsToRelease.push item
                    if event._ensureMove
                        itemsToMove.push item
                    if event._stopPropagation
                        return STOP_PROPAGATION
                getEventStatus()

            eventLoop.bindInLock (e) ->
                event._stopPropagation = false
                event._checkSiblings = false
                event._preventClick = false
                captureItems impl.windowItem, e._x, e._y, onItem
                return

        # support release and click events
        Device.onPointerRelease do ->
            onItem = (item, itemX, itemY) ->
                data = item._impl
                {capturePointer} = data
                if capturePointer & (RELEASE | PRESS | CLICK)
                    event._itemX = itemX
                    event._itemY = itemY
                if capturePointer & RELEASE
                    emitSignal item._pointer, 'onRelease', event
                if capturePointer & PRESS
                    index = itemsToRelease.indexOf item
                    if index >= 0
                        itemsToRelease[index] = null
                if capturePointer & CLICK and not event._preventClick
                    if utils.has(pressedItems, item)
                        emitSignal item.pointer, 'onClick', event
                if capturePointer & (RELEASE | CLICK)
                    if event._stopPropagation
                        return STOP_PROPAGATION
                getEventStatus()

            eventLoop.bindInLock (e) ->
                event._stopPropagation = false
                event._checkSiblings = false

                captureItems impl.windowItem, e._x, e._y, onItem

                event._itemX = -1
                event._itemY = -1

                # exit all entered items on touch screen
                if impl.Renderer.Screen.touch
                    while item = hoverItems.pop()
                        data = item._impl
                        data.pointerHover = false
                        data.pointerMoveFlag = 0
                        emitSignal item.pointer, 'onExit', event

                unless event._stopPropagation
                    for item in itemsToRelease by -1
                        if item
                            emitSignal item.pointer, 'onRelease', event
                            if event._stopPropagation
                                break

                utils.clear itemsToRelease
                utils.clear itemsToMove
                utils.clear pressedItems
                return

        # support move, enter and exit events
        Device.onPointerMove do ->
            flag = 0

            onItem = (item, itemX, itemY) ->
                data = item._impl
                {capturePointer} = data
                if capturePointer & (ENTER | EXIT | MOVE)
                    data.pointerMoveFlag = flag
                    event._itemX = itemX
                    event._itemY = itemY
                if capturePointer & (ENTER | EXIT) and not data.pointerHover
                    data.pointerHover = true
                    hoverItems.push item
                    emitSignal item.pointer, 'onEnter', event
                if capturePointer & MOVE
                    emitSignal item._pointer, 'onMove', event
                if capturePointer & (ENTER | EXIT | MOVE)
                    if event._stopPropagation
                        return STOP_PROPAGATION
                getEventStatus()

            eventLoop.bindInLock (e) ->
                event._stopPropagation = false
                event._checkSiblings = false
                flag = (flag % 2) + 1

                captureItems impl.windowItem, e._x, e._y, onItem

                event._itemX = -1
                event._itemY = -1

                for item in itemsToMove
                    if event._stopPropagation
                        break
                    data = item._impl
                    if data.pointerMoveFlag isnt flag
                        emitSignal item.pointer, 'onMove', event

                for item, i in hoverItems by -1
                    data = item._impl
                    if data.pointerHover and data.pointerMoveFlag isnt flag
                        data.pointerHover = false
                        data.pointerMoveFlag = 0
                        hoverItems.splice i, 1
                        emitSignal item.pointer, 'onExit', event

                for item in itemsToMove
                    data = item._impl
                    if data.pointerMoveFlag isnt flag
                        data.pointerMoveFlag = flag
                return

        # support wheel event
        Device.onPointerWheel do ->
            onItem = (item, itemX, itemY) ->
                event._stopPropagation = true
                if item._impl.capturePointer & WHEEL
                    if (pointer = item._pointer) and not signal.isEmpty(pointer.onWheel)
                        event._itemX = itemX
                        event._itemY = itemY
                        emitSignal pointer, 'onWheel', event
                        if event._stopPropagation
                            return STOP_PROPAGATION
                getEventStatus()

            eventLoop.bindInLock (e) ->
                event._checkSiblings = false
                captureItems impl.windowItem, e._x, e._y, onItem
                return

    i = 0

    # TODO: support drag events
    EVENTS: EVENTS =
        onPress: PRESS = 1 << i++
        onRelease: RELEASE = 1 << i++
        onMove: MOVE = 1 << i++
        onWheel: WHEEL = 1 << i++
        onClick: CLICK = 1 << i++
        onEnter: ENTER = 1 << i++
        onExit: EXIT = 1 << i++
        # onDragStart: 1 << i++
        # onDragEnd: 1 << i++
        # onDragEnter: 1 << i++
        # onDragExit: 1 << i++
        # onDrop: 1 << i++

    DATA:
        pointerHover: false
        pointerMoveFlag: 0
        capturePointer: 0

    attachItemSignal: (signal) ->
        item = @_ref
        data = item._impl

        unless eventId = EVENTS[signal]
            return

        data.capturePointer |= eventId
        return

    setItemPointerEnabled: (val) ->
        return

    setItemPointerDraggable: (val) ->
        return

    setItemPointerDragActive: (val) ->
        return
