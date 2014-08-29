View File Unit
==============

Goals
-----

Represents *unit* - separated part of file which can be placed by elems.

	'use script'

	[utils, expect, signal] = ['utils', 'expect', 'signal'].map require

*class* Unit
------------

	module.exports = (File) -> class Unit extends File

		@__name__ = 'Unit'
		@__path__ = 'File.Unit'

		signal.create @, 'onCreate'

### Constructor(*File*, *string, *HTMLDivElement*)

		constructor: (self, @name, node) ->

			expect(self).toBe.any File
			expect(name).toBe.truthy().string()

			Unit.onCreate @, self

			# merge units from parent
			@units = utils.clone self.units
			delete @units[@name] # prevent circular structure

			@id = "#{self.path}:#{name}"

			@_node = node

### Properties

		id: ''
		name: ''

### Signals

		signal.defineGetter @::, 'onReplacedByElem'

		if utils.isNode
			@::parse = ->
				File.call @, @id, @_node
				delete @_node
