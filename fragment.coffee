'use script'

utils = require 'utils'
assert = require 'neft-assert'
signal = require 'signal'

assert = assert.scope 'View.Fragment'

module.exports = (File) -> class Fragment extends File

	@__name__ = 'Fragment'
	@__path__ = 'File.Fragment'

	constructor: (self, @name, node) ->
		assert.instanceOf self, File
		assert.isString name
		assert.notLengthOf name, 0

		# merge fragments from parent
		@fragments = utils.clone self.fragments
		delete @fragments?[@name] # prevent circular structure

		@id = "#{self.path}:#{name}"

		@_node = node

	id: ''
	name: ''

	if utils.isNode
		@::parse = ->
			File.call @, @id, @_node
			delete @_node