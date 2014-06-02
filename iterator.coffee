'use strict'

[utils] = ['utils'].map require

{assert} = console

module.exports = (File) -> class Iterator extends File.Elem

	@__name__ = 'Iterator'
	@__path__ = 'File.Iterator'

	constructor: (@self, node) ->

		assert self instanceof File
		assert node instanceof File.Element

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

	clone: (original, self) ->

		clone = super

		clone.storage = utils.cloneDeep @storage

		clone