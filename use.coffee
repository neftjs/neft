'use strict'

utils = require 'utils'
assert = require 'neft-assert'
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
			while elem = node.children[0]
				elem.parent = bodyNode
			bodyNode.parent = node

	name: ''
	self: null
	node: null
	bodyNode: null
	usedFragment: null
	isRendered: false

	`//<development>`
	usesWithNotFoundFragments = []
	logUsesWithNoFragments = ->
		while useElem = usesWithNotFoundFragments.pop()
			unless useElem.usedFragment
				log.warn "neft:fragment '#{useElem.name}' can't be find in file '#{useElem.self.path}'"
		return
	`//</development>`

	render: (file) ->
		assert.instanceOf file, File if file?

		return unless @node.visible

		if @isRendered
			@revert()

		fragment = @self.fragments[@name]
		if not file and not fragment
			`//<development>`
			if usesWithNotFoundFragments.push(@) is 1
				setTimeout logUsesWithNoFragments
			`//</development>`
			return

		usedFragment = file or File.factory(fragment)
		unless file
			usedFragment.storage = @self.storage

		unless usedFragment.isRendered
			usedFragment = usedFragment.render @

		usedFragment.node.parent = @node
		@usedFragment = usedFragment

		# signal
		usedFragment.parentUse = @
		usedFragment.onReplaceByUse.emit @

		@isRendered = true

	revert: ->
		return unless @isRendered

		# destroy used fragment
		if @usedFragment
			@usedFragment.revert().destroy()
			@usedFragment.node.parent = null
			@usedFragment.parentUse = null
			@usedFragment = null

		@isRendered = false

	visibilityChangeListener = ->
		if @self.isRendered and not @isRendered
			@render()

	attrsChangeListener = (name) ->
		if name is 'neft:fragment'
			@name = @node.getAttr 'neft:fragment'

			if @isRendered
				@revert()
				@render()
		return

	clone: (original, self) ->
		clone = Object.create @

		clone.clone = undefined
		clone.self = self
		clone.node = original.node.getCopiedElement @node, self.node
		clone.bodyNode = clone.node.children[0]
		clone.usedFragment = null
		clone.isRendered = false

		clone.node.onVisibleChange visibilityChangeListener, clone

		# name
		if clone.name is ''
			clone.name = clone.node.getAttr 'neft:fragment'
			clone.node.onAttrsChange attrsChangeListener, clone

		clone
