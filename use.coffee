'use strict'

utils = require 'utils'
assert = require 'assert'
log = require 'log'

assert = assert.scope 'View.Use'
log = log.scope 'View', 'Use'

module.exports = (File) -> class Use
	@__name__ = 'Use'
	@__path__ = 'File.Use'

	constructor: (@self, @node) ->
		assert.instanceOf self, File
		assert.instanceOf node, File.Element

		# get bodyNode
		if node.children.length
			bodyNode = @bodyNode = new File.Element.Tag
			elem.parent = bodyNode while elem = node.children[0]
			bodyNode.parent = node

	name: ''
	self: null
	node: null
	bodyNode: null
	usedUnit: null
	isRendered: false

	render: (file) ->
		assert.instanceOf file, File if file?

		return unless @node.visible

		if @isRendered
			@revert()

		unit = @self.units[@name]
		if not file and not unit
			log.warn "Can't find `#{@name}` neft:unit"
			return

		usedUnit = @usedUnit = file or File.factory(unit)
		unless file
			usedUnit.storage = @self.storage

		unless usedUnit.isRendered
			usedUnit.render @

		usedUnit.node.parent = @node

		# signal
		usedUnit.parentUse = @
		usedUnit.replacedByUse @

		@isRendered = true

	revert: ->
		return unless @isRendered

		# destroy used unit
		if @usedUnit
			@usedUnit.node.parent = undefined
			@usedUnit.revert().destroy()
			@usedUnit.parentUse = null
			@usedUnit = null

		@isRendered = false

		# restore attrs
		# @node.attrs.backChanges()
	
	visibilityChangedListener = ->
		if @self.isRendered and not @isRendered
			@render()

	attrChangedListener = (e) ->
		if e.name is 'neft:unit'
			@name = @node.attrs.get 'neft:unit'

			if @isRendered
				@revert()
				@render()

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

		clone.node.onVisibilityChanged visibilityChangedListener, clone

		# name
		if clone.name is ''
			clone.name = clone.node.attrs.get 'neft:unit'
			clone.node.onAttrChanged attrChangedListener, clone

		clone
