View File Render
================

Goals
-----

Give a method to easily generate HTML based on parsed file.

	'use strict'

	utils = require 'utils/index.coffee.md'
	assert = require 'assert'
	Events = require 'Events/index.coffee.md'

*class* RenderFile
------------------

	module.exports = (File) -> class RenderFile extends Events

### Static

#### Status bitmask values

		@DATA = 1<<0
		@PARSE = 1<<1
		@ALL = @DATA | @PARSE

#### Event names

		@STATUS_CHANGED = 'statuschanged'

### Constructor(*File*)

		constructor: (@self) ->

			assert self instanceof File

			@usedUnits = []
			@changes = []

			super

### Properties

#### *File* self

		self: null

#### status

Integer value used for bitmasks. Check static properties to needed values.

		status: 0

		usedUnits: null
		changes: null

### Methods

#### parse()

		parse: =>

			dom = @self.dom

			assert not (@status & RenderFile.PARSE)
			assert dom.ownerDocument is File.DOC

			{usedUnits, changes} = @
			{units, elems} = @self

			# replace elems by units
			for name, subelems of elems

				unit = units[name]

				for elem in subelems

					usedUnit = unit.clone()
					usedUnit.render.parse()
					usedUnits.push usedUnit

					newChild = usedUnit.dom
					oldChild = elem.dom

					changes.push dom, oldChild, newChild
					dom.replaceChild newChild, oldChild

			# change status
			@status |= RenderFile.PARSE
			@trigger RenderFile.STATUS_CHANGED, @status

#### clear()

		clear: =>

			assert @status & RenderFile.PARSE

			{changes, usedUnits} = @

			# back changes
			while changes.length

				newChild = changes.pop()
				oldChild = changes.pop()
				node = changes.pop()

				node.replaceChild oldChild, newChild

			# clear and destroy used units
			while usedUnits.length

				usedUnit = usedUnits.pop()
				usedUnit.render.clear()
				usedUnit.destroy()

			# change status
			@status = 0
			@trigger RenderFile.STATUS_CHANGED, @status

		html: ->

			@parse()
			html = @self.dom.innerHTML
			@clear()

			html

#### *RenderFile* clone(*File*)

		clone: (self) ->

			new RenderFile self