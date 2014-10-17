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

			# signal
			usedUnit.replacedByElem @

			@isRendered = true

		revert: ->
			return unless @isRendered

			# destroy used unit
			if @usedUnit
				@usedUnit.node.parent = undefined
				@usedUnit.revert().destroy()
				@usedUnit = null

			@isRendered = false

			# restore attrs
			@node.attrs.backChanges()

		clone: (original, self) ->

			clone = Object.create @

			clone.clone = undefined
			clone.self = self
			clone.node = original.node.getCopiedElement @node, self.node
			clone.bodyNode = clone.node.children[0]
			clone.render = (arg1) => @render.call clone, arg1
			clone.revert = => @revert.call clone
			clone.usedUnit = null
			clone.isRendered = false

			clone.node.on 'visibilityChanged', ->
				if self.isRendered
					clone.render()

			clone