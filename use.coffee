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
	usedFragment: null
	isRendered: false

	render: (file) ->
		assert.instanceOf file, File if file?

		return unless @node.visible

		if @isRendered
			@revert()

		fragment = @self.fragments[@name]
		if not file and not fragment
			log.warn "Can't find `#{@name}` neft:fragment"
			return

		usedFragment = @usedFragment = file or File.factory(fragment)
		unless file
			usedFragment.storage = @self.storage

		unless usedFragment.isRendered
			usedFragment.render @

		usedFragment.node.parent = @node

		# signal
		usedFragment.parentUse = @
		usedFragment.replacedByUse @

		@isRendered = true

	revert: ->
		return unless @isRendered

		# destroy used fragment
		if @usedFragment
			@usedFragment.node.parent = undefined
			@usedFragment.revert().destroy()
			@usedFragment.parentUse = null
			@usedFragment = null

		@isRendered = false

		# restore attrs
		# @node.attrs.backChanges()
	
	visibilityChangedListener = ->
		if @self.isRendered and not @isRendered
			@render()

	attrChangedListener = (e) ->
		if e.name is 'neft:fragment'
			@name = @node.attrs.get 'neft:fragment'

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
		clone.usedFragment = null
		clone.isRendered = false

		clone.node.onVisibilityChanged visibilityChangedListener, clone

		# name
		if clone.name is ''
			clone.name = clone.node.attrs.get 'neft:fragment'
			clone.node.onAttrChanged attrChangedListener, clone

		clone
