'use strict'

Binding = require '../../../item/binding'

module.exports = (impl) ->

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

	TYPES_BINDINGS =
		left: (id, val) ->
			left = getAnchorValue val
			left = Binding.factory left
			impl.setItemBinding id, 'x', left
		top: (id, val) ->
			top = getAnchorValue val
			top = Binding.factory top
			impl.setItemBinding id, 'y', top
		right: (id, val) ->
			left = getAnchorValue(val) + " - this.width"
			left = Binding.factory left
			impl.setItemBinding id, 'x', left
		bottom: (id, val) ->
			top = getAnchorValue(val) + " - this.height"
			top = Binding.factory top
			impl.setItemBinding id, 'y', top
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
		fill: (id, val) ->
			TYPES_BINDINGS.left id, "#{val}.left"
			TYPES_BINDINGS.top id, "#{val}.top"

			width = Binding.factory "#{val}.width"
			impl.setItemBinding id, 'width', width

			height = Binding.factory "#{val}.height"
			impl.setItemBinding id, 'height', height

	getAnchorValue = (val) ->
		dot = val.indexOf '.'
		if dot is -1
			dot = val.length

		target = val.slice 0, dot
		line = val.slice dot+1

		TYPES_VALUES[line] target

	setItemAnchor: (id, type, val) ->
		TYPES_BINDINGS[type] id, val