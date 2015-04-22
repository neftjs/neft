'use strict'

utils = require 'utils'

module.exports = (impl) ->
	NOP = ->

	DATA = utils.merge
		bindings: null
		anchors: null
		update: null
	, impl.utils.fill.DATA

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->
		data.update = NOP

	setItemParent: (val) ->

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

	setItemMargin: (type, val) ->

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

	setItemKeysFocus: (val) ->

	setItemFill: (type, val) ->
		unless @_impl.disableFill
			if @_fill._width isnt @_fill._height
				impl.utils.fill.enable @
			else if val is false
				impl.utils.fill.disable @
		return