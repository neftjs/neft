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

	listenTextRec = (style, node=style.node) ->
		assert.instanceOf style, Style
		assert.instanceOf node, File.Element

		if 'onTextChange' of node
			style.textWatchingNodes.push node
			node.onTextChange textChangeListener, style

		if node.children
			for child in node.children
				listenTextRec style, child

		return

	visibilityChangeListener = ->
		if @file.isRendered
			@updateVisibility()

	textChangeListener = ->
		if @file.isRendered
			@updateText()

	attrsChangeListener = (e) ->
		if e.name is 'neft:style'
			@reloadItem()
			if @file.isRendered
				@render()
				@findItemParent()
		else if e.name is 'href' and @isLink()
			@item?.linkUri = @getLinkUri()

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

	constructor: ->
		@file = null
		@node = null
		@attrs = null
		@setAttrs = Object.create null
		@attrValues = []
		@attrListeners = []
		@parent = null
		@isScope = false
		@isAutoParent = false
		@item = null
		@scope = null
		@children = []
		@textWatchingNodes = []
		@visible = true
		@isTextSet = false
		@baseText = ''
		@isLinkUriSet = false
		@baseLinkUri = ''
		@classes = null
		@parentSet = false
		@lastItemParent = null

		Object.preventExtensions @

	render: ->
		for child in @children
			child.render()

		unless @item
			return

		# save classes
		if classes = @item._classes
			unless utils.isEqual(classes.items(), @classes)
				@classes = utils.clone(classes.items())

		@item.document.node = @node
		@updateText()
		@updateVisibility()

		if @lastItemParent
			@item?.parent = @lastItemParent
		
		for name of @attrs
			val = @node.attrs.get name
			@setAttr name, val
		return

	revert: ->
		unless @item
			return

		# parent
		if @isAutoParent
			if @isScope
				@item.document.onHide.emit()
			@lastItemParent = null
			if !@parentSet
				@lastItemParent = @item.parent
			@item.parent = null
		itemDocumentNode = @item.document.node
		@item.document.node = null

		tmpNode = @node
		while tmpNode = tmpNode._parent
			if tmpNode._documentStyle is @
				tmpNode._documentStyle = null
			else
				break

		for child in @children
			child.revert()

		# shared items
		if itemDocumentNode?._documentStyle is @
			# revert linkUri
			if @isLinkUriSet
				@item.linkUri = @baseLinkUri
				@isLinkUriSet = false
				@baseLinkUri = ''

			# revert text
			if @isTextSet
				@getTextObject().text = @baseText
				@isTextSet = false
				@baseText = ''

		# revert attr values
		{setAttrs, attrValues} = @
		while attrValues.length
			oldVal = attrValues.pop()
			prop = attrValues.pop()
			obj = attrValues.pop()
			obj[prop] = oldVal
		for attr, set of setAttrs
			if set
				setAttrs[attr] = false

		# revert attr listeners
		{attrListeners} = @
		while attrListeners.length
			func = attrListeners.pop()
			name = attrListeners.pop()
			obj = attrListeners.pop()
			obj[name].disconnect func

		# restore classes
		if (classes = @item._classes) or @classes
			classes.clear()
			if @classes
				for name in @classes
					classes.append name
		return

	getTextObject: ->
		if @item.$? and 'text' of @item.$
			@item.$
		else if 'text' of @item
			@item
		else if @item.label? and 'text' of @item.label
			@item.label

	updateText: ->
		obj = @getTextObject()
		node = @node
		if node.children.length is 1 and node.children[0].name is 'a'
			node = node.children[0]
			href = node.attrs.get('href')
			if typeof href is 'string'
				unless @isLinkUriSet
					@isLinkUriSet = true
					@baseLinkUri = @item.linkUri
				@item.linkUri = href

		if obj
			text = node.stringifyChildren()

			if text.length > 0 or @isTextSet
				@isTextSet = true
				@baseText = obj.text
				obj.text = text
		return

	updateVisibility: ->
		unless @item
			return

		visible = true
		tmpNode = @node
		loop
			visible = tmpNode.visible
			tmpNode = tmpNode.parent
			if not visible or not tmpNode or tmpNode.attrs.has('neft:style')
				break

		if @visible isnt visible
			@visible = visible
			@item.visible = visible
		return

	ATTR_PRIMITIVE_VALUES =
		__proto__: null
		'null': null
		'undefined': undefined
		'false': false
		'true': true

	getSplitAttr = do ->
		cache = Object.create null

		(prop) ->
			r = cache[prop]
			if r
				return r

			name = prop.slice 'neft:style:'.length
			cache[prop] = name.split ':'

	setAttr: (name, val) ->
		assert.instanceOf @, Style

		{funcs} = @file
		if funcs?.hasOwnProperty(val)
			val = funcs[val]

		if name.indexOf('neft:style') is -1
			r = @setAttr("neft:style:$:#{name}", val)
			r ||= @setAttr("neft:style:#{name}", val)
			return r

		props = getSplitAttr(name)
		unless obj = @item
			return false

		for prop, i in props
			if i is props.length - 1
				unless prop of obj
					# log.error "Can't set the '#{prop}' property, because this property doesn't exist"
					continue

				if val of ATTR_PRIMITIVE_VALUES
					val = ATTR_PRIMITIVE_VALUES[val]

				switch typeof obj[prop]
					when 'number'
						val = parseFloat val
					when 'boolean'
						if val is ''
							val = true
						else
							val = !!val
					when 'string'
						val = val+''

				if typeof obj[prop] is 'function' and typeof val is 'function'
					obj[prop] val
					@attrListeners.push obj, prop, val
				else
					`//<development>`
					if typeof obj[prop] is 'function' and not utils.lookupSetter(obj, prop)
						log.error "#{name} is a signal handler and expects function, but #{val} got"
						continue
					`//</development>`

					unless @setAttrs[name]
						@setAttrs[name] = true
						@attrValues.push obj, prop, obj[prop]
					obj[prop] = val
				return true
			else
				obj = obj[prop]
				unless obj
					return false
		return false

	isLink: ->
		@node.name is 'a' and not @attrs?.hasOwnProperty('neft:style:onPointerClicked') and @node.attrs.get('href')?[0] isnt '#'

	getLinkUri: ->
		uri = @node.attrs.get('href') + ''
		`//<development>`
		unless ///^([a-z]+:|\/|\$\{)///.test uri
			log.warn "Relative link found `#{uri}`"
		`//</development>`
		uri

	reloadItem: ->
		unless utils.isClient
			return

		if @item and @isAutoParent
			@item.parent = null

		if @item
			while elem = @textWatchingNodes.pop()
				elem.onTextChange.disconnect textChangeListener, @

		wasAutoParent = @isAutoParent

		id = @node.attrs.get 'neft:style'
		assert.isString id

		@isScope = ///^(styles|renderer)\:///.test id
		@item = null
		@scope = null
		@isAutoParent = false

		if id instanceof Renderer.Item
			@item = id
		else if @isScope
			if ///^renderer\:///.test id
				id = id.slice 'renderer:'.length
				id = utils.capitalize id
				@scope =
					mainItem: new Renderer[id]
					ids: {}
			else
				match = /^styles:(.+?)(?:\:(.+?))?$/.exec id
				[_, id, subid] = match
				@scope = styles[id]?.withStructure(subid)
			@isAutoParent = true
			if @scope
				@item = @scope.mainItem
			else
				unless File.Input.test id
					log.warn "Style file `#{id}` can't be find"
				return
		else
			parent = @parent
			loop
				scope = parent?.scope or windowStyle
				@item = scope.ids[id] or scope.mainItem.$?[id]
				@item ?= scope.styles?(id)
				if @item or ((not parent or not (parent = parent.parent)) and scope is windowStyle)
					break

			unless @item
				unless File.Input.test(id)
					log.warn "Can't find `#{id}` style item"
				return

			@isAutoParent = !@item.parent

		@node._documentStyle = @
		@node.style = @item

		if @isLink()
			@item.linkUri = @getLinkUri()

		# text changes
		if @getTextObject()
			listenTextRec @

		return;

	getStyleNodeIndex = (parent, child) ->
		index = 1
		for node in parent.children
			if node is child
				return index
			if node._documentStyle
				index++
		`//<development>`
		throw "Internal Error: can't get style node index"
		`//</development>`
		index

	findItemParent: ->
		if @isAutoParent and @item and not @item.parent
			@parentSet = true
			{node} = @
			tmpNode = node._parent
			oldParent = @item._parent
			while tmpNode
				if style = tmpNode._documentStyle
					item = style.item
					if style.node isnt tmpNode
						item = item._parent

				tmpNode._documentStyle ?= @

				if item
					@item.parent = item

					# find index
					tmpIndexNode = node
					item = item._sourceItem or item
					while tmpIndexNode
						if tmpIndexNode._nextSibling?._documentStyle?.item?.parent is item
							@item.index = tmpIndexNode._nextSibling._documentStyle.item.index
							break
						tmpIndexNode = tmpIndexNode._parent

					if @isScope and not oldParent
						@item.document.onShow.emit()
					break
				tmpNode = tmpNode._parent

			unless item
				@item.parent = null

		for child in @children
			child.findItemParent()

		return

	clone: (originalFile, file) ->
		clone = new Style

		clone.file = file
		clone.node = originalFile.node.getCopiedElement @node, file.node
		clone.attrs = clone.node._attrs

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

		# changes
		clone.node.onAttrsChange attrsChangeListener, clone

		# visibility changes
		tmpNode = clone.node
		loop
			if tmpNode.attrs.has 'neft:if'
				tmpNode.onVisibilityChange visibilityChangeListener, clone

			tmpNode = tmpNode.parent
			if not tmpNode or tmpNode.attrs.has('neft:style')
				break

		clone
