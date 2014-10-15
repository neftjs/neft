'use strict'

[expect, utils, log] = ['expect', 'utils', 'log'].map require
Renderer = require 'renderer'

log = log.scope 'Styles'

currentItem = null

module.exports = (File, scopes) -> class Style

	@__name__ = 'Style'
	@__path__ = 'File.Style'

	listenRecursive = (node, event, listener) ->
		expect(node).toBe.any File.Element

		node.on event, listener

		if node.children
			for child in node.children
				listenRecursive child, event, listener

		null

	constructor: (opts) ->
		@_parent = null

		expect(opts).toBe.simpleObject()
		expect(opts.self).toBe.any File
		expect(opts.node).toBe.any File.Element
		expect(opts.itemId).toBe.truthy().string()
		expect(opts.isRepeat).toBe.boolean()
		expect().defined(opts.parent).toBe.any Style
		expect().defined(opts.events).toBe.simpleObject()

		utils.fill @, opts

		@children = []
		@isScope = @itemId[0].toUpperCase() is @itemId[0]

		Object.seal @

	self: null
	node: null
	itemId: ''
	children: null
	events: null
	isScope: false
	isRepeat: false

	utils.defProp @::, 'parent', 'e', ->
		@_parent
	, (val) ->
		if val?
			expect(val).toBe.any Style

		if @_parent is val
			return

		# remove from the old one
		if @_parent
			utils.remove @_parent.children, @

		# add new one
		if @_parent = val
			val.children.push @

	render: ->
		unless currentItem
			currentItem = @item
			@item.parent = Renderer.mainItem
		else if @isAutoParent
			@item.parent = @parent.item

		for child in @children
			child.render()

		if @item instanceof Renderer.Scope.Text
			@updateText()

		@updateVisibility()

	revert: ->
		if @isAutoParent
			@item.parent = null

		for child in @children
			child.revert()

		null

	updateText: ->
		expect(@item instanceof Renderer.Scope.Text)

		@item.text = @node.stringifyChildren()

	updateVisibility: ->
		@item.visible = @node.visible

	clone: (original, self, scope) ->

		clone = Object.create @

		clone.clone = undefined
		clone.self = self
		clone.node = original.node.getCopiedElement @node, self.node

		# break for abstract
		return clone unless utils.isClient

		# get item
		scope ?= Renderer
		if @isScope
			item = clone.item = scope.create scopes[@itemId]
			clone.isAutoParent = true
			scope = clone.item.scope
		else
			item = clone.item = scope.items[@itemId]

			if @isRepeat
				clone.item = clone.item.cloneDeep()

			clone.isAutoParent = !clone.item.parent

		unless item
			log.error "Can't find `#{@itemId}` style item in `#{scope.name}` scope"

			# return if no style item found
			return clone

		# clone children
		children = clone.children = []
		for child in @children
			child = child.clone original, self, scope
			child.parent = clone

		# attach events
		if @events
			for name, funcName of @events
				func = self.funcs?[funcName]
				unless func
					log.error "Can't find `#{funcName}` func in `#{self.path}` for `#{@styleId}` style"
					continue
				clone.item[name] func

		# listen on node changes
		clone.node.on 'visibilityChanged', ->
			if self.isRendered
				clone.updateVisibility()

		if item instanceof Renderer.Scope.Text
			listenRecursive clone.node, 'textChanged', ->
				if self.isRendered
					clone.updateText()

		clone
		