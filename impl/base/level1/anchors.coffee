'use strict'

assert = require 'neft-assert'
log = require 'log'

log = log.scope 'Rendering', 'Anchors'

{isArray} = Array

module.exports = (impl) ->
	NOP = ->

	getItemProp =
		left: 'x'
		top: 'y'
		right: 'x'
		bottom: 'y'
		horizontalCenter: 'x'
		verticalCenter: 'y'
		fillWidthSize: 'width'
		fillHeightSize: 'height'

	getSourceWatchProps =
		left: []
		top: []
		right: ['onWidthChange']
		bottom: ['onHeightChange']
		horizontalCenter: ['onWidthChange']
		verticalCenter: ['onHeightChange']
		fillWidthSize: []
		fillHeightSize: []

	getTargetWatchProps =
		left:
			parent: []
			sibling: ['onXChange']
		top:
			parent: []
			sibling: ['onYChange']
		right:
			parent: ['onWidthChange']
			sibling: ['onXChange', 'onWidthChange']
		bottom:
			parent: ['onHeightChange']
			sibling: ['onYChange', 'onHeightChange']
		horizontalCenter:
			parent: ['onWidthChange']
			sibling: ['onXChange', 'onWidthChange']
		verticalCenter:
			parent: ['onHeightChange']
			sibling: ['onYChange', 'onHeightChange']
		fillWidthSize:
			parent: ['onWidthChange']
			children: []
			sibling: ['onWidthChange']
		fillHeightSize:
			parent: ['onHeightChange']
			children: []
			sibling: ['onHeightChange']

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
		fillWidthSize: (item) ->
			0
		fillHeightSize: (item) ->
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
		fillWidthSize:
			parent: (target) ->
				target._width
			children: (target) ->
				tmp = 0
				size = 0
				for child in target
					if child._visible
						tmp = Math.abs(child._x) + child._width
						if tmp > size
							size = tmp
				size
			sibling: (target) ->
				target._width
		fillHeightSize:
			parent: (target) ->
				target._height
			children: (target) ->
				tmp = 0
				size = 0
				for child in target
					if child._visible
						tmp = Math.abs(child._y) + child._height
						if tmp > size
							size = tmp
				size
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
		fillWidthSize: (margin) ->
			- margin._left - margin._right
		fillHeightSize: (margin) ->
			- margin._top - margin._bottom

	onParentChange = (oldVal) ->
		if oldVal
			for handler in getTargetWatchProps[@line].parent
				oldVal[handler].disconnect @update, @

		if val = @targetItem = @item._parent
			for handler in getTargetWatchProps[@line].parent
				val[handler] @update, @

		@update()
		return

	onNextSiblingChange = (oldVal) ->
		if oldVal
			for handler in getTargetWatchProps[@line].sibling
				oldVal[handler].disconnect @update, @

		if val = @targetItem = @item._nextSibling
			for handler in getTargetWatchProps[@line].sibling
				val[handler] @update, @

		@update()
		return

	onPreviousSiblingChange = (oldVal) ->
		if oldVal
			for handler in getTargetWatchProps[@line].sibling
				oldVal[handler].disconnect @update, @

		if val = @targetItem = @item._previousSibling
			for handler in getTargetWatchProps[@line].sibling
				val[handler] @update, @

		@update()
		return

	onChildInsert = (child) ->
		child.onVisibleChange @update, @
		if @source is 'fillWidthSize'
			child.onXChange @update, @
			child.onWidthChange @update, @
		if @source is 'fillHeightSize'
			child.onYChange @update, @
			child.onHeightChange @update, @

		@update()
		return

	onChildPop = (child) ->
		child.onVisibleChange.disconnect @update, @
		if @source is 'fillWidthSize'
			child.onXChange.disconnect @update, @
			child.onWidthChange.disconnect @update, @
		if @source is 'fillHeightSize'
			child.onYChange.disconnect @update, @
			child.onHeightChange.disconnect @update, @

		@update()
		return

	class Anchor
		constructor: (@item, @source, def) ->
			[target, line] = def
			@target = target
			@line = line

			if target is 'parent' or item._parent is target
				@type = 'parent'
			else if target is 'children'
				@type = 'children'
			else
				@type = 'sibling'

			for handler in getSourceWatchProps[source]
				item[handler] @update, @

			@prop = getItemProp[source]
			@getSourceValue = getSourceValue[source]
			@getTargetValue = getTargetValue[line][@type]

			if typeof @getTargetValue isnt 'function'
				@getTargetValue = NOP
				log.error "Anchor '#{@source}: #{def.join('.')}' is not supported"

			switch target
				when 'parent'
					@targetItem = item._parent
					item.onParentChange onParentChange, @
					onParentChange.call @, null
				when 'children'
					@targetItem = item._children
					item.children.onInsert onChildInsert, @
					item.children.onPop onChildPop, @
					for child in item.children
						onChildInsert.call @, child
				when 'nextSibling'
					@targetItem = item._nextSibling
					item.onNextSiblingChange onNextSiblingChange, @
					onNextSiblingChange.call @, null
				when 'previousSibling'
					@targetItem = item._previousSibling
					item.onPreviousSiblingChange onPreviousSiblingChange, @
					onPreviousSiblingChange.call @, null
				else
					@targetItem = item._component.objects[target]
					for handler in getTargetWatchProps[line][@type]
						@targetItem[handler] @update, @
					@update()

			Object.preventExtensions @

		update: ->
			# sometimes it could be already destroyed
			unless @item
				return

			# targetItem can be possibly different than actual value;
			# e.g. when Anchor listener to change targetItem is not called firstly
			switch @target
				when 'parent'
					targetItem = @item._parent
				when 'children'
					targetItem = @item._children
				when 'nextSibling'
					targetItem = @item._nextSibling
				when 'previousSibling'
					targetItem = @item._previousSibling
				else
					{targetItem} = @
			if targetItem isnt @targetItem
				return

			if targetItem
				`//<development>`
				if targetItem isnt @item._children and @item._parent isnt targetItem and @item._parent isnt targetItem._parent
					log.error "You can anchor only to a parent or sibling. Item: #{@item.toString()}"
				`//</development>`

				r = @getSourceValue(@item) + @getTargetValue(targetItem)
			else
				r = 0
			if (margin = @item._margin) and targetItem isnt @item._children
				r += getMarginValue[@source] margin
			@item[@prop] = r
			return

		destroy: ->
			switch @target
				when 'parent'
					@item.onParentChange.disconnect onParentChange, @
				when 'children'
					@item.children.onInsert.disconnect onChildInsert, @
					@item.children.onPop.disconnect onChildPop, @
					for child in @item.children
						onChildPop.call @, child, -1
				when 'nextSibling'
					@item.onNextSiblingChange.disconnect onNextSiblingChange, @
				when 'previousSibling'
					@item.onPreviousSiblingChange.disconnect onPreviousSiblingChange, @

			for handler in getSourceWatchProps[@source]
				@item[handler].disconnect @update, @

			if @targetItem
				for handler in getTargetWatchProps[@line][@type]
					@targetItem[handler].disconnect @update, @

			@item = @targetItem = null
			return

	getBaseAnchors =
		centerIn: ['horizontalCenter', 'verticalCenter']
		fillWidth: ['horizontalCenter', 'fillWidthSize']
		fillHeight: ['verticalCenter', 'fillHeightSize']
		fill: ['horizontalCenter', 'verticalCenter', 'fillWidthSize', 'fillHeightSize']

	getBaseAnchorsPerAnchorType =
		__proto__: null
		children:
			fillWidth: ['fillWidthSize']
			fillHeight: ['fillHeightSize']
			fill: ['fillWidthSize', 'fillHeightSize']

	isMultiAnchor = (source) ->
		!!getBaseAnchors[source]

	class MultiAnchor
		constructor: (item, source, def) ->
			assert.lengthOf def, 1
			@anchors = []
			def = [def[0], '']

			baseAnchors = getBaseAnchorsPerAnchorType[def[0]]?[source]
			baseAnchors ?= getBaseAnchors[source]
			for line in baseAnchors
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
