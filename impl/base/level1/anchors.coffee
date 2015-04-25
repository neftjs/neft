'use strict'

assert = require 'neft-assert'
log = require 'log'

log = log.scope 'Rendering', 'Anchors'

{isArray} = Array

module.exports = (impl) ->

	getItemProp =
		left: 'x'
		top: 'y'
		right: 'x'
		bottom: 'y'
		horizontalCenter: 'x'
		verticalCenter: 'y'
		fillWidth: 'width'
		fillHeight: 'height'

	getSourceWatchProps =
		left: []
		top: []
		right: ['onWidthChanged']
		bottom: ['onHeightChanged']
		horizontalCenter: ['onWidthChanged']
		verticalCenter: ['onHeightChanged']
		fillWidth: []
		fillHeight: []

	getTargetWatchProps =
		left:
			parent: []
			sibling: ['onXChanged']
		top:
			parent: []
			sibling: ['onYChanged']
		right:
			parent: ['onWidthChanged']
			sibling: ['onXChanged', 'onWidthChanged']
		bottom:
			parent: ['onHeightChanged']
			sibling: ['onYChanged', 'onHeightChanged']
		horizontalCenter:
			parent: ['onWidthChanged']
			sibling: ['onXChanged', 'onWidthChanged']
		verticalCenter:
			parent: ['onHeightChanged']
			sibling: ['onYChanged', 'onHeightChanged']
		fillWidth:
			parent: ['onWidthChanged']
			sibling: ['onWidthChanged']
		fillHeight:
			parent: ['onHeightChanged']
			sibling: ['onHeightChanged']

	getSourceValue =
		left: (item) ->
			0
		top: (item) ->
			0
		right: (item) ->
			- item._width
		bottom: (item) ->
			- item._height
		horizontalCenter: (item) ->
			- item._width / 2
		verticalCenter: (item) ->
			- item._height / 2
		fillWidth: (item) ->
			0
		fillHeight: (item) ->
			0

	getTargetValue =
		left:
			parent: (target) ->
				0
			sibling: (target) ->
				target._x
		top:
			parent: (target) ->
				0
			sibling: (target) ->
				target._y
		right:
			parent: (target) ->
				target._width
			sibling: (target) ->
				target._x + target._width
		bottom:
			parent: (target) ->
				target._height
			sibling: (target) ->
				target._y + target._height
		horizontalCenter:
			parent: (target) ->
				target._width / 2
			sibling: (target) ->
				target._x + target._width / 2
		verticalCenter:
			parent: (target) ->
				target._height / 2
			sibling: (target) ->
				target._y + target._height / 2
		fillWidth:
			parent: (target) ->
				target._width
			sibling: (target) ->
				target._width
		fillHeight:
			parent: (target) ->
				target._height
			sibling: (target) ->
				target._height

	getMarginValue =
		left: (margin) ->
			margin._left
		top: (margin) ->
			margin._top
		right: (margin) ->
			- margin._right
		bottom: (margin) ->
			- margin._bottom
		horizontalCenter: (margin) ->
			margin._left - margin._right
		verticalCenter: (margin) ->
			margin._top - margin._bottom
		fillWidth: (margin) ->
			- margin._left - margin._right
		fillHeight: (margin) ->
			- margin._top - margin._bottom

	onParentChanged = (oldVal) ->
		if oldVal
			for handler in getTargetWatchProps[@line].parent
				oldVal[handler].disconnect @update, @

		if val = @targetItem = @item._parent
			for handler in getTargetWatchProps[@line].parent
				val[handler] @update, @

		@update()
		return

	onNextSiblingChanged = (oldVal) ->
		if oldVal
			for handler in getTargetWatchProps[@line].sibling
				oldVal[handler].disconnect @update, @

		if val = @targetItem = @item._nextSibling
			for handler in getTargetWatchProps[@line].sibling
				val[handler] @update, @

		@update()
		return

	onPreviousSiblingChanged = (oldVal) ->
		if oldVal
			for handler in getTargetWatchProps[@line].sibling
				oldVal[handler].disconnect @update, @

		if val = @targetItem = @item._previousSibling
			for handler in getTargetWatchProps[@line].sibling
				val[handler] @update, @

		@update()
		return

	class Anchor
		constructor: (@item, @source, def) ->
			[target, line] = def
			@target = target
			@line = line

			if target is 'parent' or item._parent is target
				@type = 'parent'
			else
				@type = 'sibling'

			for handler in getSourceWatchProps[source]
				item[handler] @update, @

			@prop = getItemProp[source]
			@getSourceValue = getSourceValue[source]
			@getTargetValue = getTargetValue[line][@type]

			switch target
				when 'parent'
					@targetItem = item._parent
					item.onParentChanged onParentChanged, @
					onParentChanged.call @, null
				when 'nextSibling'
					@targetItem = item._nextSibling
					item.onNextSiblingChanged onNextSiblingChanged, @
					onNextSiblingChanged.call @, null
				when 'previousSibling'
					@targetItem = item._previousSibling
					item.onPreviousSiblingChanged onPreviousSiblingChanged, @
					onPreviousSiblingChanged.call @, null
				else
					@targetItem = target
					for handler in getTargetWatchProps[line][@type]
						target[handler] @update, @
					@update()

			Object.preventExtensions @

		update: ->
			if @targetItem
				`//<development>`
				if @item._parent isnt @targetItem and @item._parent isnt @targetItem._parent
					log.error "You can anchor only to a parent or sibling. Item: #{@item.toString()}"
				`//</development>`

				r = @getSourceValue(@item) + @getTargetValue(@targetItem)
			else
				r = 0
			if margin = @item._margin
				r += getMarginValue[@source] margin
			@item[@prop] = r
			return

		destroy: ->
			switch @target
				when 'parent'
					@item.onParentChanged.disconnect onParentChanged, @
				when 'nextSibling'
					@item.onNextSiblingChanged.disconnect onNextSiblingChanged, @
				when 'previousSibling'
					@item.onPreviousSiblingChanged.disconnect onPreviousSiblingChanged, @

			for handler in getSourceWatchProps[@source]
				@item[handler].disconnect @update, @

			if @targetItem
				for handler in getTargetWatchProps[@line][@type]
					@targetItem[handler].disconnect @update, @
			return

	getBaseAnchors =
		centerIn: ['horizontalCenter', 'verticalCenter']
		fill: ['horizontalCenter', 'verticalCenter', 'fillWidth', 'fillHeight']

	isMultiAnchor = (source) ->
		!!getBaseAnchors[source]

	class MultiAnchor
		constructor: (item, source, def) ->
			assert.lengthOf def, 1
			@anchors = []
			def = [def[0], '']

			for line in getBaseAnchors[source]
				def[1] = line
				anchor = new Anchor item, line, def
				@anchors.push anchor

		update: ->
			for anchor in @anchors
				anchor.update()
			return

		destroy: ->
			for anchor in @anchors
				anchor.destroy()
			return

	createAnchor = (item, source, def) ->
		if isMultiAnchor(source)
			new MultiAnchor item, source, def
		else
			new Anchor item, source, def

	exports =
	setItemAnchor: (type, val) ->
		if val isnt null
			assert.isArray val

		anchors = @_impl.anchors ?= {}

		if not val and not anchors[type]
			return

		if anchors[type]
			anchors[type].destroy()
			anchors[type] = null

		if val
			anchors[type] = createAnchor(@, type, val)

		return

	setItemMargin: do (_super = impl.setItemMargin) -> (type, val) ->
		_super.call @, type, val

		# TODO: update only needed anchors
		if anchors = @_impl.anchors
			for source, anchor of anchors
				anchor?.update()
		return
