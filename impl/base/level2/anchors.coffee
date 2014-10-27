'use strict'

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
			item.anchors.margin.left
		top: (item) ->
			item.anchors.margin.top
		right: (item) ->
			- item.anchors.margin.right
		bottom: (item) ->
			- item.anchors.margin.bottom
		horizontalCenter: (item) ->
			MARGIN_FUNCS.left(item) + MARGIN_FUNCS.right(item)
		verticalCenter: (item) ->
			MARGIN_FUNCS.top(item) + MARGIN_FUNCS.bottom(item)

	BINDINGS_PROPS =
		left: ['x']
		top: ['y']
		right: ['x']
		bottom: ['y']
		horizontalCenter: ['x']
		verticalCenter: ['y']
		centerIn: ['x', 'y']
		fill: ['x', 'y', 'width', 'height']

	BINDINGS =
		left: (item, anchor) ->
			unless anchor
				return impl.setItemBinding.call item, 'x', null

			binding = getBindingValue item, anchor
			impl.setItemBinding.call item, 'x', binding, MARGIN_FUNCS.left
		top: (item, anchor) ->
			unless anchor
				return impl.setItemBinding.call item, 'y', null

			binding = getBindingValue item, anchor
			impl.setItemBinding.call item, 'y', binding, MARGIN_FUNCS.top
		right: (item, anchor) ->
			unless anchor
				return impl.setItemBinding.call item, 'x', null

			binding = getBindingValue item, anchor
			binding.push '-', [item, 'width']
			impl.setItemBinding.call item, 'x', binding, MARGIN_FUNCS.right
		bottom: (item, anchor) ->
			unless anchor
				return impl.setItemBinding.call item, 'y', null

			binding = getBindingValue item, anchor
			binding.push '-', [item, 'height']
			impl.setItemBinding.call item, 'y', binding, MARGIN_FUNCS.bottom
		horizontalCenter: (item, anchor) ->
			unless anchor
				return impl.setItemBinding.call item, 'x', null

			binding = getBindingValue item, anchor
			binding.push '-', [item, 'width'], '/2'
			impl.setItemBinding.call item, 'x', binding, MARGIN_FUNCS.horizontalCenter
		verticalCenter: (item, anchor) ->
			unless anchor
				return impl.setItemBinding.call item, 'y', null

			binding = getBindingValue item, anchor
			binding.push '-', [item, 'height'], '/2'
			impl.setItemBinding.call item, 'y', binding, MARGIN_FUNCS.verticalCenter
		centerIn: (item, anchor) ->
			unless anchor
				BINDINGS.horizontalCenter item, null
				BINDINGS.verticalCenter item, null
				return

			[target] = anchor

			BINDINGS.horizontalCenter item, [target, 'horizontalCenter']
			BINDINGS.verticalCenter item, [target, 'verticalCenter']
		fill: do ->
			WIDTH_MARGIN_FUNC = (item) ->
				- MARGIN_FUNCS.left(item) - MARGIN_FUNCS.right(item)
			HEIGHT_MARGIN_FUNC = (item) ->
				- MARGIN_FUNCS.top(item) - MARGIN_FUNCS.bottom(item)

			(item, anchor) ->
				unless anchor
					BINDINGS.left item, null
					BINDINGS.top item, null
					impl.setItemBinding.call item, 'width', null
					impl.setItemBinding.call item, 'height', null
					return

				[target] = anchor

				BINDINGS.left item, [target, 'left']
				BINDINGS.top item, [target, 'top']

				width = [[getBindingValue(item, anchor)[0], 'width']]
				impl.setItemBinding.call item, 'width', width, WIDTH_MARGIN_FUNC

				height = [[getBindingValue(item, anchor)[0], 'height']]
				impl.setItemBinding.call item, 'height', height, HEIGHT_MARGIN_FUNC

	setItemAnchor: (type, val) ->
		BINDINGS[type] @, val

	setItemAnchorMargin: (type, val) ->
		if bindings = @_impl.bindings
			for prop in BINDINGS_PROPS[type]
				bindings[prop]?.update()
		null