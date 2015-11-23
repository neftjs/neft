'use strict'

utils = require 'utils'
signal = require 'signal'

{sin, cos} = Math

isPointInBox = (ex, ey, x, y, w, h) ->
	ex >= x and ey >= y and ex <= x + w and ey <= y + h

module.exports = (impl) ->
	captureItems = do ->
		CAPTURED = 1<<0
		STOP_PROPAGATION = 1<<1

		(type, item, ex, ey, onItem, parentX, parentY, parentScale) ->
			result = childrenResult = childrenCapturesPointer = 0
			x = y = w = h = scale = rotation = t1 = t2 = rey = rsin = rcos = 0.0

			# TODO: support z-index
			for child in item._children by -1
				# omit not visible children
				unless child._visible
					continue

				# omit children with no pointer events listeners
				data = child._impl
				if type & MOVE
					childrenCapturesPointer = data.childrenCapturesMovePointer
				else
					childrenCapturesPointer = data.childrenCapturesClickPointer
				if childrenCapturesPointer <= 0 and data.capturePointer <= 0
					continue

				# omit children with disabled pointer
				pointer = child._pointer
				if pointer and not pointer._enabled
					continue

				# get coordinates
				x = parentX + child._x * parentScale
				y = parentY + child._y * parentScale
				w = child._width * parentScale
				h = child._height * parentScale
				scale = child._scale
				rotation = child._rotation

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
					t1 = x + w/2
					t2 = y + h/2
					rey = rcos * (ex-t1) - rsin * (ey-t2) + t1
					ey = rsin * (ex-t1) + rcos * (ey-t2) + t2
					ex = rey

				# omit outer point for clipped items
				if child._clip and not isPointInBox(ex, ey, x, y, w, h)
					continue

				# test children
				if childrenCapturesPointer > 0
					childrenResult = captureItems(type, child, ex, ey, onItem, x, y, scale)
					if childrenResult & STOP_PROPAGATION
						return STOP_PROPAGATION
					result |= childrenResult
				else
					childrenResult = 0

				# test this child
				if data.capturePointer & type
					if childrenResult & CAPTURED or isPointInBox(ex, ey, x, y, w, h)
						result |= CAPTURED
						if onItem(child)
							return STOP_PROPAGATION
			return result

	itemsToRelease = []
	itemsToMove = []
	pressedItems = []
	hoverItems = []

	impl.Renderer.onReady ->
		{Device} = impl.Renderer
		{event} = impl.Renderer.Item.Pointer

		# support press event
		Device.onPointerPress do ->
			onItem = (item) ->
				event._ensureRelease = event._ensureMove = event._stopPropagation = true
				unless signal.isEmpty(item.pointer.onPress)
					item.pointer.onPress.emit event
					pressedItems.push item
					if event._ensureRelease
						itemsToRelease.push item
					if event._ensureMove
						itemsToMove.push item
					return event._stopPropagation
				false

			(e) ->
				if impl.window._impl.childrenCapturesClickPointer > 0
					captureItems PRESS, impl.window, e._x, e._y, onItem, 0, 0, 1
				return

		# support release and click events
		Device.onPointerRelease do ->
			onItem = (item) ->
				index = itemsToRelease.indexOf item
				item.pointer.onRelease.emit event
				if index >= 0
					itemsToRelease[index] = null
				if utils.has(pressedItems, item)
					item.pointer.onClick.emit event
				return event._stopPropagation

			(e) ->
				event._stopPropagation = false

				if impl.window._impl.childrenCapturesClickPointer > 0
					captureItems CLICK, impl.window, e._x, e._y, onItem, 0, 0, 1

				unless event._stopPropagation
					for item in itemsToRelease by -1
						if item
							item.pointer.onRelease.emit event
							if event._stopPropagation
								break

				utils.clear itemsToRelease
				utils.clear itemsToMove
				utils.clear pressedItems
				return

		# support move, enter and exit events
		Device.onPointerMove do ->
			flag = 0

			onItem = (item) ->
				data = item._impl
				if data.capturePointer & MOVE
					data.pointerMoveFlag = flag
				if data.capturePointer & (ENTER | EXIT) and not data.pointerHover
					data.pointerHover = true
					hoverItems.push item
					item.pointer.onEnter.emit event

				item.pointer.onMove.emit event
				return event._stopPropagation

			(e) ->
				event._stopPropagation = false
				flag = (flag % 2) + 1

				if impl.window._impl.childrenCapturesMovePointer > 0
					captureItems MOVE, impl.window, e._x, e._y, onItem, 0, 0, 1

				for item in itemsToMove
					if event._stopPropagation
						break
					data = item._impl
					if data.pointerMoveFlag isnt flag
						item.pointer.onMove.emit event

				for item, i in hoverItems by -1
					data = item._impl
					if data.pointerHover and data.pointerMoveFlag isnt flag
						data.pointerHover = false
						data.pointerMoveFlag = 0
						hoverItems.splice i, 1
						item.pointer.onExit.emit event

				for item in itemsToMove
					data = item._impl
					if data.pointerMoveFlag isnt flag
						data.pointerMoveFlag = flag

				return

		# support wheel event
		Device.onPointerWheel do ->
			onItem = (item) ->
				event._stopPropagation = true
				unless signal.isEmpty(item.pointer.onWheel)
					item.pointer.onWheel.emit event
					return event._stopPropagation
				false

			(e) ->
				if impl.window._impl.childrenCapturesClickPointer > 0
					event._deltaX = e._deltaX
					event._deltaY = e._deltaY
					captureItems WHEEL, impl.window, e._x, e._y, onItem, 0, 0, 1
				return

	i = 0

	# TODO: support drag events
	EVENTS: EVENTS =
		onPress: PRESS = 1 << i++
		onRelease: RELEASE = 1 << i++
		onMove: MOVE = 1 << i++
		onWheel: WHEEL = 1 << i++
		onClick: CLICK = (1 << i++) | PRESS | RELEASE
		onEnter: ENTER = (1 << i++) | MOVE
		onExit: EXIT = (1 << i++) | MOVE
		# onDragStart: 1 << i++
		# onDragEnd: 1 << i++
		# onDragEnter: 1 << i++
		# onDragExit: 1 << i++
		# onDrop: 1 << i++
		# onWheel: 1 << i++

	DATA:
		pointerHover: false
		pointerMoveFlag: 0
		capturePointer: 0
		childrenCapturesClickPointer: 0
		childrenCapturesMovePointer: 0

	setItemParent: (val) ->
		data = @_impl

		clickAmount = data.childrenCapturesClickPointer
		if data.capturePointer & (PRESS | RELEASE | WHEEL)
			clickAmount++

		moveAmount = data.childrenCapturesMovePointer
		if data.capturePointer & MOVE
			moveAmount++

		if clickAmount > 0 or moveAmount > 0
			parent = @
			while parent = parent._parent
				parent._impl.childrenCapturesClickPointer -= clickAmount
				parent._impl.childrenCapturesMovePointer -= moveAmount

			parent = val
			while parent
				parent._impl.childrenCapturesClickPointer += clickAmount
				parent._impl.childrenCapturesMovePointer += moveAmount
				parent = parent._parent
		return

	attachItemSignal: (signal) ->
		item = @_ref
		data = item._impl

		unless eventId = EVENTS[signal]
			return

		clickPlus = eventId & (PRESS | RELEASE | WHEEL) and +!(data.capturePointer & (PRESS | RELEASE | WHEEL))
		movePlus = eventId & MOVE and +!(data.capturePointer & MOVE)
		if clickPlus > 0 or movePlus > 0
			parent = item
			while parent = parent._parent
				parent._impl.childrenCapturesClickPointer += clickPlus
				parent._impl.childrenCapturesMovePointer += movePlus

		data.capturePointer |= eventId
		return

	setItemPointerEnabled: (val) ->
		return

	setItemPointerDraggable: (val) ->
		return

	setItemPointerDragActive: (val) ->
		return
