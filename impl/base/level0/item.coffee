'use strict'

utils = require 'utils'

module.exports = (impl) ->
	NOP = ->

	DATA =
		bindings: null
		anchors: null

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->

	setItemParent: (val) ->

	setItemIndex: (val) ->
		{parent} = @
		children = parent.children
		tmp = []
		impl.setItemParent.call @, null
		for i in [val...children.length] by 1
			child = children[i]
			if child isnt @
				impl.setItemParent.call child, null
				tmp.push child

		impl.setItemParent.call @, parent
		for item in tmp
			impl.setItemParent.call item, parent

		return

	setItemBackground: (val) ->

	setItemForeground: (val) ->

	setItemVisible: (val) ->

	setItemClip: (val) ->

	setItemWidth: (val) ->

	setItemHeight: (val) ->

	setItemX: (val) ->

	setItemY: (val) ->

	setItemZ: (val) ->

	setItemScale: (val) ->

	setItemRotation: (val) ->

	setItemOpacity: (val) ->

	setItemLinkUri: (val) ->

	doItemOverlap: (item) ->
		a = @
		b = item
		tmp = null

		x1 = a._x; y1 = a._y
		x2 = b._x; y2 = b._y

		parent1 = a
		while tmp = parent1._parent
			x1 += tmp._x
			y1 += tmp._y
			parent1 = tmp

		parent2 = b
		while tmp = parent2._parent
			x1 += tmp._x
			y1 += tmp._y
			parent2 = tmp

		parent1 is parent2 and
		x1 + a._width > x2 and
		y1 + a._height > y2 and
		x1 < x2 + b._width and
		y1 < y2 + b._height

	attachItemSignal: (name, signal) ->

	setItemPointerEnabled: (val) ->

	setItemPointerDraggable: (val) ->

	setItemPointerDragging: (val) ->

	setItemKeysFocus: (val) ->
