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

		name: ''
		self: null
		node: null
		bodyNode: null
		usedUnit: null
		isRendered: false

### Methods

		render: (file) ->
			expect(@self.isRendered).toBe.truthy()
			expect().defined(file).toBe.any File

			return unless @node.visible

			if @isRendered
				@revert()

			unit = @self.units[@name]
			return if not file and not unit

			usedUnit = @usedUnit = file or File.factory(unit)
			unless file
				usedUnit.storage = @self.storage

			unless usedUnit.isRendered
				usedUnit.render @

			usedUnit.node.parent = @node

			if usedUnit.hasOwnProperty 'onReplacedByElem'
				usedUnit.onReplacedByElem @

			@isRendered = true

		revert: ->
			expect(@self.isRendered).toBe.falsy()

			return unless @isRendered

			# restore attrs
			@node.attrs.backChanges()

			return unless @usedUnit

			# destroy used unit
			@usedUnit.node.parent = undefined
			@usedUnit.revert().destroy()
			@usedUnit = null
			@isRendered = false

		clone: (original, self) ->

			clone = Object.create @

			clone.clone = undefined
			clone.self = self
			clone.node = original.node.getCopiedElement @node, self.node
			clone.bodyNode = clone.node.children[0]
			clone.render = (a1) => @render.call clone, a1
			clone.revert = => @revert.call clone
			clone.usedUnit = null
			clone.isRendered = false

			utils.defProp clone, '_unit', 'cw', null

			self.onRender.connect clone.render
			self.onRevert.connect clone.revert
			clone.node.onVisibilityChanged.connect -> clone.render()

			clone