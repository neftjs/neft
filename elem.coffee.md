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
			expect(node).toBe.any File.Element

			# get bodyNode
			if node.children.length
				bodyNode = @bodyNode = new File.Element.Tag
				elem.parent = bodyNode while elem = node.children[0]
				bodyNode.parent = node

### Properties

		isRendered: false
		name: ''
		self: null
		node: null
		bodyNode: null
		usedUnit: null

### Methods

		render: ->
			expect(@self.isRendered).toBe.truthy()

			return if @isRendered
			return unless @node.visible

			usedUnit = @usedUnit = File.factory @self.units[@name]
			usedUnit.storage = @self.storage
			usedUnit.render @

			@node.parent.replace @node, usedUnit.node

			@isRendered = true

		revert: ->
			expect(@self.isRendered).toBe.falsy()
			@isRendered = false

			# restore attrs
			@node.attrs.backChanges()

			return unless @usedUnit

			# destroy used unit
			@usedUnit.node.parent.replace @usedUnit.node, @node
			@usedUnit.revert().destroy()
			@usedUnit = null

		clone: (original, self) ->

			clone = Object.create @

			clone.clone = undefined
			clone.self = self
			clone.node = original.node.getCopiedElement @node, self.node
			clone.bodyNode = clone.node.children[0]
			clone.render = @render.bind clone
			clone.revert = @revert.bind clone
			clone.isRendered = false
			clone.usedUnit = null

			utils.defProp clone, '_unit', 'cw', null

			self.onRender.connect clone.render
			self.onRevert.connect clone.revert
			clone.node.onVisibilityChanged.connect clone.render

			clone