View File Elem
==============

Goals
-----

Represents an element placed in the file.

	'use strict'

	{assert} = console

*class* Elem
------------

	module.exports = (File) -> class Elem

		@__name__ = 'Elem'
		@__path__ = 'File.Elem'

### Constructor(*File*, *string*, *HTMLElement*)

		constructor: (@self, @name, @node) ->

			assert self instanceof File
			assert name and typeof name is 'string'

			# call init
			@init()

			# get bodyNode
			if node.children.length
				bodyNode = @bodyNode = File.Element.factory()
				elem.parent = bodyNode while elem = node.children[0]
				bodyNode.parent = node

### Properties

		name: ''
		self: null
		node: null
		bodyNode: null

### Methods

		init: ->
