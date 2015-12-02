'use strict'

utils = require 'utils'
signal = require 'signal'

{sin, cos} = Math
{emitSignal} = signal.Emitter

isPointInBox = (ex, ey, x, y, w, h) ->
	ex >= x and ey >= y and ex < x + w and ey < y + h

module.exports = (impl) ->
	PROPAGATE_UP = 1<<0
	STOP_ASIDE_PROPAGATION = 1<<1
	STOP_PROPAGATION = 1<<2

	Scrollable = null
	impl.Renderer.onReady ->
		{Scrollable} = this

	captureItems = do ->
		checkChildren = (type, item, ex, ey, onItem, parentX, parentY, parentScale) ->
			result = 0
			x = y = w = h = scale = rotation = t1 = t2 = rey = rsin = rcos = 0.0

			# TODO: support z-index
			for child in item._children by -1
				# omit not visible children
				unless child._visible
					continue

				# omit children with no pointer events listeners
				data = child._impl

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

				if item instanceof Scrollable and child is item._contentItem
					x -= item.contentX * parentScale
					y -= item.contentY * parentScale

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
				result = checkChildren(type, child, ex, ey, onItem, x, y, scale)
				if result & STOP_PROPAGATION
					return STOP_PROPAGATION

				# test this child
				if result & PROPAGATE_UP or isPointInBox(ex, ey, x, y, w, h)
					result = onItem(child)

				# break if needed
				if result & (STOP_PROPAGATION | STOP_ASIDE_PROPAGATION)
					return result
			return result

		(type, item, ex, ey, onItem) ->
			x = y = 0
			w = item._width
			h = item._height
			scale = 1

			data = item._impl

			# test children
			childrenResult = checkChildren(type, item, ex, ey, onItem, x, y, scale)
			if childrenResult & STOP_PROPAGATION
				return STOP_PROPAGATION

			# test this item
			if childrenResult & PROPAGATE_UP or isPointInBox(ex, ey, x, y, w, h)
				if onItem(item)
					return STOP_PROPAGATION
			return

	itemsToRelease = []
	itemsToMove = []
	pressedItems = []
	hoverItems = []

	impl.Renderer.onReady ->
		{Device} = impl.Renderer
		{event} = impl.Renderer.Item.Pointer

		getEventStatus = ->
			PROPAGATE_UP | (if event._checkSiblings then 0 else STOP_ASIDE_PROPAGATION)

		# support press event
		Device.onPointerPress do ->
			onItem = (item) ->
				event._ensureRelease = event._ensureMove = event._stopPropagation = true
				if item._impl.capturePointer & PRESS
					emitSignal item.pointer, 'onPress', event
					pressedItems.push item
					if event._ensureRelease
						itemsToRelease.push item
					if event._ensureMove
						itemsToMove.push item
					if event._stopPropagation
						return STOP_PROPAGATION
				return getEventStatus()

			(e) ->
				event._checkSiblings = false
				captureItems PRESS, impl.window, e._x, e._y, onItem
				return

		# support release and click events
		Device.onPointerRelease do ->
			onItem = (item) ->
				emitSignal item._pointer, 'onRelease', event
				index = itemsToRelease.indexOf item
				if index >= 0
					itemsToRelease[index] = null
				if utils.has(pressedItems, item)
					emitSignal item.pointer, 'onClick', event
				if event._stopPropagation
					return STOP_PROPAGATION
				return getEventStatus()

			(e) ->
				event._stopPropagation = false
				event._checkSiblings = false

				captureItems CLICK, impl.window, e._x, e._y, onItem

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

			onItem = (item) ->
				data = item._impl
				if data.capturePointer & MOVE
					data.pointerMoveFlag = flag
				if data.capturePointer & (ENTER | EXIT) and not data.pointerHover
					data.pointerHover = true
					hoverItems.push item
					emitSignal item.pointer, 'onEnter', event

				emitSignal item._pointer, 'onMove', event
				if event._stopPropagation
					return STOP_PROPAGATION
				return getEventStatus()

			(e) ->
				event._stopPropagation = false
				event._checkSiblings = false
				flag = (flag % 2) + 1

				captureItems MOVE, impl.window, e._x, e._y, onItem

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
			onItem = (item) ->
				event._stopPropagation = true
				if (pointer = item._pointer) and not signal.isEmpty(pointer.onWheel)
					emitSignal pointer, 'onWheel', event
				if event._stopPropagation
					return STOP_PROPAGATION
				return getEventStatus()

			(e) ->
				event._checkSiblings = false
				captureItems WHEEL, impl.window, e._x, e._y, onItem
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

	setItemParent: (val) ->
		return

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
