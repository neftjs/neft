View File Unit
==============

Goals
-----

Represents *unit* - separated part of file which can be placed by elems.

	'use script'

	[utils, expect] = ['utils', 'expect'].map require

*class* Unit
------------

	module.exports = (File) -> class Unit extends File

		@__name__ = 'Unit'
		@__path__ = 'File.Unit'

### Constructor(*File*, *string, *HTMLDivElement*)

		constructor: (self, @name, node) ->

			expect(self).toBe.any File
			expect(name).toBe.truthy().string()

			# merge units from parent
			@units = utils.clone self.units
			delete @units[@name] # prevent circular structure

			@id = "#{self.path}:#{name}"

			super @id, node

### Properties

		id: ''
		name: ''