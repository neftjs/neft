'use strict'

[utils, expect] = ['utils', 'expect'].map require

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
		@unit = unit.id
		@bodyNode.parent = undefined

	unit: ''
	storage: null
	array: null

	render: ->

		{node} = @

		return unless node.visible

		@getArray()

		each = node.attrs.get 'x:each'

		if not isArray(each) and not (each instanceof ObservableArray)
			node.visible = false
			return

		{unit} = @

		null

	revert: ->

		@clearArray()
		@node.visible = true

	getArray: ->

		each = @node.attrs.get 'x:each'

		# clear all if array changed
		if @array and @array isnt each
			@clearArray()

		return if @array is each

		data = @array = each

		if each instanceof ObservableArray
			each.onAdded.connect @addItem
			each.onRemoved.connect @removeItem
			{data} = each

		return unless isArray data

		for _, i in data
			@addItem i

		null

	clearArray: ->

		{array} = @

		data = array

		if array instanceof ObservableArray
			array.onAdded.disconnect @addItem
			array.onRemoved.disconnect @removeItem
			{data} = array

		{children} = @node
		while children.length
			children[children.length - 1].parent = undefined

		@array = null

		null

	addItem: (i) ->

		usedUnit = File.factory @unit

		data = @array
		if data instanceof ObservableArray
			{data} = data

		@storage =
			each: data
			i: i
			item: data[i]
		usedUnit.render @

		newChild = usedUnit.node

		# replace
		newChild.parent = @node

		if usedUnit.hasOwnProperty 'onReplacedByElem'
			usedUnit.onReplacedByElem @

	removeItem: (i) ->

		expect(@array).toBe.object()

		@node.children[i].parent = undefined

	clone: (original, self) ->

		clone = super

		clone.storage = utils.cloneDeep @storage
		clone.array = null

		clone.addItem = clone.addItem.bind clone
		clone.removeItem = clone.removeItem.bind clone

		clone.node.onAttrChanged.connect (attr) ->
			clone.getArray() if attr is 'x:each'

		clone