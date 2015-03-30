'use strict'

utils = require 'utils'
signal = require 'signal'

WHEEL_DIVISOR = 3
MIN_POINTER_DELTA = 15

module.exports = (impl) ->
	{Types} = impl

	impl._scrollableUsePointer ?= true
	impl._scrollableUseWheel ?= true

	###
	Scroll container by given x and y deltas
	###
	scroll = (item, x=0, y=0) ->
		x = getLimitedX item, x
		y = getLimitedY item, y

		if item._contentX isnt x or item._contentY isnt y
			item.contentX = x
			item.contentY = y
			signal.STOP_PROPAGATION

	getLimitedX = (item, x) ->
		x /= item._impl.globalScale
		x = item._contentX - x
		max = item._impl.contentItem._width - item._width
		Math.max(0, Math.min(max, x))

	getLimitedY = (item, y) ->
		y /= item._impl.globalScale
		y = item._contentY - y
		max = item._impl.contentItem._height - item._height
		Math.max(0, Math.min(max, y))

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

		lastSnapTargetProp = do ->
			switch prop
				when 'x'
					'lastSnapTargetX'
				when 'y'
					'lastSnapTargetY'

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
			{snap} = item._impl

			if amplitude isnt 0
				animPending = true
				elapsed = Date.now() - timestamp

				if snap
					targetDelta = item[contentProp] - target
					if (amplitude < 0 and targetDelta < 0) or (amplitude > 0 and targetDelta > 0)
						amplitude = -amplitude
						if reversed
							amplitude *= 0.3
						else
							reversed = true

				delta = -amplitude * 0.7 * Math.exp(-elapsed / 325)

				if snap
					if targetDelta > 7 or targetDelta < -7
						if (delta > 0 and delta < 7) or (delta is 0 and targetDelta > 0)
							delta = 7
						else if (delta < 0 and delta > -7) or delta is 0
							delta = -7

				if (not snap or targetDelta > 7 or targetDelta < -7) and (delta > 0.5 or delta < -0.5)
					scrollAxis delta
					requestAnimationFrame anim
				else
					animPending = false
					scrollAxis targetDelta
			else
				animPending = false
			return

		getSnapTarget = (contentPos) ->
			children = item._snapItem?._children or item._contentItem?._children
			minDiff = Infinity
			minVal = 0

			if children
				for child in children
					diff = contentPos - child[positionProp]
					if velocity > 0
						diff += child[sizeProp] * 0.75
					else
						diff -= child[sizeProp] * 0.75

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
			data = item._impl
			{snap} = data

			amplitude = 0.8 * velocity
			timestamp = Date.now()
			target = item[contentProp] + amplitude*4

			if snap
				snapTarget = getSnapTarget target
				if data[lastSnapTargetProp] isnt snapTarget
					target = snapTarget
					data[lastSnapTargetProp] = snapTarget

			if not animPending and (Math.abs(velocity) > 10 or (snap and target is snapTarget))
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
		dx = dy = 0

		moveMovement = (e) ->
			scroll item, e.movementX + dx, e.movementY + dy

		onImplReady = ->
			impl.window.pointer.onMoved (e) ->
				if not listen
					return

				if not focus
					if pointerUsed
						return

					dx += e.movementX
					dy += e.movementY

					if Math.abs(getLimitedX(item, dx)-item._contentX) < MIN_POINTER_DELTA and Math.abs(getLimitedY(item, dy)-item._contentY) < MIN_POINTER_DELTA
						return

					dx = dy = 0

				if moveMovement(e) is signal.STOP_PROPAGATION
					focus = true
					pointerUsed = true

					horizontalContinuous.update dx + e.movementX
					verticalContinuous.update dy + e.movementY
				signal.STOP_PROPAGATION

			impl.window.pointer.onReleased (e) ->
				listen = false
				dx = dy = 0

				return unless focus
				focus = false
				pointerUsed = false

				moveMovement e

				horizontalContinuous.release()
				verticalContinuous.release()

				return

		if impl.window?
			onImplReady()
		else
			impl.onWindowReady onImplReady

		item.pointer.onPressed (e) ->
			listen = true

			item._impl.globalScale = getItemGlobalScale item
			horizontalContinuous.press()
			verticalContinuous.press()

			x = e.x
			y = e.y
			return

	useWheel = (item) ->
		item.pointer.onWheel (e) ->
			x = e.deltaX / WHEEL_DIVISOR
			y = e.deltaY / WHEEL_DIVISOR

			if Math.abs(y) > Math.abs(x)
				x = y

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
		lastSnapTargetX: 0
		lastSnapTargetY: 0

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		# item props
		impl.setItemClip.call @, true

		# signals
		if impl._scrollableUsePointer
			usePointer @
		if impl._scrollableUseWheel
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

	setScrollableSnapItem: (val) ->
		return
