'use script'

utils = require 'utils'
expect = require 'expect'
signal = require 'signal'

module.exports = (File) -> class Unit extends File

	@__name__ = 'Unit'
	@__path__ = 'File.Unit'

	signal.create @, 'created'

	constructor: (self, @name, node) ->

		expect(self).toBe.any File
		expect(name).toBe.truthy().string()

		Unit.created @, self

		# merge units from parent
		@units = utils.clone self.units
		delete @units?[@name] # prevent circular structure

		@id = "#{self.path}:#{name}"

		@_node = node

	id: ''
	name: ''

	if utils.isNode
		@::parse = ->
			File.call @, @id, @_node
			delete @_node