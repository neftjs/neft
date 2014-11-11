'use strict'

[expect, utils, log] = ['expect', 'utils', 'log'].map require
Renderer = require 'renderer'

log = log.scope 'Styles'

module.exports = (File, data) -> class Style
	{windowStyle, styles} = data

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
		expect(opts).toBe.simpleObject()
		expect(opts.self).toBe.any File
		expect(opts.node).toBe.any File.Element
		expect(opts.id).toBe.truthy().string()
		expect(opts.isRepeat).toBe.boolean()
		expect(opts.isScope).toBe.boolean()
		expect().defined(opts.parent).toBe.any Style
		expect().defined(opts.scope).toBe.any File.StyleScope
		expect().defined(opts.events).toBe.simpleObject()

		utils.fill @, opts

		@children = []
		@parent?.children.push @

		Object.seal @

	self: null
	node: null
	id: ''
	children: null
	events: null
	parent: null
	isRepeat: false
	isScope: false

	render: (parent=@parent) ->
		unless @item
			return

		if @isAutoParent
			@item.parent = parent?.item

		for child in @children
			child.render()

		if @item instanceof Renderer.Text
			@updateText()

		@updateVisibility()

	revert: ->
		unless @item
			return

		if @isAutoParent
			@item.parent = null

		for child in @children
			child.revert()

		null

	updateText: ->
		expect(@item).toBe.any Renderer.Text

		@item.text = @node.stringifyChildren()

	updateVisibility: ->
		@item.visible = @node.visible

	clone: (original, self, scope) ->
		clone = Object.create @

		clone.clone = undefined
		clone.self = self
		clone.node = original.node.getCopiedElement @node, self.node

		# break for the abstract
		unless utils.isClient
			return clone

		# get scope
		if @isScope
			scope = styles[@id]?()
			unless scope
				log.warn "Style file `#{@id}` can't be find. Operation aborted"
				return clone
			else
				clone.item = scope.mainItem

		unless scope
			scope = windowStyle
			unless scope
				log.warn "Style item `#{@id}` doesn't have any style file and `Window` " +
				         "is not defined. Operation aborted."
				return clone

		# get item
		if clone.item ?= scope.items[@id]
			if @isRepeat
				clone.item = clone.item.cloneDeep()

		unless clone.item
			log.error "Can't find `#{@id}` style item"
			return clone
		else
			clone.isAutoParent = !clone.item.parent

		# clone children
		children = clone.children = []
		for child in @children
			child = child.clone original, self, scope
			child.parent = clone
			children.push child

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

		if clone.item instanceof Renderer.Text
			listenRecursive clone.node, 'textChanged', ->
				if self.isRendered
					clone.updateText()

		clone
		