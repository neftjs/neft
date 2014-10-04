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
	'pointerWheel': 'wheel'

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

	getItemParent: (id) ->
		items[id]?.elem.parentElement?.id

	setItemParent: (id, val) ->
		items[val]?.elem.appendChild items[id].elem

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

	attachItemSignal: (id, name, signal) ->
		items[id]?.elem.addEventListener SIGNALS[name], -> signal()