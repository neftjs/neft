'use strict'

assert = require 'assert'

{isArray} = Array

module.exports = (impl) ->
	{items} = impl

	PARENT = 1<<0
	THIS = 1<<1

	VALUES =
		left: (item, target, arr, opts) ->
			unless opts & PARENT
				arr.push [target, 'x']
		top: (item, target, arr, opts) ->
			unless opts & PARENT
				arr.push [target, 'y']
		right: (item, target, arr, opts) ->
			arr.push [target, 'width']
			unless opts & PARENT
				arr.push '+', [target, 'x']
		bottom: (item, target, arr, opts) ->
			arr.push [target, 'height']
			unless opts & PARENT
				arr.push '+', [target, 'y']
		horizontalCenter: (item, target, arr, opts) ->
			VALUES.left item, target, arr, opts
			arr.push '+', [target, 'width'], '/2'
		verticalCenter: (item, target, arr, opts) ->
			VALUES.top item, target, arr, opts
			arr.push '+', [target, 'height'], '/2'

	getBindingValue = (item, anchor) ->
		[target, line] = anchor

		opts = 0
		switch target
			when 'parent'
				opts |= PARENT
				target = [item, 'parent']
			when 'this'
				opts |= THIS
				target = item

		if line?
			arr = []
			VALUES[line]? item, target, arr, opts
			arr
		else
			[target]

	MARGIN_FUNCS =
		left: (item) ->
			item.margin.left
		top: (item) ->
			item.margin.top
		right: (item) ->
			- item.margin.right
		bottom: (item) ->
			- item.margin.bottom
		horizontalCenter: (item) ->
			MARGIN_FUNCS.left(item) + MARGIN_FUNCS.right(item)
		verticalCenter: (item) ->
			MARGIN_FUNCS.top(item) + MARGIN_FUNCS.bottom(item)
		fillWidth: (item) ->
			- MARGIN_FUNCS.left(item) + MARGIN_FUNCS.right(item)
		fillHeight: (item) ->
			- MARGIN_FUNCS.top(item) + MARGIN_FUNCS.bottom(item)

	MARGIN_FUNCS_BY_PROPS =
		x: [MARGIN_FUNCS.left, MARGIN_FUNCS.right, MARGIN_FUNCS.horizontalCenter]
		y: [MARGIN_FUNCS.top, MARGIN_FUNCS.bottom, MARGIN_FUNCS.verticalCenter]
		width: [MARGIN_FUNCS.fillWidth]
		height: [MARGIN_FUNCS.fillHeight]

	BINDINGS =
		left: (item, anchor) ->
			if anchor
				binding = getBindingValue item, anchor
				impl.setItemBinding.call item, 'x', binding, MARGIN_FUNCS.left
				item._impl.anchors.left = item._impl.bindings.x
			else
				if item._impl.anchors.left is item._impl.bindings.x
					impl.setItemBinding.call item, 'x', null
				item._impl.anchors.left = null
			return
		top: (item, anchor) ->
			if anchor
				binding = getBindingValue item, anchor
				impl.setItemBinding.call item, 'y', binding, MARGIN_FUNCS.top
				item._impl.anchors.top = item._impl.bindings.y
			else
				if item._impl.anchors.top is item._impl.bindings.y
					impl.setItemBinding.call item, 'y', null
				item._impl.anchors.top = null
			return
		right: (item, anchor) ->
			if anchor
				binding = getBindingValue item, anchor
				binding.push '-', [item, 'width']
				impl.setItemBinding.call item, 'x', binding, MARGIN_FUNCS.right
				item._impl.anchors.right = item._impl.bindings.x
			else
				if item._impl.anchors.right is item._impl.bindings.x
					impl.setItemBinding.call item, 'x', null
				item._impl.anchors.right = null
			return
		bottom: (item, anchor) ->
			if anchor
				binding = getBindingValue item, anchor
				binding.push '-', [item, 'height']
				impl.setItemBinding.call item, 'y', binding, MARGIN_FUNCS.bottom
				item._impl.anchors.bottom = item._impl.bindings.y
			else
				if item._impl.anchors.bottom is item._impl.bindings.y
					impl.setItemBinding.call item, 'y', null
				item._impl.anchors.bottom = null
			return
		horizontalCenter: (item, anchor) ->
			if anchor
				binding = getBindingValue item, anchor
				binding.push '-', [item, 'width'], '/2'
				impl.setItemBinding.call item, 'x', binding, MARGIN_FUNCS.horizontalCenter
				item._impl.anchors.horizontalCenter = item._impl.bindings.x
			else
				if item._impl.anchors.horizontalCenter is item._impl.bindings.x
					impl.setItemBinding.call item, 'x', null
				item._impl.anchors.horizontalCenter = null
			return
		verticalCenter: (item, anchor) ->
			if anchor
				binding = getBindingValue item, anchor
				binding.push '-', [item, 'height'], '/2'
				impl.setItemBinding.call item, 'y', binding, MARGIN_FUNCS.verticalCenter
				item._impl.anchors.verticalCenter = item._impl.bindings.y
			else
				if item._impl.anchors.verticalCenter is item._impl.bindings.y
					impl.setItemBinding.call item, 'y', null
				item._impl.anchors.verticalCenter = null
			return
		centerIn: (item, anchor) ->
			if anchor
				[target] = anchor

				BINDINGS.horizontalCenter item, [target, 'horizontalCenter']
				BINDINGS.verticalCenter item, [target, 'verticalCenter']
			else
				BINDINGS.horizontalCenter item, null
				BINDINGS.verticalCenter item, null
			return
		fill: (item, anchor) ->
			if anchor
				[target] = anchor

				BINDINGS.left item, [target, 'left']
				BINDINGS.top item, [target, 'top']

				width = [[getBindingValue(item, anchor)[0], 'width']]
				impl.setItemBinding.call item, 'width', width, MARGIN_FUNCS.fillWidth
				item._impl.anchors.fillWidth = item._impl.bindings.width

				height = [[getBindingValue(item, anchor)[0], 'height']]
				impl.setItemBinding.call item, 'height', height, MARGIN_FUNCS.fillHeight
				item._impl.anchors.fillHeight = item._impl.bindings.height
			else
				BINDINGS.left item, null
				BINDINGS.top item, null
				if item._impl.anchors.fillWidth is item._impl.bindings.width
					impl.setItemBinding.call item, 'width', null
				if item._impl.anchors.fillHeight is item._impl.bindings.height
					impl.setItemBinding.call item, 'height', null
				item._impl.anchors.fillWidth = null
				item._impl.anchors.fillHeight = null
			return

	COLLISIONS =
		top:
			['verticalCenter', 'centerIn', 'fill']
		bottom:
			['verticalCenter', 'centerIn', 'fill']
		left:
			['horizontalCenter', 'centerIn', 'fill']
		right:
			['horizontalCenter', 'centerIn', 'fill']
		verticalCenter:
			['top', 'bottom', 'centerIn', 'fill']
		horizontalCenter:
			['left', 'right', 'centerIn', 'fill']
		centerIn:
			['top', 'bottom', 'left', 'right', 'verticalCenter', 'horizontalCenter', 'fill']
		fill:
			['top', 'bottom', 'left', 'right', 'verticalCenter', 'horizontalCenter', 'centerIn']

	ANCHORS_PROPS =
		x: ['left', 'right', 'horizontalCenter', 'centerIn', 'fill']
		y: ['top', 'bottom', 'verticalCenter', 'centerIn', 'fill']
		width: ['fill']
		height: ['fill']

	ANCHORS_BY_PROPS =
		left: ['x']
		right: ['x']
		horizontalCenter: ['x']
		top: ['y']
		bottom: ['y']
		verticalCenter: ['y']
		centerIn: ['x', 'y']
		fill: ['x', 'y', 'width', 'height']

	BINDINGS_PROPS =
		left: ['x', 'width']
		top: ['y', 'height']
		right: ['x', 'width']
		bottom: ['y', 'height']

	exports =
	setItemAnchor: (type, val) ->
		if val isnt null
			assert.isArray val

		anchors = @_impl.anchors ?= {}

		if not val and not anchors[type]
			return

		if val isnt null
			collisions = COLLISIONS[type]
			for collision in collisions
				if anchors[collision]
					exports.setItemAnchor.call @, collision, null

		BINDINGS[type](@, val)

		if val is null
			# reset x, y, width, height if no anchors exists
			props = ANCHORS_BY_PROPS[type]
			for prop in props
				unless @_impl.bindings[prop]
					@[prop] = 0

		return

	setItemMargin: do (_super = impl.setItemMargin) -> (type, val) ->
		_super.call @, type, val

		if bindings = @_impl.bindings
			for prop in BINDINGS_PROPS[type]
				bindings[prop]?.update()
		return