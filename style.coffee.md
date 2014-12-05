View.Style
==========

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	signal = require 'signal'
	log = require 'log'
	Renderer = require 'renderer'

	log = log.scope 'Styles'

	module.exports = (File, data) -> class Style
		{windowStyle, styles} = data

		@__name__ = 'Style'
		@__path__ = 'File.Style'

		@HTML_ATTR = "#{File.HTML_NS}:style"
		@HTML_DEEP_ATTR = "#{Style.HTML_ATTR}:"

		listenRecursive = (node, event, listener) ->
			expect(node).toBe.any File.Element

			node.on event, listener

			if node.children
				for child in node.children
					listenRecursive child, event, listener

			null

*Style* Style(*Object* options) @low-level
------------------------------------------

		constructor: (opts) ->
			expect(opts).toBe.simpleObject()
			expect(opts.self).toBe.any File
			expect(opts.node).toBe.any File.Element
			expect(opts.id).toBe.truthy().string()
			expect(opts.isRepeat).toBe.boolean()
			expect(opts.isScope).toBe.boolean()
			expect().defined(opts.parent).toBe.any Style
			expect().defined(opts.scope).toBe.any File.StyleScope
			expect().defined(opts.attrs).toBe.simpleObject()

			utils.fill @, opts

			@children = []
			@parent?.children.push @

			Object.seal @

		self: null
		node: null
		id: ''
		children: null
		attrs: null
		parent: null
		isRepeat: false
		isScope: false

		render: (parent=@parent) ->
			unless @item
				return

			if @isAutoParent and @item isnt parent?.item
				@item.parent = if parent then parent.item else null

			for child in @children
				child.render()

			if 'text' of @item
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
			@item.text = @node.stringifyChildren()

		updateVisibility: ->
			@item.visible = @node.visible

		setAttr: (name, val) ->
			expect(@).toBe.any Style
			expect().some().keys(@attrs).toBe name

			name = name.slice Style.HTML_DEEP_ATTR.length
			props = name.split ':'
			obj = @item
			for prop, i in props
				if i is props.length - 1
					if typeof obj[prop] is 'function'
						obj[prop] val
					else
						obj[prop] = val
				obj = obj[prop]
			return

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
			if clone.item ?= scope.ids[@id]
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

			# attach attrs
			if @attrs
				for name, val of @attrs when val?
					val = self.funcs?[val] or val
					clone.setAttr name, val

				# listen on attr change
				clone.node.on 'attrChanged', (e) ->
					return unless clone.attrs.hasOwnProperty(e.name)
					value = @attrs.get e.name
					if clone.self.funcs?[value]
						log.warn "Dynamic listening on Renderer events is not supported"
						return
					clone.setAttr e.name, value

			# support HTML anchors
			if @node.name is 'a' and not @attrs?.hasOwnProperty("#{Style.HTML_DEEP_ATTR}onPointerClicked")
				clone.item.onPointerClicked ->
					url = clone.node.attrs.get 'href'
					unless url
						return

					self.storage.global?.uri = url

			# listen on node changes
			clone.node.on 'visibilityChanged', ->
				if self.isRendered
					clone.updateVisibility()

			if 'text' of clone.item
				listenRecursive clone.node, 'textChanged', ->
					if self.isRendered
						clone.updateText()

			clone
			