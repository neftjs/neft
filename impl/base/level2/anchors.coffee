'use strict'

Binding = require '../../../types/item/binding'

module.exports = (impl) ->
	{items} = impl

	TYPES_VALUES =
		left: (target) ->
			if target is 'parent'
				"0"
			else
				"#{target}.x"
		top: (target) ->
			if target is 'parent'
				"0"
			else
				"#{target}.y"
		right: (target) ->
			r = "#{target}.width"
			if target isnt 'parent'
				r += " + #{target}.x"
			r
		bottom: (target) ->
			r = "#{target}.height"
			if target isnt 'parent'
				r += " + #{target}.y"
			r
		horizontalCenter: (target) ->
			r = TYPES_VALUES.left target
			r += " + #{target}.width/2"
			r
		verticalCenter: (target) ->
			r = TYPES_VALUES.top target
			r += " + #{target}.height/2"
			r

	MARGIN_FUNCS =
		left: (id) ->
			items[id].anchorMargins?.left
		top: (id) ->
			items[id].anchorMargins?.top
		right: (id) ->
			items[id].anchorMargins?.right
		bottom: (id) ->
			items[id].anchorMargins?.bottom

	TYPES_BINDINGS =
		left: (id, val) ->
			unless val
				return impl.setItemBinding id, 'x', null

			left = getAnchorValue val
			left = new Binding null, left
			impl.setItemBinding id, 'x', left, MARGIN_FUNCS.left
		top: (id, val) ->
			unless val
				return impl.setItemBinding id, 'y', null

			top = getAnchorValue val
			top = new Binding null, top
			impl.setItemBinding id, 'y', top, MARGIN_FUNCS.top
		right: (id, val) ->
			unless val
				return impl.setItemBinding id, 'x', null

			left = getAnchorValue(val) + " - this.width"
			left = new Binding null, left
			impl.setItemBinding id, 'x', left, MARGIN_FUNCS.right
		bottom: (id, val) ->
			unless val
				return impl.setItemBinding id, 'y', null

			top = getAnchorValue(val) + " - this.height"
			top = new Binding null, top
			impl.setItemBinding id, 'y', top, MARGIN_FUNCS.bottom
		horizontalCenter: (id, val) ->
			unless val
				return impl.setItemBinding id, 'x', null

			left = getAnchorValue(val) + " - this.width/2"
			left = new Binding null, left
			impl.setItemBinding id, 'x', left
		verticalCenter: (id, val) ->
			unless val
				return impl.setItemBinding id, 'y', null

			top = getAnchorValue(val) + " - this.height/2"
			top = new Binding null, top
			impl.setItemBinding id, 'y', top
		centerIn: (id, val) ->
			unless val
				TYPES_BINDINGS.horizontalCenter id, null
				TYPES_BINDINGS.verticalCenter id, null
				return

			TYPES_BINDINGS.horizontalCenter id, "#{val}.horizontalCenter"
			TYPES_BINDINGS.verticalCenter id, "#{val}.verticalCenter"
		fill: do ->
			WIDTH_MARGIN_FUNC = (id) ->
				- (MARGIN_FUNCS.left(id) or 0) - (MARGIN_FUNCS.right(id) or 0)
			HEIGHT_MARGIN_FUNC = (id) ->
				- (MARGIN_FUNCS.top(id) or 0) - (MARGIN_FUNCS.bottom(id) or 0)

			(id, val) ->
				unless val
					TYPES_BINDINGS.left id, null
					TYPES_BINDINGS.top id, null
					impl.setItemBinding id, 'width', null
					impl.setItemBinding id, 'height', null
					return

				TYPES_BINDINGS.left id, "#{val}.left"
				TYPES_BINDINGS.top id, "#{val}.top"

				width = new Binding null, "#{val}.width"
				impl.setItemBinding id, 'width', width, WIDTH_MARGIN_FUNC

				height = new Binding null, "#{val}.height"
				impl.setItemBinding id, 'height', height, HEIGHT_MARGIN_FUNC

	getAnchorValue = (val) ->
		dot = val.indexOf '.'
		if dot is -1
			dot = val.length

		target = val.slice 0, dot
		line = val.slice dot+1

		TYPES_VALUES[line] target

	impl.Types.Item.create = do (_super = impl.Types.Item.create) -> (id, target) ->
		target.anchorMargins = null

		_super id, target

	setItemAnchor: (id, type, val) ->
		TYPES_BINDINGS[type] id, val

	setItemAnchorMargin: (id, type, val) ->
		item = items[id]
		anchorMargins = item.anchorMargins ?= {}
		anchorMargins[type] = val