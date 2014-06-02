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

		clone: (original, self) ->

			clone = Object.create @

			clone.clone = undefined
			clone.self = self
			clone.node = original.node.getCopiedElement @node, self.node
			clone.bodyNode = clone.node.children[0]

			clone