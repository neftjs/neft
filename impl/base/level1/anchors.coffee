'use strict'

assert = require 'neft-assert'
log = require 'log'

log = log.scope 'Renderer', 'Anchors'

{isArray} = Array

module.exports = (impl) ->
	NOP = ->

	MAX_LOOPS = 10

	queueIndex = 0
	queues = [[], []]
	queue = queues[queueIndex]
	pending = false

	updateItems = ->
		pending = false
		currentQueue = queue
		queue = queues[++queueIndex % queues.length]

		while currentQueue.length
			anchor = currentQueue.pop()
			anchor.pending = false
			anchor.update()
		return

	update = ->
		if @pending
			return

		@pending = true
		queue.push @
		unless pending
			setImmediate updateItems
			pending = true
		return

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
		left: ['onMarginChange']
		top: ['onMarginChange']
		right: ['onMarginChange', 'onWidthChange']
		bottom: ['onMarginChange', 'onHeightChange']
		horizontalCenter: ['onMarginChange', 'onWidthChange']
		verticalCenter: ['onMarginChange', 'onHeightChange']
		fillWidth: ['onPaddingChange']
		fillHeight: ['onPaddingChange']

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
		fillWidth:
			parent: ['onWidthChange']
			children: []
			sibling: ['onWidthChange']
		fillHeight:
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
			children: (target) ->
				tmp = 0
				size = 0
				for child in target
					if child._visible
						tmp = child._width
						if tmp > size
							size = tmp
				size
			sibling: (target) ->
				target._width
		fillHeight:
			parent: (target) ->
				target._height
			children: (target) ->
				tmp = 0
				size = 0
				for child in target
					if child._visible
						tmp = child._height
						if tmp > size
							size = tmp
				size
			sibling: (target) ->
				target._height

	NOP_VALUE_GETTER = (arg1) -> 0

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
		fillWidth: NOP_VALUE_GETTER
		fillHeight: NOP_VALUE_GETTER

	getPaddingValue =
		left: NOP_VALUE_GETTER
		top: NOP_VALUE_GETTER
		right: NOP_VALUE_GETTER
		bottom: NOP_VALUE_GETTER
		horizontalCenter: NOP_VALUE_GETTER
		verticalCenter: NOP_VALUE_GETTER
		fillWidth: (padding) ->
			padding._left + padding._right
		fillHeight: (padding) ->
			padding._top + padding._bottom

	onParentChange = (oldVal) ->
		if oldVal
			for handler in getTargetWatchProps[@line].parent
				oldVal[handler].disconnect update, @

		if val = @targetItem = @item._parent
			for handler in getTargetWatchProps[@line].parent
				val[handler] update, @

		update.call @
		return

	onNextSiblingChange = (oldVal) ->
		if oldVal
			for handler in getTargetWatchProps[@line].sibling
				oldVal[handler].disconnect update, @

		if val = @targetItem = @item._nextSibling
			for handler in getTargetWatchProps[@line].sibling
				val[handler] update, @

		update.call @
		return

	onPreviousSiblingChange = (oldVal) ->
		if oldVal
			for handler in getTargetWatchProps[@line].sibling
				oldVal[handler].disconnect update, @

		if val = @targetItem = @item._previousSibling
			for handler in getTargetWatchProps[@line].sibling
				val[handler] update, @

		update.call @
		return

	onChildInsert = (child) ->
		child.onVisibleChange update, @
		if @source is 'fillWidth'
			child.onWidthChange update, @
		if @source is 'fillHeight'
			child.onHeightChange update, @

		update.call @
		return

	onChildPop = (child) ->
		child.onVisibleChange.disconnect update, @
		if @source is 'fillWidth'
			child.onWidthChange.disconnect update, @
		if @source is 'fillHeight'
			child.onHeightChange.disconnect update, @

		update.call @
		return

	class Anchor
		pool = []

		@factory = (item, source, def) ->
			if elem = pool.pop()
				Anchor.call elem, item, source, def
				elem
			else
				new Anchor item, source, def

		constructor: (@item, @source, def) ->
			[target, line] = def
			line ?= source
			@target = target
			@line = line
			@pending = false
			@updateLoops = 0

			if target is 'parent' or item._parent is target
				@type = 'parent'
			else if target is 'children'
				@type = 'children'
			else
				@type = 'sibling'

			for handler in getSourceWatchProps[source]
				item[handler] update, @

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
					if @targetItem = target
						for handler in getTargetWatchProps[line][@type]
							@targetItem[handler] update, @
					update.call @

			Object.preventExtensions @

		update: ->
			# sometimes it can be already destroyed
			if not @item or @updateLoops >= MAX_LOOPS
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
			if not targetItem or targetItem isnt @targetItem
				return

			if targetItem
				`//<development>`
				if @item._parent and targetItem isnt @item._children and @item._parent isnt targetItem and @item._parent isnt targetItem._parent
					log.error "You can anchor only to a parent or sibling. Item '#{@item.toString()}.anchors.#{@source}: #{@target}'"
				`//</development>`

				r = @getSourceValue(@item) + @getTargetValue(targetItem)
			else
				r = 0
			if margin = @item._margin
				r += getMarginValue[@source] margin
			if padding = @item._padding
				r += getPaddingValue[@source] padding

			@updateLoops++
			@item[@prop] = r
			if @updateLoops is MAX_LOOPS
				log.error "Potential anchors loop detected. Recalculating on this anchor (#{@}) has been disabled."
				@updateLoops++
			else if @updateLoops < MAX_LOOPS
				@updateLoops--
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
				@item[handler].disconnect update, @

			if @targetItem
				for handler in getTargetWatchProps[@line][@type]
					@targetItem[handler].disconnect update, @

			@item = @targetItem = null

			pool.push @
			return

		toString: ->
			"#{@item.toString()}.anchors.#{@source}: #{@target}.#{@line}"

	getBaseAnchors =
		centerIn: ['horizontalCenter', 'verticalCenter']
		fill: ['fillWidth', 'fillHeight']

	getBaseAnchorsPerAnchorType =
		__proto__: null

	isMultiAnchor = (source) ->
		!!getBaseAnchors[source]

	class MultiAnchor
		pool = []

		@factory = (item, source, def) ->
			if elem = pool.pop()
				MultiAnchor.call elem, item, source, def
				elem
			else
				new MultiAnchor item, source, def

		constructor: (item, source, def) ->
			assert.lengthOf def, 1
			@anchors = []
			def = [def[0], '']
			@pending = false

			baseAnchors = getBaseAnchorsPerAnchorType[def[0]]?[source]
			baseAnchors ?= getBaseAnchors[source]
			for line in baseAnchors
				def[1] = line
				anchor = Anchor.factory item, line, def
				@anchors.push anchor
			return

		update: ->
			for anchor in @anchors
				anchor.update()
			return

		destroy: ->
			for anchor in @anchors
				anchor.destroy()
			pool.push @
			return

	createAnchor = (item, source, def) ->
		if isMultiAnchor(source)
			MultiAnchor.factory item, source, def
		else
			Anchor.factory item, source, def

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
