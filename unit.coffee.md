View File Unit
==============

Goals
-----

Represents *unit* - separated part of file which can be placed by elems.

	'use script'

	[utils] = ['utils'].map require

	{assert} = console

*class* Unit
------------

	module.exports = (File) -> class Unit extends File

		@__name__ = 'Unit'
		@__path__ = 'File.Unit'

### Constructor(*File*, *string, *HTMLDivElement*)

		constructor: (self, @name, node) ->

			assert self instanceof File
			assert name and typeof name is 'string'

			# merge units from parent
			@units = utils.clone self.units
			delete @units[@name] # prevent circular structure

			@id = "#{self.path}:#{name}"

			super @id, node

### Properties

		id: ''
		name: ''