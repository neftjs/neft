View File Parse
===============

Goals
-----

Prepare file to be render: find provided elements, attributes and so on.

	'use strict'

	assert = require 'assert'
	utils = require 'utils/index.coffee.md'
	Events = require 'Events/index.coffee.md'

	HASH_RE = ///////g

*class* ParseFile
-----------------

	module.exports = (File) -> class ParseFile extends Events

### Static

#### Status bitmask values

		@UNITS = 1<<0
		@ELEMS = 1<<1
		@ALL = @UNITS | @ELEMS

#### Events names

		@STATUS_CHANGED = 'statuschanged'
		@ERROR = 'error'

### Constructor

		constructor: (@self) ->

			assert self instanceof File

			super

### Properties

#### *File* self

		self: null

#### status

Integer value used for bitmasks. Check static properties to needed values.

		status: 0

### Methods

#### units()

		units: ->

			assert not (@status & ParseFile.UNITS)
			assert @self.load.status & File.LoadFile.FILE

			dom = @self.dom

			units = @self.units ?= {}

			# merge units from files
			pathbase = @self.pathbase and @self.pathbase.toUpperCase().replace(HASH_RE, '-')
			pathbaselen = @self.pathbase.length

			for link in @self.links

				base = link.pathbase.slice pathbaselen + 1
				base = base.toUpperCase()
				base += if base then '-' else ''

				# merge
				if link.units

					for name, unit of link.units

						units[base + name] = unit

			# find units in file
			stack = new utils.async.Stack
			nodes = dom.queryAll '> unit[name]'

			factoryUnit = (name, node, callback) ->

				unit = units[name] = File.Unit.factory @, name, node

				if unit.isReady then return callback null

				unit
					.once(File.Unit.ERROR, callback)
					.once(File.Unit.READY, callback.bind null)

			for node in nodes

				name = node.attrs.get 'name'

				stack.add @self, factoryUnit, name, node

				# remove node from file
				node.parent = undefined

			# update status
			stack.runAllSimultaneously (err) =>

				if err then return @trigger ParseFile.ERROR, err

				@status |= ParseFile.UNITS
				@trigger ParseFile.STATUS_CHANGED, @status

			units

#### elems()

		elems: ->

			assert not (@status & ParseFile.ELEMS)
			assert @status & ParseFile.UNITS

			dom = @self.dom

			elems = @self.elems = {}

			# find elems
			for name of @self.units

				nodes = dom.queryAll name

				unless nodes? then continue

				for node in nodes
					nameElems = elems[name] ?= []
					nameElems.push elem = new File.Elem @self, name, node

			# update status
			@status |= ParseFile.ELEMS
			@trigger ParseFile.STATUS_CHANGED, @status

			elems

#### all()

		all: (callback) ->

			assert not @status
			assert typeof callback is 'function'

			@once ParseFile.ERROR, callback

			@once ParseFile.STATUS_CHANGED, =>
				@elems()
				callback null

			@units()

#### *ParseFile* clone(*File*)

		clone: (self) ->

			copy = new ParseFile self
			copy.all ->

			copy