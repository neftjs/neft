'use strict'

utils = require 'utils'
assert = require 'assert'
List = require 'list'
log = require 'log'

{isArray} = Array

assert = assert.scope 'View.Iterator'
log = log.scope 'View', 'Iterator'

module.exports = (File) -> class Iterator extends File.Use
	@__name__ = 'Iterator'
	@__path__ = 'File.Iterator'

	@HTML_ATTR = "#{File.HTML_NS}:each"

	constructor: (@self, node) ->
		assert.instanceOf self, File
		assert.instanceOf node, File.Element

		prefix = if self.name then "#{self.name}-" else ''
		name = "#{prefix}each[#{utils.uid()}]"

		super self, name, node

		# create unit
		unit = new File.Unit self, name, @bodyNode
		unit.parse()
		@unit = unit.id
		@bodyNode.parent = undefined

	unit: ''
	storage: null
	usedUnits: null
	data: null

	render: ->
		unless @node.visible
			return

		each = @node.attrs.get Iterator.HTML_ATTR

		# stop if nothing changed
		if each is @data
			return

		# stop if no data found
		if not isArray(each) and not (each instanceof List)
			log.warn "Data is not an array or a List:\n#{each}"
			return

		# set as data
		@data = array = each

		# listen on changes
		if each instanceof List
			each.onChanged @updateItem
			each.onInserted @insertItem
			each.onPopped @popItem

			array = each.items()

		# add items
		for _, i in array
			@insertItem i

		null

	revert: ->
		{data} = @

		if data
			@clearData()

			if data instanceof List
				data.onChanged.disconnect @updateItem
				data.onInserted.disconnect @insertItem
				data.onPopped.disconnect @popItem

		@data = null

	update: ->
		@revert()
		@render()

	clearData: ->
		assert.isObject @data

		while length = @usedUnits.length
			@popItem length - 1

		@

	updateItem: (elem, i) ->
		unless i?
			i = elem

		assert.isObject @data
		assert.isInteger i

		@popItem i
		@insertItem i

		@

	insertItem: (elem, i) ->
		unless i?
			i = elem

		assert.isObject @data
		assert.isInteger i

		{data} = @

		usedUnit = File.factory @unit
		@usedUnits.splice i, 0, usedUnit

		if data instanceof List
			each = data.items()
			item = data.get i
		else
			each = data
			item = data[i]

		# render unit with storage
		storage = usedUnit.storage = Object.create @self.storage or null
		storage.each = each
		storage.i = i
		storage.item = item
		usedUnit.render @

		# replace
		newChild = usedUnit.node
		newChild.parent = @node
		newChild.index = i

		# signal
		usedUnit.replacedByUse @

		@

	popItem: (elem, i) ->
		unless i?
			i = elem

		assert.isObject @data
		assert.isInteger i

		@node.children[i].parent = undefined

		usedUnit = @usedUnits[i]
		usedUnit.revert().destroy()
		@usedUnits.splice i, 1

		@

	clone: (original, self) ->
		clone = super

		clone.storage = utils.cloneDeep @storage
		clone.array = null
		clone.usedUnits = []

		clone.updateItem = (arg1, arg2) => @updateItem.call clone, arg1, arg2
		clone.insertItem = (arg1, arg2) => @insertItem.call clone, arg1, arg2
		clone.popItem = (arg1, arg2) => @popItem.call clone, arg1, arg2

		clone.node.on 'attrChanged', (e) ->
			if self.isRendered and e.name is Iterator.HTML_ATTR
				clone.update()

		clone.node.on 'visibilityChanged', (oldVal) ->
			if self.isRendered and oldVal is false and not @data
				clone.update()

		clone