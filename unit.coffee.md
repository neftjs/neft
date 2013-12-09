View File Unit
==============

Goals
-----

Represents *unit* - separated part of file which can be placed by elems.

	'use script'

	assert = require 'assert'
	utils = require 'utils/index.coffee.md'

*class* Unit
------------

	module.exports = (File) -> class Unit extends File

### Static

#### *Unit* factory(*File*, *string*, *HTMLDivElement*)

		@factory = (self, name) ->

			assert self instanceof File
			assert name and typeof name is 'string'

			File.factory "#{self.path}:#{name}"

### Constructor(*File*, *string, *HTMLDivElement*)

		constructor: (self, @name, node) ->

			assert self instanceof File
			assert name and typeof name is 'string'

			# merge units from parent
			@units = utils.clone self.units
			delete @units[@name] # prevent circular structure

			super "#{self.path}:#{name}", node

### Properties

		name: ''