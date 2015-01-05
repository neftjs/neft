'use script'

utils = require 'utils'
assert = require 'assert'
signal = require 'signal'

assert = assert.scope 'View.Unit'

module.exports = (File) -> class Unit extends File

	@__name__ = 'Unit'
	@__path__ = 'File.Unit'

	signal.create @, 'created'

	constructor: (self, @name, node) ->
		assert.instanceOf self, File
		assert.isString name
		assert.notLengthOf name, 0

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