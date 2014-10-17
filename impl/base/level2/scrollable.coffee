'use strict'

utils = require 'utils'

WHEEL_DIVISOR = 10

module.exports = (impl) ->
	{Types, items} = impl
	{Item, Rectangle} = Types

	###
	Scroll container by given x and y deltas
	###
	scroll = (item, x, y) ->
		{container, content} = item

		if x isnt 0
			val = impl.getItemX(container)+x
			val = Math.max(content[2], Math.min(content[0], val))
			impl.setItemX container, val

		if y isnt 0
			val = impl.getItemY(container)+y
			val = Math.max(content[3], Math.min(content[1], val))
			impl.setItemY container, val

		updateScroll item

	updateScroll = (item) ->
		{container, content} = item

		# x
		x = impl.getItemX(container)
		val = Math.min(content[0], Math.max(content[2], x))
		if val isnt x
			impl.setItemX container, val

		# y
		y = impl.getItemY(container)
		val = Math.min(content[1], Math.max(content[3], y))
		if val isnt y
			impl.setItemY container, val

	###
	Recalculate current content position and size
	###
	updateContent = (id) ->
		item = items[id]
		{content} = item

		children = impl.getItemChildren item.container
		minX = minY = Infinity
		maxWidth = maxHeight = 0

		for child in children
			minX = Math.min minX, impl.getItemX(child)
			minY = Math.min minY, impl.getItemY(child)
			maxWidth = Math.max maxWidth, impl.getItemWidth(child)
			maxHeight = Math.max maxHeight, impl.getItemHeight(child)

		maxX = - maxWidth - minX + impl.getItemWidth(id)
		maxY = - maxHeight - minY + impl.getItemHeight(id)

		content[0] = 0
		content[1] = 0
		content[2] = maxX
		content[3] = maxY

	###
	Update Scrollable content on the child appended or removed
	###
	impl.setItemParent = do (_super = impl.setItemParent) -> (id, val) ->
		parent = items[val]

		old = impl.getItemParent id
		oldItem = items[old]

		# update old
		if old and oldItem.type is 'Scrollable' and oldItem.container
			updateContent old
			updateScroll oldItem

		_super id, val

		# update new
		if parent and parent.type is 'Scrollable' and parent.container
			updateContent val
			updateScroll parent

	overrideSetter = (methodName) ->
		impl[methodName] = do (_super = impl[methodName]) -> (id, val) ->
			_super id, val

			parentId = impl.getItemParent id
			parent = items[parentId]
			if parent?.type is 'Scrollable'
				updateContent parentId
				updateScroll parent

	overrideSetter 'setItemX'
	overrideSetter 'setItemY'
	overrideSetter 'setItemWidth'
	overrideSetter 'setItemHeight'
	overrideSetter 'setItemVisible'

	createContinuous = (id, prop) ->
		item = items[id]

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

	usePointer = (id) ->
		item = items[id]

		horizontalContinuous = createContinuous id, 'x'
		verticalContinuous = createContinuous id, 'y'

		focus = false
		x = y = 0

		moveMovement = (e) ->
			dx = e.x - x
			dy = e.y - y
			scroll item, dx, dy

		impl.attachItemSignal id, 'pointerPressed', (e) ->
			focus = true

			updateContent id

			horizontalContinuous.press()
			verticalContinuous.press()

			x = e.x; y = e.y

		impl.attachItemSignal impl.window, 'pointerReleased', (e) ->
			return unless focus
			focus = false

			moveMovement e

			horizontalContinuous.release()
			verticalContinuous.release()

			x = y = 0

		impl.attachItemSignal impl.window, 'pointerMove', (e) ->
			return unless focus

			moveMovement e

			horizontalContinuous.update e.x - x
			verticalContinuous.update e.y - y

			x = e.x; y = e.y

	useWheel = (id) ->
		item = items[id]

		impl.attachItemSignal id, 'pointerWheel', (e) ->
			x = e.x / WHEEL_DIVISOR
			y = e.y / WHEEL_DIVISOR
			scroll item, x, y

	create: (id, target) ->
		Item.create id, target

		target.content = [0, 0, 0, 0]

		# container
		container = "i#{utils.uid()}"
		impl.createItem 'Item', container
		impl.setItemParent container, id
		target.container = container

		# item props
		impl.setItemClip id, true

		# signals
		usePointer id
		useWheel id

	getScrollableContentX: (id) ->
		impl.getItemX items[id].container

	setScrollableContentX: (id, val) ->
		impl.setItemX items[id].container, val

	getScrollableContentY: (id) ->
		impl.getItemY items[id].container

	setScrollableContentY: (id, val) ->
		impl.setItemY items[id].container, val
