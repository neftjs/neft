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

		parse: (data) ->

			assert not (@status & RenderFile.PARSE)
			assert not data or data instanceof File.Element.modules.Attrs

			{usedUnits, changes} = @
			{units, elems, texts} = @self

			# replace elems by units
			for name, subelems of elems

				unit = units[name]

				for elem in subelems

					oldChild = elem.dom

					# get unit and parse it
					usedUnit = unit.clone()
					usedUnit.render.parse oldChild.attrs
					usedUnits.push usedUnit

					newChild = usedUnit.dom

					# replace
					changes.push oldChild.parent, oldChild, newChild
					oldChild.parent.replace oldChild, newChild

			# replace texts by values
			for elem in texts

				{dom, valueDom} = elem

				valueDom.text = elemData = data.get elem.prop

				# on data not found
				if elemData is undefined
					valueDom.visible = false

					for child in dom.children when child isnt valueDom
						child.visible = true

					continue 

				valueDom.visible = true


				# hide children
				for child in dom.children when child isnt valueDom
					child.visible = false

			# change status
			@status |= RenderFile.PARSE
			@trigger RenderFile.STATUS_CHANGED, @status

#### clear()

		clear: ->

			assert @status & RenderFile.PARSE

			{changes, usedUnits} = @

			# back changes
			while changes.length

				newChild = changes.pop()
				oldChild = changes.pop()
				node = changes.pop()

				unless newChild
					oldChild.parent = node
					continue

				unless oldChild
					newChild.parent = undefined
					continue

				node.replace newChild, oldChild

			# clear and destroy used units
			while usedUnits.length

				usedUnit = usedUnits.pop()
				usedUnit.render.clear()
				usedUnit.destroy()

			# change status
			@status = 0
			@trigger RenderFile.STATUS_CHANGED, @status

#### html()

		html: (data) ->

			@parse data
			html = @self.dom.stringify()
			@clear()

			html

#### *RenderFile* clone(*File*)

		clone: (self) ->

			new RenderFile self