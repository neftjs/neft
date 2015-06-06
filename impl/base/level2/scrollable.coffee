'use strict'

utils = require 'utils'
signal = require 'signal'

WHEEL_DIVISOR = 3
MIN_POINTER_DELTA = 7

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
		MIN_DISTANCE_TO_SNAP = 4

		velocity = 0
		amplitude = 0
		timestamp = 0
		target = 0
		reversed = false
		shouldSnap = false

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
			if amplitude isnt 0
				elapsed = Date.now() - timestamp

				if shouldSnap
					targetDelta = item[contentProp] - target
					if (amplitude < 0 and targetDelta < 0) or (amplitude > 0 and targetDelta > 0)
						amplitude = -amplitude
						if reversed
							amplitude *= 0.3
						else
							reversed = true

				delta = -amplitude * 0.7 * Math.exp(-elapsed / 325)

				if shouldSnap
					if targetDelta > MIN_DISTANCE_TO_SNAP or targetDelta < -MIN_DISTANCE_TO_SNAP
						if (delta > 0 and delta < 7) or (delta is 0 and targetDelta > 0)
							delta = 7
						else if (delta < 0 and delta > -7) or delta is 0
							delta = -7

				if (not shouldSnap or targetDelta > MIN_DISTANCE_TO_SNAP or targetDelta < -MIN_DISTANCE_TO_SNAP) and (delta > 0.5 or delta < -0.5)
					scrollAxis delta
					requestAnimationFrame anim
				else
					scrollAxis targetDelta
			return

		getSnapTarget = (contentPos) ->
			children = item._snapItem?._children or item._contentItem?._children
			minDiff = Infinity
			minVal = 0

			if children
				for child in children
					diff = contentPos - child[positionProp]
					if velocity > 0
						diff += child[sizeProp] * 0.5
					else
						diff -= child[sizeProp] * 0.5

					if velocity >= 0 and diff >= 0 or velocity <= 0 and diff <= 0
						diff = Math.abs diff
						if diff < minDiff
							minDiff = diff
							minVal = child[positionProp]

			if minDiff is Infinity
				child?[positionProp] or 0
			else
				minVal

		press: ->
			velocity = amplitude = 0
			reversed = false
			timestamp = Date.now()

		release: ->
			data = item._impl
			{snap} = data

			if Math.abs(velocity) < 5
				return

			amplitude = 0.8 * velocity
			timestamp = Date.now()
			target = item[contentProp] + amplitude * 4

			if snap
				snapTarget = getSnapTarget target
				shouldSnap = data[lastSnapTargetProp] isnt snapTarget
				# top
				# shouldSnap ||= item[contentProp] < snapTarget
				# # bottom
				# if not shouldSnap and snapTarget + snapTarget[sizeProp] < item[contentProp] + item[sizeProp]
				# 	shouldSnap = true
				# 	snapTarget += snapTarget[sizeProp] - item[sizeProp]
				if shouldSnap
					target = snapTarget
					data[lastSnapTargetProp] = snapTarget

			shouldAnimate = Math.abs(velocity) > 10
			shouldAnimate ||= snap and target is snapTarget
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
		impl.window.pointer.onMove (e) ->
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

	if impl.window?
		onImplReady()
	else
		impl.onWindowReady onImplReady

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
			pointerWindowMoveListeners.push (e) ->
				if not listen
					return

				if not focus
					if pointerUsed
						return

					dx += e.movementX
					dy += e.movementY

					limitedX = getLimitedX(item, dx)
					limitedY = getLimitedY(item, dy)
					if limitedX isnt item._contentX or limitedY isnt item._contentY
						if Math.abs(limitedX-item._contentX) < MIN_POINTER_DELTA and Math.abs(limitedY-item._contentY) < MIN_POINTER_DELTA
							return DELTA_VALIDATION_PENDING

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
			unless item._impl.snap
				x = e.deltaX / WHEEL_DIVISOR
				y = e.deltaY / WHEEL_DIVISOR
				item._impl.globalScale = getItemGlobalScale item
				return scroll(item, x, y)

			now = Date.now()

			if now - lastActionTimestamp > 300
				wheelUsed = false
			lastActionTimestamp = now

			if wheelUsed and not used
				return

			if not wheelUsed and not clear
				used = false
				accepts = false
				i = 0
				minX = minY = maxX = maxY = 0

			i++

			clear = false

			x = e.deltaX / WHEEL_DIVISOR
			y = e.deltaY / WHEEL_DIVISOR

			# if Math.abs(y) > Math.abs(x)
			# 	x = y

			if x > 0 and x > maxX
				maxX = (maxX * (i-1) + x) / i
			else if x < minX
				minX = (minX * (i-1) + x) / i
			if y > 0 and y > maxY
				maxY = (maxY * (i-1) + y) / i
			else if y < minY
				minY = (minY * (i-1) + y) / i

			if (x > 0 and x < maxX * 0.3) or (x < 0 and x > minX * 0.3) or (y > 0 and y < maxY * 0.3) or (y < 0 and y > minY * 0.3)
				unless accepts
					accepts = true
					return signal.STOP_PROPAGATION
			else
				accepts = false

			if accepts
				return signal.STOP_PROPAGATION

			item._impl.globalScale = getItemGlobalScale item
			if scroll(item, x, y) is signal.STOP_PROPAGATION
				lastAcceptedActionTimestamp = now

				unless pending
					pending = true
					horizontalContinuous.press()
					verticalContinuous.press()
					requestAnimationFrame timer
				else
					horizontalContinuous.update x
					verticalContinuous.update y
				wheelUsed = true
				used = true

			if used
				signal.STOP_PROPAGATION

		return

	onWidthChange = (oldVal) ->
		if @contentItem.width < oldVal
			scroll @
		return
	onHeightChange = (oldVal) ->
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
			oldVal.onWidthChange.disconnect onWidthChange, @
			oldVal.onHeightChange.disconnect onHeightChange, @

		if val
			impl.setItemParent.call val, @
			@_impl.contentItem = val
			val.onWidthChange onWidthChange, @
			val.onHeightChange onHeightChange, @
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
