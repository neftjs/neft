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

		@ELEMS = 1<<0
		@ALL = @ELEMS

#### Event names

		@STATUS_CHANGED = 'statuschanged'
		@ERROR = 'error'

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

#### parseElems()

		parseElems: ->

			assert not (@status & RenderFile.ELEMS)
			unit and assert unit instanceof File.Unit

			{usedUnits, changes} = @
			{units, elems, texts} = @self

			stack = new utils.async.Stack

			# replace elems by units
			for name, subelems of elems

				unit = units[name]

				for elem in subelems

					oldChild = elem.dom

					# get unit and parse it
					usedUnit = unit.clone()
					stack.add usedUnit.render, 'parse', elem
					usedUnits.push usedUnit

					newChild = usedUnit.dom

					# replace
					changes.push oldChild.parent, oldChild, newChild
					oldChild.parent.replace oldChild, newChild

			# parse units
			stack.runAllSimultaneously (err) =>

				if err
					return @trigger RenderFile.ERROR, err

				# change status
				@status |= RenderFile.ELEMS

				@trigger RenderFile.STATUS_CHANGED, @status

#### parse()

		parse: (elem, callback) ->

			elem and assert elem instanceof File.Elem
			assert typeof callback is 'function'

			@once RenderFile.ERROR, (err) ->
				@off RenderFile.STATUS_CHANGED
				callback err

			@on RenderFile.STATUS_CHANGED, (status) ->
				if status is File.RenderFile.ALL
					callback null

			@parseElems()

#### clear()

		clear: ->

			assert @status & RenderFile.ELEMS

			{changes, usedUnits} = @

			# back changes
			while changes.length

				newChild = changes.pop()
				oldChild = changes.pop()
				node = changes.pop()

				node.replace newChild, oldChild

			# clear and destroy used units
			while usedUnits.length

				usedUnit = usedUnits.pop()
				usedUnit.render.clear()
				usedUnit.destroy()

			# change status
			@status -= @ELEMS
			@trigger RenderFile.STATUS_CHANGED, @status

#### html()

		html: (callback) ->

			assert typeof callback is 'function'

			@parse null, (err) =>

				try
					html = @self.dom.stringify()
					@clear()

				callback err, html

#### *RenderFile* clone(*File*)

		clone: (self) ->

			new File.RenderFile self