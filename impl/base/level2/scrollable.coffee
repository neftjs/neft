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
		x = item._contentX - x
		max = contentItem._width - item._width
		x = Math.max(0, Math.min(max, x))

		y /= globalScale
		y = item._contentY - y
		max = contentItem._height - item._height
		y = Math.max(0, Math.min(max, y))

		if item._contentX isnt x or item._contentY isnt y
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
		target = 0
		reversed = false
		animPending = false

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
			if amplitude isnt 0 or item._impl.snap
				animPending = true
				elapsed = Date.now() - timestamp
				targetDelta = item[contentProp] - target

				if (amplitude > 0 and targetDelta < 0) or (amplitude < 0 and targetDelta > 0)
					amplitude = -amplitude
					if reversed
						amplitude *= 0.3
					else
						reversed = true

				delta = amplitude * 0.7 * Math.exp(-elapsed / 325)

				if targetDelta > 5 or targetDelta < -5
					if (delta > 0 and delta < 5) or (delta is 0 and targetDelta > 0)
						delta = 5
					else if (delta < 0 and delta > -5) or delta is 0
						delta = -5

				if (targetDelta > 5 or targetDelta < -5) and (delta > 0.5 or delta < -0.5)
					scrollAxis delta
					requestAnimationFrame anim
				else
					animPending = false
					scrollAxis targetDelta
			return

		getSnapTarget = (contentPos) ->
			children = item._contentItem._children
			minDiff = Infinity
			minVal = 0

			for child in children
				diff = contentPos - child[positionProp]
				if velocity > 0
					diff += child[sizeProp] * 0.45
				else
					diff -= child[sizeProp] * 0.45

				if velocity >= 0 and diff >= 0 or velocity <= 0 and diff <= 0
					diff = Math.abs diff
					if diff < minDiff
						minDiff = diff
						minVal = child[positionProp]
			minVal

		press: ->
			velocity = amplitude = 0
			reversed = false
			timestamp = Date.now()

		release: ->
			{snap} = item._impl

			if Math.abs(velocity) > 10 or snap
				amplitude = 0.8 * velocity
				timestamp = Date.now()
				target = item[contentProp] + amplitude*8
				if snap
					target = getSnapTarget target

				unless animPending
					anim()
			return

		update: (val) ->
			now = Date.now()
			elapsed = now - timestamp
			timestamp = now

			v = 100 * -val / (1 + elapsed)
			velocity = 0.8 * v + 0.2 * velocity
			return

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
		MAX_WAIT = 70
		accepts = false
		pending = false
		lastActionTimestamp = 0
		lastAcceptedActionTimestamp = 0
		horizontalContinuous = createContinuous item, 'x'
		verticalContinuous = createContinuous item, 'y'
		x = y = 0
		minX = minY = maxX = maxY = 0

		timer = ->
			now = Date.now()
			if accepts or now - lastAcceptedActionTimestamp > MAX_WAIT
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
			now = Date.now()

			if now - lastActionTimestamp > MAX_WAIT
				minX = minY = maxX = maxY = 0
				accepts = false

			lastActionTimestamp = now
			{x, y} = e
			x /= WHEEL_DIVISOR
			y /= WHEEL_DIVISOR

			if x > 0 and x > maxX
				maxX = x
			else if x < minX
				minX = x
			if e.y > 0 and y > maxY
				maxY = y
			else if y < minY
				minY = y

			if (x > 0 and x < maxX * 0.35) or (x < 0 and x > minX * 0.35) or (y > 0 and y < maxY * 0.35) or (y < 0 and y > minY * 0.35)
				accepts = true
				return

			lastAcceptedActionTimestamp = now

			unless pending
				pending = true
				horizontalContinuous.press()
				verticalContinuous.press()
				requestAnimationFrame timer
			else
				horizontalContinuous.update x
				verticalContinuous.update y

			item._impl.globalScale = getItemGlobalScale item
			scroll item, x, y
		return

	onWidthChanged = (oldVal) ->
		if @contentItem.width < oldVal
			scroll @
		return
	onHeightChanged = (oldVal) ->
		if @contentItem.height < oldVal
			scroll @
		return

	DATA =
		contentItem: null
		globalScale: 1
		snap: false

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
		return

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
		return

	setScrollableContentX: (val) ->
		@_impl.contentItem?.x = -val
		return

	setScrollableContentY: (val) ->
		@_impl.contentItem?.y = -val
		return

	setScrollableSnap: (val) ->
		@_impl.snap = val
		return
