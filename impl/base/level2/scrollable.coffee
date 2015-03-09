'use strict'

utils = require 'utils'
signal = require 'signal'

WHEEL_DIVISOR = 3
MIN_POINTER_DELTA = 5

module.exports = (impl) ->
	{Types} = impl

	impl._scrollableUsePointer ?= true

	###
	Scroll container by given x and y deltas
	###
	scroll = (item, x=0, y=0) ->
		{contentItem, globalScale} = item._impl

		x /= globalScale
		x = item.contentX - x
		max = contentItem.width - item.width
		x = Math.max(0, Math.min(max, x))

		y /= globalScale
		y = item.contentY - y
		max = contentItem.height - item.height
		y = Math.max(0, Math.min(max, y))

		if item.contentX isnt x or item.contentY isnt y
			item.contentX = x
			item.contentY = y
			signal.STOP_PROPAGATION

	canScroll = (item) ->
		{contentX, contentY} = item
		{contentItem, globalScale} = item._impl

		xMax = contentItem.width - item.width
		yMax = contentItem.height - item.height

		contentX > 0 or contentX < xMax or contentY > 0 or contentY < yMax

	getItemGlobalScale = (item) ->
		val = item.scale
		while item = item.parent
			val *= item.scale
		val

	createContinuous = (item, prop) ->
		velocity = 0
		amplitude = 0
		timestamp = 0

		scrollProp = do ->
			switch prop
				when 'x'
					(val) ->
						scroll item, val, 0
				when 'y'
					(val) ->
						scroll item, 0, val

		anim = ->
			return unless amplitude

			elapsed = Date.now() - timestamp
			delta = -amplitude*0.7 * Math.exp(-elapsed / 325);
			if Math.abs(delta) > 0.5
				scrollProp delta
				requestAnimationFrame anim

		press: ->
			velocity = amplitude = 0
			timestamp = Date.now()

		release: ->
			if Math.abs(velocity) > 10
				amplitude = 0.8 * velocity
				timestamp = Date.now()

				requestAnimationFrame anim

		update: (val) ->
			now = Date.now()
			elapsed = now - timestamp
			timestamp = now

			v = 100 * -val / (1 + elapsed);
			velocity = 0.8 * v + 0.2 * velocity;

	pointerUsed = false
	usePointer = (item) ->
		horizontalContinuous = createContinuous item, 'x'
		verticalContinuous = createContinuous item, 'y'

		focus = false
		listen = false
		x = y = 0

		moveMovement = (e) ->
			dx = e.x - x
			dy = e.y - y
			scroll item, dx, dy

		item.pointer.onPressed (e) ->
			listen = true

			item._impl.globalScale = getItemGlobalScale item
			horizontalContinuous.press()
			verticalContinuous.press()

			x = e.x; y = e.y
			signal.STOP_PROPAGATION

		item.pointer.onMoved (e) ->
			if listen
				if pointerUsed or Math.abs(e.x - x) + Math.abs(e.y - y) > MIN_POINTER_DELTA
					if moveMovement(e) is signal.STOP_PROPAGATION
						focus = true
						pointerUsed = true

						horizontalContinuous.update e.x - x
						verticalContinuous.update e.y - y

						moveMovement e
					x = e.x; y = e.y
			return

		item.pointer.onReleased (e) ->
			listen = false

			return unless focus
			focus = false
			pointerUsed = false

			moveMovement e

			horizontalContinuous.release()
			verticalContinuous.release()

			x = y = 0
			return

	useWheel = (item) ->
		item.pointer.onWheel (e) ->
			item._impl.globalScale = getItemGlobalScale item
			x = e.x / WHEEL_DIVISOR
			y = e.y / WHEEL_DIVISOR
			scroll item, x, y

	onWidthChanged = (oldVal) ->
		if @contentItem.width < oldVal
			scroll @
	onHeightChanged = (oldVal) ->
		if @contentItem.height < oldVal
			scroll @

	DATA =
		contentItem: null
		globalScale: 1

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		# item props
		impl.setItemClip.call @, true

		# signals
		if impl._scrollableUsePointer
			usePointer @
		useWheel @

	setScrollableContentItem: (val) ->
		if oldVal = @_impl.contentItem
			impl.setItemParent.call oldVal, null
			oldVal.onWidthChanged.disconnect onWidthChanged, @
			oldVal.onHeightChanged.disconnect onHeightChanged, @

		if val
			impl.setItemParent.call val, @
			@_impl.contentItem = val
			val.onWidthChanged onWidthChanged, @
			val.onHeightChanged onHeightChanged, @

	setScrollableContentX: (val) ->
		@_impl.contentItem?.x = -val

	setScrollableContentY: (val) ->
		@_impl.contentItem?.y = -val
