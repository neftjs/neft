View File Unit
==============

Goals
-----

Represents *unit* - separated part of dom which can be placed by elems.

	'use script'

	assert = require 'assert'
	utils = require 'utils/index.coffee.md'

*class* Unit
------------

	clones = {}

	module.exports = (File) -> class Unit extends File

### Static

#### *Unit* factory(*File*, *string*, *HTMLDivElement*)

		@factory = do ->

			cache = {}

			(self, name, dom) ->

				assert self instanceof File
				assert typeof name is 'string'
				assert name

				unless (cached = cache[self.path]?[name])?
					forPath = cache[self.path] ?= {}
					cached = forPath[name] = new Unit self, name, dom

				cached

### Constructor(*File*, *string, *HTMLDivElement*)

		constructor: (@self, @name, @dom) ->

			assert self instanceof File
			assert typeof name is 'string'
			assert name

			# merge units from parent
			@units = utils.clone self.units
			delete @units[@name] # prevent circular structure

			super self.path

### Properties

		self: null
		isClone: false
		name: ''

### Methods

#### *Unit* clone()

		clone: (self) ->

			assert @ instanceof File
			assert not @isClone

			forName = clones[@path]?[@name]
			if forName?.length then return forName.pop() 

			proto = utils.clone @

			proto.isClone = true

			proto.load = @load.clone proto
			proto.parse = @parse.clone proto
			proto.render = @render.clone proto

			proto

#### destroy()

		destroy: ->

			forPath = clones[@path] ?= {}
			forName = forPath[@name] ?= []

			assert @isClone
			assert not ~forName.indexOf @

			forName.push @

#### *Object* toJSON()

		toJSON: ->

			units = utils.clone @units

			for name, unit of units
				if @self.units[name] is unit
					units[name] = '[ From parent ]'

			path: @path
			pathbase: @pathbase
			files: @files
			name: @name
			units: units
			elems: @elems