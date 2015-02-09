	'use strict'

	assert = require 'assert'
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

		listenRecursive = (style, node, event, listener) ->
			assert.instanceOf style, Style
			assert.instanceOf node, File.Element

			node[event]? listener, style

			if node.children
				for child in node.children
					listenRecursive style, child, event, listener

			null

		visibilityChangedListener = ->
			if @file.isRendered
				@updateVisibility()

		textChangedListener = ->
			if @file.isRendered
				@updateText()

		attrChangedListener = (e) ->
			if e.name is Style.HTML_ATTR
				@reloadItem()
				if @file.isRendered
					@render()

			if @file.isRendered
				return unless @attrs?.hasOwnProperty(e.name)
				value = @node.attrs.get e.name
				if @file.funcs?.hasOwnProperty value
					log.warn "Dynamic listening on Renderer events is not supported"
					return
				@setAttr e.name, value

		reloadItemsRecursively = (style) ->
			style.reloadItem()

			for child in style.children
				reloadItemsRecursively child

			return

		anchorListener = ->
			url = @node.attrs.get 'href'
			unless url
				return

			@file.storage.global?.uri = url

		constructor: ->
			@file = null
			@node = null
			@attrs = null
			@parent = null
			@isScope = false
			@isAutoParent = false
			@item = null
			@scope = null
			@isAnchorListening = false
			@children = []

			Object.preventExtensions @

		render: (parent=@parent) ->
			assert.instanceOf parent, Style if parent?

			@parent = parent

			for child in @children
				child.render()

			if not @item or not @parent
				return

			if @isAutoParent and @item isnt @parent.item
				@item.parent = parent.item

			if 'text' of @item
				@updateText()

			@updateVisibility()

			{funcs} = @file
			for name of @attrs
				val = @node.attrs.get name
				if funcs?.hasOwnProperty val
					val = funcs[val]
				@setAttr name, val

			return

		revert: ->
			unless @item
				return

			if @isAutoParent
				@item.parent = null

			for child in @children
				child.revert()

			for name, val of @attrs
				val = @file.funcs?[val] or val
				@setAttr name, val

			null

		updateText: ->
			if 'text' of @item
				@item.text = @node.stringifyChildren()

		updateVisibility: ->
			visible = true
			tmpNode = @node
			loop
				visible = tmpNode.visible
				tmpNode = tmpNode.parent
				if not visible or not tmpNode or tmpNode.attrs.has('neft:style')
					break

			@item?.visible = visible

		setAttr: (name, val) ->
			assert.instanceOf @, Style
			assert.ok @attrs.hasOwnProperty(name)

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

		isAnchor: ->
			@node.name is 'a' and not @attrs?.hasOwnProperty("#{Style.HTML_DEEP_ATTR}onPointerClicked")

		reloadItem: ->
			if @item and @isAutoParent
				@item.parent = null
				if @isAnchorListening
					@item.onPointerClicked.disconnect anchorListener, @
					@isAnchorListening = false

			id = @node.attrs.get Style.HTML_ATTR
			@isScope = ///^styles\.///.test id
			@item = null
			@scope = null
			@isAutoParent = false

			if @isScope
				id = id.slice 'styles.'.length
				@isAutoParent = true
				@scope = styles[id]?.withStructure()
				if @scope
					@item = @scope.mainItem
				else
					unless File.Input.test id
						log.warn "Style file `#{id}` can't be find"
					return
			else
				parent = @parent
				while parent and not scope = parent.scope
					parent = parent.parent

				scope ?= windowStyle
				@item = scope.ids[id]

				unless @item
					unless File.Input.test id
						log.warn "Can't find `#{id}` style item"
					return

				@isAutoParent = !@item.parent

			if @isAnchor()
				@item.onPointerClicked anchorListener, @
				@isAnchorListening = true

		clone: (originalFile, file) ->
			clone = new Style

			clone.file = file
			clone.node = originalFile.node.getCopiedElement @node, file.node
			clone.attrs = @attrs
			clone.node.onAttrChanged attrChangedListener, clone

			# clone children
			for child in @children
				child = child.clone originalFile, file
				child.parent = clone
				clone.children.push child

			# reload items
			unless @parent
				reloadItemsRecursively clone

			# break for the abstract
			unless utils.isClient
				return clone

			# visibility changes
			tmpNode = clone.node
			loop
				if tmpNode.attrs.has 'neft:if'
					tmpNode.onVisibilityChanged visibilityChangedListener, clone

				tmpNode = tmpNode.parent
				if not tmpNode or tmpNode.attrs.has('neft:style')
					break

			# text changes
			if (not @parent and not clone.item) or (clone.item and 'text' of clone.item)
				listenRecursive @, clone.node, 'onTextChanged', textChangedListener

			clone
