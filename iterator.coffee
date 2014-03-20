'use strict'

[assert, utils] = ['assert', 'utils'].map require

module.exports = (File) -> class Iterator extends File.Elem

	constructor: (@self, node) ->

		assert self instanceof File
		assert node instanceof File.Element

		prefix = if self.name then "#{self.name}-" else ''
		name = "#{prefix}each[#{utils.uid()}]"

		super self, name, node

		@storage = { i: 0 }

		# create unit
		@unit = new File.Unit self, name, @bodyNode
		@bodyNode.parent = undefined

	unit: null
	storage: null