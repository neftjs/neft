'use strict'

[utils, expect, List] = ['utils', 'expect', 'list'].map require

{isArray} = Array

module.exports = (File) -> class Iterator extends File.Elem

	@__name__ = 'Iterator'
	@__path__ = 'File.Iterator'

	{ObservableArray} = File

	constructor: (@self, node) ->

		expect(self).toBe.any File
		expect(node).toBe.any File.Element

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
		if @node.visible
			@update()

	revert: ->
		@update()
		@node.visible = true

	update: ->

		{data} = @
		each = @node.attrs.get 'x:each'

		# clear all if data changed
		if data and data isnt each
			if data instanceof List
				array.onChanged.disconnect @updateItem
				array.onInserted.disconnect @insertItem
				array.onPopped.disconnect @popItem

			@clearData()

		# stop if no data found
		if not isArray(each) and not (each instanceof List)
			@node.visible = false
			return

		# stop if nothing changed
		return if @data is each

		# set as data
		@data = array = each

		# listen on changes
		if each instanceof List
			each.onChanged.connect @updateItem
			each.onInserted.connect @insertItem
			each.onPopped.connect @popItem

			array = each.items()

		# add items
		for _, i in array
			@insertItem i

		@

	clearData: ->
		expect(@data).toBe.object()

		while length = @usedUnits.length
			@popItem length - 1

		@

	updateItem: (i) ->
		expect(@data).toBe.object()
		expect(i).toBe.integer()

		@popItem i
		@insertItem i

		@

	insertItem: (i) ->
		expect(@data).toBe.object()
		expect(i).toBe.integer()

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
		if usedUnit.hasOwnProperty 'onReplacedByElem'
			usedUnit.onReplacedByElem @

		@

	popItem: (i) ->
		expect(@data).toBe.object()
		expect(i).toBe.integer()

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

		clone.updateItem = @updateItem.bind clone
		clone.insertItem = @insertItem.bind clone
		clone.popItem = @popItem.bind clone

		clone.node.onAttrChanged.connect (attr) ->
			clone.update() if attr is 'x:each'

		clone