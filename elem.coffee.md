View File Elem
==============

Goals
-----

Represents an element placed in the file.

	'use strict'

	[utils, expect] = ['utils', 'expect'].map require

*class* Elem
------------

	module.exports = (File) -> class Elem

		@__name__ = 'Elem'
		@__path__ = 'File.Elem'

### Constructor(*File*, *string*, *HTMLElement*)

		constructor: (@self, @name, @node) ->

			expect(self).toBe.any File
			expect(name).toBe.truthy().string()

			# get bodyNode
			if node.children.length
				bodyNode = @bodyNode = new File.Element.Tag
				elem.parent = bodyNode while elem = node.children[0]
				bodyNode.parent = node

### Properties

		uid: ''
		name: ''
		self: null
		node: null
		bodyNode: null

### Methods

		clone: (original, self) ->

			clone = Object.create @

			clone.clone = undefined
			clone.self = self
			clone.uid = utils.uid()
			clone.node = original.node.getCopiedElement @node, self.node
			clone.bodyNode = clone.node.children[0]

			clone