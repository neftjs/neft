'use strict'

[utils, expect] = ['utils', 'expect'].map require

{isArray} = Array

module.exports = (File) -> class Iterator extends File.Elem

	@__name__ = 'Iterator'
	@__path__ = 'File.Iterator'

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
	data: null

	render: ->

		{node} = @

		return unless node.visible

		@getData()

		each = node.attrs.get 'each'

		unless isArray each
			node.visible = false
			file._tmp.visibleChanges.push node
			return

		{unit} = @
		{usedUnits, parentChanges} = @self._tmp

		null

	revert: ->

		@clearData()

	clearData: ->

		{data} = @

		return unless isArray data

		data.onAdded?.disconnect @addItem
		data.onRemoved?.disconnect @removeItem

		for _, i in data
			@removeItem 0

		@data = null

		null

	getData: ->

		each = @node.attrs.get 'each'

		if @data and @data isnt each
			@clearData()

		return if @data is each
		return unless isArray each

		@data = each
		each.onAdded?.connect @addItem
		each.onRemoved?.connect @removeItem

		for _, i in each
			@addItem i

		null

	addItem: (i) ->

		usedUnit = File.factory @unit

		@storage = i: i
		usedUnit.render @

		@self._tmp.usedUnits.push usedUnit

		newChild = usedUnit.node

		# replace
		newChild.parent = @node

	removeItem: (i) ->

		expect(@data).toBe.array()
		expect(@data[i]).not().toBe undefined

		@node.children[i].parent = undefined

	clone: (original, self) ->

		clone = super

		clone.storage = utils.cloneDeep @storage
		clone.data = null

		clone.addItem = clone.addItem.bind clone
		clone.removeItem = clone.removeItem.bind clone

		clone.node.onAttrChanged.connect (attr) ->
			clone.getData() if attr is 'each'

		clone