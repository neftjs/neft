'use strict'

# get transform CSS property name
transformProp = do ->
	prefix = do ->
		tmp = document.createElement 'div'
		return 't' if tmp.style.transform?
		return 'webkitT' if tmp.style.webkitTransform?
		return 'mozT' if tmp.style.mozTransform?
		return 'msT' if tmp.style.msTransform?

	"#{prefix}ransform"

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

rad2deg = (rad) ->
	rad * 180/Math.PI

{now} = Date

SIGNALS =
	'pointerClicked': 'click'
	'pointerPressed': 'mousedown'
	'pointerReleased': 'mouseup'
	'pointerEntered': 'mouseenter'
	'pointerExited': 'mouseleave'
	'pointerMove': 'mousemove'
	'pointerWheel': (elem, func) ->
		if isFirefox
			'DOMMouseScroll'
		else
			'mousewheel'

mouseCoordsArgs = (e) ->
	x: e.screenX
	y: e.screenY

SIGNALS_ARGS =
	'pointerWheel': do ->
		REQUIRED_CHECKS = 200
		NORMALIZED_VALUE = 120

		checks = 0
		lastX = lastY = 0

		getDeltas = (e) ->
			e.preventDefault()

			x: e.wheelDeltaX || 0
			y: e.wheelDelta || -e.detail

		normalizedWheel = (e) ->
			r = getDeltas e

			r.x = Math.max(-1, Math.min(1, r.x)) * NORMALIZED_VALUE
			r.y = Math.max(-1, Math.min(1, r.y)) * NORMALIZED_VALUE

			r

		continuousWheel = getDeltas

		(e) ->
			x = e.wheelDeltaX || 0
			y = e.wheelDelta || -e.detail

			# check whether we check it enough
			if checks < REQUIRED_CHECKS
				absX = Math.abs x
				absY = Math.abs y

				# check if it's not first validation
				if checks > 0
					# check whether values change in time
					if absX isnt lastX or absY isnt lastY
						# always use continuous wheel
						SIGNALS_ARGS.pointerWheel = continuousWheel

				# save current deltas to compare it in the next check
				lastX = absX
				lastY = absY
				checks++
			else
				# values don't change, always use normalized wheel
				SIGNALS_ARGS.pointerWheel = normalizedWheel

			# use normalized wheel temporary
			normalizedWheel e

	'pointerPressed': mouseCoordsArgs
	'pointerReleased': mouseCoordsArgs
	'pointerMove': mouseCoordsArgs

HOT_MAX_TIME = 120
HOT_MAX_ACTIONS = 100

module.exports = (impl) ->
	{items} = impl

	updateTransforms = (item) ->
		transform = ''
		if item.isHot
			transform += "translate3d(#{item.x}px, #{item.y}px, 0) "
		if item.rotation
			transform += "rotate(#{rad2deg(item.rotation)}deg) "
		if item.scale isnt 1
			transform += "scale(#{item.scale}) "
		item.elem.style[transformProp] = transform

	markAction = (item) ->
		if now() - item.lastAction < HOT_MAX_TIME
			if item.hotActions++ > HOT_MAX_ACTIONS
				{style, id} = item.elem
				item.isHot = true
				item.x = getItemX id
				item.y = getItemY id
				style.left = style.top = '0'
		else
			item.lastAction = now()

	create: (id, target) ->
		target.elem ?= document.createElement 'div'
		target.elem.id = id

		target.x = 0
		target.y = 0
		target.rotation = 0
		target.scale = 1

		target.lastAction = now()
		target.hotActions = 0
		target.isHot = false

	confirmItemChild: (id, child) ->
		!!items[id]?.elem.querySelector "##{child}"

	getItemChildren: (id) ->
		item = items[id]

		if item.container?
			return impl.getItemChildren item.container

		{elem} = item
		{children} = elem

		arr = []
		for child in children
			if id = child.id
				arr.push id

		arr

	getItemParent: (id) ->
		parent = items[id].elem.parentElement

		if parent
			parentId = parent.id
			parent2Id = parent.parentElement.id

			if items[parent2Id]?.container is parentId
				parent2Id
			else
				parentId

	setItemParent: (id, val) ->
		elem = items[id].elem
		parent = items[val]

		unless parent
			elem.parentElement?.removeChild elem
			return

		parentElem = items[parent.container]?.elem or parent.elem
		parentElem.appendChild elem

	getItemVisible: (id) ->
		items[id]?.elem.style.display isnt 'none'

	setItemVisible: (id, val) ->
		items[id]?.elem.style.display = if val then 'inherit' else 'none'

	getItemClip: (id) ->
		items[id]?.elem.style.overflow is 'hidden'

	setItemClip: (id, val) ->
		items[id]?.elem.style.overflow = if val then 'hidden' else 'visible'

	getItemWidth: (id) ->
		parseFloat(items[id]?.elem.style.width) or 0

	setItemWidth: (id, val) ->
		items[id]?.elem.style.width = "#{val}px"

	getItemHeight: (id) ->
		parseFloat(items[id]?.elem.style.height) or 0

	setItemHeight: (id, val) ->
		items[id]?.elem.style.height = "#{val}px"

	getItemX: getItemX = (id) ->
		item = items[id]
		return unless item
		item.x or parseFloat(item.elem.style.left) or 0

	setItemX: (id, val) ->
		item = items[id]
		return unless item

		if item.isHot
			item.x = val
			updateTransforms item
		else
			item.elem.style.left = val
			markAction item

	getItemY: getItemY = (id) ->
		item = items[id]
		return unless item
		item.y or parseFloat(item.elem.style.top) or 0

	setItemY: (id, val) ->
		item = items[id]
		return unless item

		if item.isHot
			item.y = val
			updateTransforms item
		else
			item.elem.style.top = val
			markAction item

	getItemZ: (id) ->
		val = items[id].elem?.style.zIndex

		if val is 'inherit'
			0
		else
			parseFloat(val) or 0

	setItemZ: (id, val) ->
		items[id]?.elem.style.zIndex = if val is 0 then 'inherit' else val

	getItemScale: (id) ->
		items[id]?.scale

	setItemScale: (id, val) ->
		item = items[id]
		return unless item
		item.scale = val
		updateTransforms item

	getItemRotation: (id) ->
		items[id]?.rotation

	setItemRotation: (id, val) ->
		item = items[id]
		return unless item
		item.rotation = val
		updateTransforms item

	getItemOpacity: (id) ->
		opacity = items[id]?.elem.style.opacity
		if opacity is '' then 1 else (parseFloat(opacity) or 0)

	setItemOpacity: (id, val) ->
		items[id]?.elem.style.opacity = val

	attachItemSignal: (id, name, func) ->
		elem = items[id]?.elem
		return unless elem

		signal = SIGNALS[name]?(elem, func) or SIGNALS[name]

		customFunc = (e) ->
			args = SIGNALS_ARGS[name]? e
			func args

		if typeof signal is 'string'
			elem.addEventListener signal, customFunc