'use strict'

utils = require 'utils'

WHEEL_DIVISOR = 8

module.exports = (impl) ->
	{Types} = impl
	{Item, Rectangle} = Types

	###
	Scroll container by given x and y deltas
	###
	scroll = (item, x, y) ->
		{contentItem, globalScale} = item._impl

		if x isnt 0
			x /= globalScale
			val = item.contentX - x
			max = contentItem.width - item.width
			val = Math.max(0, Math.min(max, val))
			item.contentX = val

		if y isnt 0
			y /= globalScale
			val = item.contentY - y
			max = contentItem.height - item.height
			val = Math.max(0, Math.min(max, val))
			item.contentY = val

	getItemGlobalScale = (item) ->
		val = item.scale
		while item = item.parent
			val *= item.scale
		val

	# updateScroll = (item) ->
		
	# 	{x, y} = contentItem

	# 	# x
	# 	val = Math.min(0, Math.max(contentItem.width, x))
	# 	if val isnt x
	# 		item.contentX = val

	# 	# y
	# 	val = Math.min(0, Math.max(contentItem.height, y))
	# 	if val isnt y
	# 		item.contentY = val

	###
	Recalculate current content position and size
	###
	# updateContent = (id) ->
	# 	item = items[id]
	# 	{content} = item

	# 	children = impl.getItemChildren item.container
	# 	minX = minY = Infinity
	# 	maxWidth = maxHeight = 0

	# 	for child in children
	# 		minX = Math.min minX, impl.getItemX(child)
	# 		minY = Math.min minY, impl.getItemY(child)
	# 		maxWidth = Math.max maxWidth, impl.getItemWidth(child)
	# 		maxHeight = Math.max maxHeight, impl.getItemHeight(child)

	# 	maxX = - maxWidth - minX + impl.getItemWidth(id)
	# 	maxY = - maxHeight - minY + impl.getItemHeight(id)

	# 	content[0] = 0
	# 	content[1] = 0
	# 	content[2] = maxX
	# 	content[3] = maxY

	###
	Update Scrollable content on the child appended or removed
	###
	# impl.setItemParent = do (_super = impl.setItemParent) -> (id, val) ->
	# 	parent = items[val]

	# 	old = impl.getItemParent id
	# 	oldItem = items[old]

	# 	# update old
	# 	if old and oldItem.type is 'Scrollable' and oldItem.container
	# 		updateContent old
	# 		updateScroll oldItem

	# 	_super id, val

	# 	# update new
	# 	if parent and parent.type is 'Scrollable' and parent.container
	# 		updateContent val
	# 		updateScroll parent

	# overrideSetter = (methodName) ->
	# 	impl[methodName] = do (_super = impl[methodName]) -> (id, val) ->
	# 		_super id, val

	# 		parentId = impl.getItemParent id
	# 		parent = items[parentId]
	# 		if parent?.type is 'Scrollable' and parent.container isnt id
	# 			updateContent parentId
	# 			updateScroll parent

	# overrideSetter 'setItemX'
	# overrideSetter 'setItemY'
	# overrideSetter 'setItemWidth'
	# overrideSetter 'setItemHeight'
	# overrideSetter 'setItemVisible'

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
			delta = -amplitude*0.1 * Math.exp(-elapsed / 325);
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

	usePointer = (item) ->
		horizontalContinuous = createContinuous item, 'x'
		verticalContinuous = createContinuous item, 'y'

		focus = false
		x = y = 0

		moveMovement = (e) ->
			dx = e.x - x
			dy = e.y - y
			scroll item, dx, dy

		impl.attachItemSignal.call item, 'pointerPressed', (e) ->
			focus = true

			item._impl.globalScale = getItemGlobalScale item
			horizontalContinuous.press()
			verticalContinuous.press()

			x = e.x; y = e.y

		impl.attachItemSignal.call impl.window, 'pointerReleased', (e) ->
			return unless focus
			focus = false

			moveMovement e

			horizontalContinuous.release()
			verticalContinuous.release()

			x = y = 0

		impl.attachItemSignal.call impl.window, 'pointerMove', (e) ->
			return unless focus

			moveMovement e

			horizontalContinuous.update e.x - x
			verticalContinuous.update e.y - y

			x = e.x; y = e.y

	useWheel = (item) ->
		impl.attachItemSignal.call item, 'pointerWheel', (e) ->
			item._impl.globalScale = getItemGlobalScale item
			x = e.x / WHEEL_DIVISOR
			y = e.y / WHEEL_DIVISOR
			scroll item, x, y

	create: (item) ->
		storage = item._impl

		Item.create item

		storage.contentItem = null
		storage.globalScale = 1

		# item props
		impl.setItemClip.call item, true

		# signals
		usePointer item
		useWheel item

	setScrollableContentItem: (val) ->
		oldVal = @_impl.contentItem

		if newVal = val
			@_impl.contentItem = newVal

	setScrollableContentX: (val) ->
		@_impl.contentItem?.x = -val

	setScrollableContentY: (val) ->
		@_impl.contentItem?.y = -val
