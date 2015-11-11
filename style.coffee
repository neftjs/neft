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

	emptyComponent = new Renderer.Component

	listenTextRec = (style, node=style.node) ->
		assert.instanceOf style, Style
		assert.instanceOf node, File.Element

		style.textWatchingNodes.push node
		if 'onTextChange' of node
			node.onTextChange textChangeListener, style
		if 'onChildrenChange' of node
			node.onChildrenChange textChangeListener, style
		if 'onVisibleChange' of node
			node.onVisibleChange textChangeListener, style

		if node.children
			for child in node.children
				listenTextRec style, child

		return

	textChangeListener = ->
		if @file.isRendered
			@updateText()

	attrsChangeListener = (name, oldValue) ->
		if name is 'href' and @isLink()
			@item?.linkUri = @getLinkUri()

		if @attrs?[name]
			@setAttr name, @node._attrs[name], oldValue
		return

	reloadItemsRecursively = (style) ->
		style.reloadItem()

		for child in style.children
			reloadItemsRecursively child

		return

	constructor: ->
		@file = null
		@node = null
		@attrs = null
		@parent = null
		@isScope = false
		@isAutoParent = false
		@item = null
		@scope = null
		@children = []
		@textWatchingNodes = []
		@isTextSet = false
		@baseText = ''
		@isLinkUriSet = false
		@baseLinkUri = ''
		@parentSet = false
		@lastItemParent = null
		@waiting = false
		@index = -1
		@attrsQueue = []
		@attrsClass = null

		Object.preventExtensions @

	showEvent = new Renderer.Item.Document.ShowEvent
	hideEvent = new Renderer.Item.Document.HideEvent
	globalShowDelay = globalHideDelay = 0
	stylesToRender = []
	stylesToRevert = []

	updateWhenPossible = do ->
		pending = false
		lastDate = 0

		sync = ->
			now = Date.now()
			diff = now - lastDate
			lastDate = now

			animationsPending = false

			for style in stylesToRevert
				for extension in style.item._extensions
					if extension instanceof Renderer.PropertyAnimation and extension.running and not extension.loop
						animationsPending = true
						break
				if animationsPending
					break

			# update delays
			globalShowDelay -= diff
			if globalHideDelay > 0 and not animationsPending
				globalHideDelay -= diff

			if not animationsPending 
				# revert styles
				if globalHideDelay <= 0
					globalHideDelay = 0

					if stylesToRevert.length > 0
						logtime = log.time 'Revert'
						for style in stylesToRevert
							style.waiting = false
							style.revertItem()
							style.file.readyToUse = true
							assert.notOk style.file.isRendered

						utils.clear stylesToRevert
						log.end logtime

				# render styles
				if globalShowDelay + globalHideDelay <= 0
					globalShowDelay = 0

					if stylesToRender.length > 0
						logtime = log.time 'Render'
						for style in stylesToRender
							style.waiting = false
							style.renderItem()
							style.file.readyToUse = true

						for style in stylesToRender
							style.findItemIndex()

						utils.clear stylesToRender
						log.end logtime

			# continue
			if stylesToRender.length or stylesToRevert.length
				requestAnimationFrame sync
			else
				pending = false

			return

		(style) ->
			unless pending
				lastDate = Date.now()
				requestAnimationFrame sync
				pending = true

			style.waiting = true
			return

	render: ->
		if @waiting or not @item
			return

		if @isScope
			@item.document.onShow.emit showEvent
			globalShowDelay += showEvent.delay
			showEvent.delay = 0

		@item.document.visible = false
		@file.readyToUse = false
		stylesToRender.push @
		updateWhenPossible @
		return

	renderItem: ->
		if not @item or not @file.isRendered
			return

		@item.visible = true

		if @lastItemParent
			@item.parent = @lastItemParent
		@findItemParent()

		@item.document.node = @node
		@baseText = @getTextObject()?.text or ''
		@updateText()
		@updateVisibility()

		# set attrs
		if @attrs
			if (attrsQueue = @attrsQueue).length
				for attr, i in attrsQueue by 3
					@setAttr attr, attrsQueue[i+1], attrsQueue[i+2]
				utils.clear attrsQueue
			@attrsClass.enable()

		@item.document.visible = true
		return

	revert: ->
		if @waiting or not @item
			return

		# parent
		if @isAutoParent and @isScope
			@item.document.onHide.emit hideEvent
			globalHideDelay += hideEvent.delay
			globalShowDelay += hideEvent.nextShowDelay
			hideEvent.delay = 0
			hideEvent.nextShowDelay = 0
		@item.document.visible = false

		@file.readyToUse = false
		stylesToRevert.push @
		updateWhenPossible @

		# clean index finding data
		tmpNode = @node
		while (tmpNode = tmpNode._parent) && not tmpNode.style
			if tmpNode.name is 'neft:blank'
				tmpNode._documentStyle = null
		return

	revertItem: ->
		unless @item
			return

		@item.visible = false

		# parent
		if @isAutoParent
			@lastItemParent = null
			if !@parentSet
				@lastItemParent = @item.parent
			@item.parent = null
			@parentSet = false

		itemDocumentNode = @item.document.node
		@item.document.node = null
		@item.document.visible = true

		tmpNode = @node
		while tmpNode = tmpNode._parent
			if tmpNode._documentStyle is @
				tmpNode._documentStyle = null
			else
				break

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
		return

	getTextObject: ->
		{item} = @
		unless item
			return
		if item._$ and 'text' of item._$
			item._$
		else if 'text' of item
			item

	updateText: ->
		if @waiting
			return

		{node} = @
		hasStyledChild = @children.length or node.query('[neft:style]')

		if not hasStyledChild and (anchor = node.query('> a'))
			node = anchor
			href = node.attrs.get('href')
			if typeof href is 'string'
				unless @isLinkUriSet
					@isLinkUriSet = true
					@baseLinkUri = @item.linkUri
				@item.linkUri = href

		obj = @getTextObject()
		if obj and not hasStyledChild
			text = node.stringifyChildren()

			if text.length > 0 or @isTextSet
				@isTextSet = true	
				obj.text = text
		return

	updateVisibility: ->
		if @waiting or not @item
			return

		visible = true
		tmpNode = @node
		loop
			visible = tmpNode.visible
			tmpNode = tmpNode.parent
			if not visible or not tmpNode or tmpNode.attrs.has('neft:style')
				break

		@item.visible = visible
		return

	setAttr: do ->
		PREFIX_LENGTH = 'style:'.length

		getSplitAttr = do ->
			cache = Object.create null

			(prop) ->
				cache[prop] ||= prop.slice(PREFIX_LENGTH).split ':'

		getPropertyPath = do ->
			cache = Object.create null
			(prop) ->
				cache[prop] ||= prop.slice(PREFIX_LENGTH).replace /:/g, '.'

		getInternalProperty = do ->
			cache = Object.create null
			(prop) ->
				cache[prop] ||= "_#{prop}"

		(attr, val, oldVal) ->
			assert.instanceOf @, Style

			if @waiting or not @item
				@attrsQueue.push attr, val, oldVal
				return

			if attr is 'class'
				@syncClassAttr val, oldVal
				return true

			props = getSplitAttr attr

			# get object
			obj = @item
			for i in [0...props.length-1] by 1
				unless obj = obj[props[i]]
					return false

			# break if property doesn't exist
			prop = utils.last props
			unless prop of obj
				log.warn "Attribute '#{attr}' doesn't exist in item '#{@item}'"
				return false

			# set value
			internalProp = getInternalProperty prop
			if obj[internalProp] is undefined and typeof obj[prop] is 'function' and obj[prop].connect
				if typeof oldVal is 'function'
					obj[prop].disconnect oldVal
				if typeof val is 'function'
					obj[prop] val
			else if @node._attrs[attr] is val and val isnt oldVal
				@attrsClass.changes.setAttribute getPropertyPath(attr), val
				obj[prop] = val

			return true

	syncClassAttr: (val, oldVal) ->
		{item} = @
		{classes} = item
		newClasses = val and val.split(' ')

		# check removed values
		if oldVal and typeof oldVal is 'string'
			oldClasses = oldVal.split ' '
			for name in oldClasses
				if not newClasses or not utils.has(newClasses, name)
					classes.remove name

		# add new classes
		if val and typeof val is 'string'
			newClasses = val.split ' '
			prevIndex = -1
			for name, i in newClasses
				index = classes.index name
				if prevIndex is -1 and index is -1
					index = classes.length
					classes.append name
				else if index isnt prevIndex + 1
					if index isnt -1
						classes.pop index
						if prevIndex > index
							prevIndex--
					index = prevIndex+1
					classes.insert index, name
				prevIndex = index

		return

	isLink: ->
		@node.name is 'a' and @node.attrs.get('href')?[0] isnt '#'

	getLinkUri: ->
		uri = @node.attrs.get('href') + ''
		`//<development>`
		unless ///^([a-z]+:|\/|\$\{)///.test uri
			log.warn "Relative link found `#{uri}`"
		`//</development>`
		uri

	reloadItem: ->
		if @waiting
			return

		unless utils.isClient
			return

		assert.notOk @item

		id = @node.attrs.get 'neft:style'
		assert.isString id

		@isScope = ///^(styles|renderer)\:///.test id
		@item = null
		@scope = null
		@isAutoParent = false

		if id instanceof Renderer.Item
			@item = id
		else if @isScope
			@isAutoParent = true
			if ///^renderer\:///.test(id)
				id = id.slice 'renderer:'.length
				id = utils.capitalize id
				@scope =
					mainItem: new Renderer[id]
					ids: {}
			else if ///^styles\:///.test(id)
				match = /^styles:(.+?)(?:\:(.+?))?(?:\:(.+?))?$/.exec id
				[_, file, style, subid] = match
				style ?= '_main'
				if subid
					parentId = "styles:#{file}:#{style}"
					parent = @parent
					loop
						scope = parent?.scope or windowStyle
						if (scope is windowStyle and file is 'view') or (parent and parent.node.attrs.get('neft:style') is parentId)
							@item = scope?.objects[subid]
						if @item or ((not parent or not (parent = parent.parent)) and scope is windowStyle)
							break

					unless @item
						unless File.Input.test(id)
							log.warn "Can't find `#{id}` style item"
						return

					@isAutoParent = !@item.parent
				else
					@scope = styles[file]?[style]?.getComponent()
					if @scope
						@item = @scope.item
					else
						unless File.Input.test(id)
							log.warn "Style file `#{id}` can't be find"
						return

		@node._documentStyle = @
		@node.style = @item

		if @item
			@item.visible = false
			if @isLink()
				@item.linkUri = @getLinkUri()
			if @attrs
				@attrsClass.target = @item

		# text changes
		if @getTextObject()
			listenTextRec @

		return;

	findItemWithParent = (item, parent) ->
		tmp = item
		while tmp and (tmpParent = tmp._parent)
			if tmpParent is parent
				return tmp
			tmp = tmpParent
		return

	findItemIndex = (node, item, parent) ->
		tmpIndexNode = node
		parent = parent._children?._target or parent
		tmpSiblingNode = tmpIndexNode

		# by parents
		while tmpIndexNode
			# by previous sibling
			while tmpSiblingNode
				if tmpSiblingNode isnt node
					# get sibling item
					if tmpSiblingNode._documentStyle?.parentSet and (tmpSiblingItem = tmpSiblingNode._documentStyle.item)
						if tmpSiblingTargetItem = findItemWithParent(tmpSiblingItem, parent)
							if item isnt tmpSiblingTargetItem
								if item.previousSibling isnt tmpSiblingTargetItem
									item.previousSibling = tmpSiblingTargetItem
							return
					# check children of special tags
					else if tmpSiblingNode.name is 'neft:blank'
						tmpIndexNode = tmpSiblingNode
						tmpSiblingNode = utils.last tmpIndexNode.children
						continue
				# check previous sibling
				tmpSiblingNode = tmpSiblingNode._previousSibling
			# no sibling found, but parent is styled
			if tmpIndexNode isnt node and tmpIndexNode.style
				return
			# check parent
			tmpIndexNode = tmpIndexNode._parent
			tmpSiblingNode = tmpIndexNode._previousSibling

			# out of scope
			if tmpIndexNode._documentStyle?.item is parent
				return
		return

	findItemParent: ->
		if @waiting
			return

		if @isAutoParent and @item and not @item.parent
			{node} = @
			tmpNode = node._parent
			while tmpNode
				if style = tmpNode._documentStyle
					item = style.item
					if style.node isnt tmpNode
						item = item._parent

					if item
						@parentSet = true
						@item.parent = item
						break
				else unless tmpNode.name is 'neft:blank'
					tmpNode._documentStyle = @

				tmpNode = tmpNode._parent

			unless item
				@item.parent = null
		return

	findItemIndex: ->
		if @parentSet
			findItemIndex.call @, @node, @item, @item.parent
			true
		else
			false

	clone: (originalFile, file) ->
		clone = new Style

		clone.file = file
		clone.node = originalFile.node.getCopiedElement @node, file.node
		clone.attrs = @attrs
		clone.index = @index

		# attrs class
		if @attrs
			clone.attrsClass = new Renderer.Class emptyComponent
			clone.attrsClass.priority = 9999

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

		# set attrs
		if @attrs
			for attr of @attrs
				attrVal = clone.node._attrs[attr]
				if attrVal?
					clone.setAttr attr, attrVal, null

		clone

	# synchronize visibility
	{Tag} = File.Element
	opts = utils.CONFIGURABLE
	getter = utils.lookupGetter Tag::, 'visible'
	setter = utils.lookupSetter Tag::, 'visible'
	utils.defineProperty Tag::, 'visible', opts, getter, do (_super = setter) ->
		updateVisibility = (node) ->
			if node._style
				node._documentStyle.updateVisibility()
			else if node instanceof Tag
				for child in node.children
					updateVisibility child
			return

		(val) ->
			if _super.call @, val
				updateVisibility @
				true
			false

	Style
