'use strict'

[utils, expect] = ['utils', 'expect'].map require

module.exports = (File) -> class Iterator extends File.Elem

	@__name__ = 'Iterator'
	@__path__ = 'File.Iterator'

	constructor: (@self, node) ->

		expect(self).toBe.any File
		expect(node).toBe.any File.Element

		prefix = if self.name then "#{self.name}-" else ''
		name = "#{prefix}each[#{utils.uid()}]"

		super self, name, node

		@storage = i: 0

		# create unit
		unit = new File.Unit self, name, @bodyNode
		@unit = unit.id
		@bodyNode.parent = undefined

	unit: ''
	storage: null

	render: ->

	revert: ->

	clone: (original, self) ->

		clone = super

		clone.storage = utils.cloneDeep @storage

		clone