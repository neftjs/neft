'use strict'

Binding = require '../../../item/binding'

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
			left = getAnchorValue val
			left = Binding.factory left
			impl.setItemBinding id, 'x', left, MARGIN_FUNCS.left
		top: (id, val) ->
			top = getAnchorValue val
			top = Binding.factory top
			impl.setItemBinding id, 'y', top, MARGIN_FUNCS.top
		right: (id, val) ->
			left = getAnchorValue(val) + " - this.width"
			left = Binding.factory left
			impl.setItemBinding id, 'x', left, MARGIN_FUNCS.right
		bottom: (id, val) ->
			top = getAnchorValue(val) + " - this.height"
			top = Binding.factory top
			impl.setItemBinding id, 'y', top, MARGIN_FUNCS.bottom
		horizontalCenter: (id, val) ->
			left = getAnchorValue(val) + " - this.width/2"
			left = Binding.factory left
			impl.setItemBinding id, 'x', left
		verticalCenter: (id, val) ->
			top = getAnchorValue(val) + " - this.height/2"
			top = Binding.factory top
			impl.setItemBinding id, 'y', top
		centerIn: (id, val) ->
			TYPES_BINDINGS.horizontalCenter id, "#{val}.horizontalCenter"
			TYPES_BINDINGS.verticalCenter id, "#{val}.verticalCenter"
		fill: do ->
			WIDTH_MARGIN_FUNC = (id) ->
				- (MARGIN_FUNCS.left(id) or 0) - (MARGIN_FUNCS.right(id) or 0)
			HEIGHT_MARGIN_FUNC = (id) ->
				- (MARGIN_FUNCS.top(id) or 0) - (MARGIN_FUNCS.bottom(id) or 0)

			(id, val) ->
				TYPES_BINDINGS.left id, "#{val}.left"
				TYPES_BINDINGS.top id, "#{val}.top"

				width = Binding.factory "#{val}.width"
				impl.setItemBinding id, 'width', width, WIDTH_MARGIN_FUNC

				height = Binding.factory "#{val}.height"
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