'use strict'

assert = require 'assert'
utils = require 'utils'
signal = require 'signal'
log = require 'log'
Renderer = require 'renderer'

log = log.scope 'Styles'

module.exports = (File, data) -> class Style
	{windowStyle, styles, queries} = data
	{Element} = File
	{Tag, Text} = Element

	@__name__ = 'Style'
	@__path__ = 'File.Style'

	JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Style) - 1

	i = 1
	JSON_NODE = i++
	JSON_ATTRS = i++
	JSON_CHILDREN = i++
	JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

	@applyStyleQueriesInDocument = (file) ->
		assert.instanceOf file, File

		for elem in queries
			nodes = file.node.queryAll elem.query
			for node in nodes
				unless node instanceof Tag
					log.warn "document.query can be attached only to tags; " +
						"query '#{elem.query}' has been omitted for this node"
					continue
				unless node.attrs.has('neft:style')
					node.attrs.set 'neft:style', elem.style

		file

	@createStylesInDocument = do ->
		getStyleAttrs = (node) ->
			attrs = null
			for attr of node.attrs._data
				if attr is 'class' or attr.slice(0, 6) is 'style:'
					attrs ?= {}
					attrs[attr] = true
			attrs

		forNode = (file, node, parentStyle) ->
			isText = node instanceof Text
			if isText or (attr = node.attrs.get('neft:style'))
				style = new Style
				style.file = file
				style.node = node
				style.parent = parentStyle
				style.attrs = not isText and getStyleAttrs node

				if parentStyle
					parentStyle.children.push style
				else
					file.styles.push style

				parentStyle = style

			unless isText
				for child in node.children
					forNode file, child, parentStyle
			return

		(file) ->
			assert.instanceOf file, File
			forNode file, file.node, null
			file

	@extendDocumentByStyles = (file) ->
		assert.instanceOf file, File

		Style.applyStyleQueriesInDocument file
		Style.createStylesInDocument file

		file

	@_fromJSON = (file, arr, obj) ->
		unless obj
			obj = new Style
		obj.file = file
		obj.node = file.node.getChildByAccessPath arr[JSON_NODE]
		obj.attrs = arr[JSON_ATTRS]

		for child in arr[JSON_CHILDREN]
			cloneChild = Style._fromJSON file, child
			cloneChild.parent = obj
			obj.children.push cloneChild

		obj

	emptyComponent = new Renderer.Component

	listenTextRec = (style, node=style.node) ->
		assert.instanceOf style, Style
		assert.instanceOf node, File.Element

		style.textWatchingNodes.push node
		node.onVisibleChange textChangeListener, style
		if node instanceof Text
			node.onTextChange textChangeListener, style
		if node instanceof Tag
			node.onChildrenChange textChangeListener, style

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
			@setAttr name, @node.attrs._data[name], oldValue
		return

	constructor: ->
		@file = null
		@node = null
		@attrs = null
		@parent = null
		@isScope = false
		@isAutoParent = true
		@enabled = true
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
		@attrsQueue = []
		@attrsClass = null
		@isRendered = false

		Object.seal @

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
				setImmediate sync
				pending = true

			style.waiting = true
			return

	render: ->
		if @waiting or not @enabled
			return

		assert.notOk @isRendered

		if @isAutoParent and not @getVisibility()
			return

		unless @item
			@reloadItem()
		unless @item
			return

		@isRendered = true

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
		if not @item or not @file.isRendered or not @enabled
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
		if @waiting or not @isRendered
			return

		@isRendered = false

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
		if @node instanceof Text
			item
		else if item._$ and 'text' of item._$
			item._$
		else if 'text' of item
			item

	updateText: ->
		if @waiting
			return

		{node} = @
		isText = node instanceof Text

		# linkUri
		anchor = node
		while anchor = anchor.parent
			if anchor.style
				break
			if anchor.name is 'a'
				href = anchor.attrs.get('href')
				if typeof href is 'string'
					unless @isLinkUriSet
						@isLinkUriSet = true
						@baseLinkUri = @item.linkUri
					@item.linkUri = href
				break

		# text
		obj = @getTextObject()
		if obj
			# break if already has a parent with text
			shouldSetText = true
			parent = node
			while parent = parent.parent
				if parent._documentStyle?.isTextSet
					shouldSetText = false
					break

			# break if has a styles children
			if shouldSetText and node instanceof Tag and node.query('[neft:style]')
				shouldSetText = false

			if shouldSetText
				if isText
					text = node.text
					@item.visible = text.length > 0
				else
					text = node.stringifyChildren()

				if text.length > 0 or @isTextSet
					@isTextSet = true
					obj.text = text
			else
				if isText
					@item.visible = false
		return

	getVisibility: ->
		visible = true
		tmpNode = @node
		loop
			visible = tmpNode._visible
			tmpNode = tmpNode._parent
			if not visible or not tmpNode or tmpNode._style
				break
		visible

	updateVisibility: ->
		if @waiting
			return

		if @node instanceof Text and not @isTextSet
			visible = false
		else
			visible = @getVisibility()

		if visible and not @isRendered and @file.isRendered
			@render()

		if @item
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

			if @waiting or not @isRendered or not @item
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
			else if @node.attrs._data[attr] is val and val isnt oldVal
				@attrsClass.changes.setAttribute getPropertyPath(attr), val
				obj[prop] = val

			return true

	syncClassAttr: (val, oldVal) ->
		{item} = @
		{classes} = item
		newClasses = val and val.split(' ')

		# check removed values
		if typeof oldVal is 'string' and oldVal isnt ''
			oldClasses = oldVal.split ' '
			for name in oldClasses when name isnt ''
				if not newClasses or not utils.has(newClasses, name)
					classes.remove name

		# add new classes
		if typeof val is 'string' and val isnt ''
			newClasses = val.split ' '
			prevIndex = -1
			for name, i in newClasses when name isnt ''
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
		@node.name is 'a' and @node.attrs.get('href')? and @node.attrs.get('href')?[0] isnt '#'

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

		if @node instanceof Tag
			id = @node.attrs.get 'neft:style'
			assert.isString id
			@isScope = ///^(styles|renderer)\:///.test id
		else if @node instanceof Text
			id = Renderer.Text.New emptyComponent
			assert.isNotDefined @item

		@item = null
		@scope = null

		if id instanceof Renderer.Item
			@item = id
			@isAutoParent = not id.parent
		else if @isScope
			@isAutoParent = true
			if ///^styles\:///.test(id)
				match = /^styles:(.+?)(?:\:(.+?))?(?:\:(.+?))?$/.exec id
				[_, file, style, subid] = match
				style ?= '_main'
				if subid
					parentId = "styles:#{file}:#{style}"
					parent = @parent
					loop
						if parent and parent.node.attrs.get('neft:style') is parentId
							unless parent.scope
								# parent is not ready yet
								return
							scopeParent = parent
							@item = parent.scope.objects[subid]
						else if not parent?.scope and file is 'view'
							@item = windowStyle.objects[subid]
						if @item or ((not parent or not (parent = parent.parent)) and scope is windowStyle)
							break

					unless @item
						log.warn "Can't find `#{id}` style item"
						return

					# disable parent's with no possibility to properly synchronize
					if scopeParent
						parent = @
						while (parent = parent.parent) isnt scopeParent
							if parent.isAutoParent
								parent.enabled = false

					@isAutoParent = !@item.parent
				else
					@scope = styles[file]?[style]?.getComponent()
					if @scope
						@item = @scope.item
					else
						log.warn "Style file `#{id}` can't be find"
						return
		else
			@isAutoParent = false

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
					tmpSiblingDocStyle = tmpSiblingNode._documentStyle
					if tmpSiblingDocStyle?.parentSet and (tmpSiblingItem = tmpSiblingDocStyle.item)
						if tmpSiblingTargetItem = findItemWithParent(tmpSiblingItem, parent)
							if item isnt tmpSiblingTargetItem
								if item.previousSibling isnt tmpSiblingTargetItem
									item.previousSibling = tmpSiblingTargetItem
							return
					# check children of special tags
					else unless tmpSiblingNode._documentStyle
						tmpIndexNode = tmpSiblingNode
						tmpSiblingNode = utils.last tmpIndexNode.children
						continue
				# check previous sibling
				tmpSiblingNode = tmpSiblingNode._previousSibling
			# no sibling found, but parent is styled
			if tmpIndexNode isnt node and tmpIndexNode.style
				return
			# check parent
			if tmpSiblingNode = tmpIndexNode._previousSibling
				tmpIndexNode = tmpSiblingNode
			else if tmpIndexNode = tmpIndexNode._parent
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

				tmpNode = tmpNode._parent

			unless item
				@item.parent = null
		return

	findItemIndex: ->
		if @parentSet or not @isAutoParent
			findItemIndex.call @, @node, @item, @item.parent
			true
		else
			false

	clone: (originalFile, file) ->
		clone = new Style

		clone.file = file
		node = clone.node = originalFile.node.getCopiedElement @node, file.node
		clone.attrs = @attrs

		node._documentStyle = clone

		if node instanceof Tag
			styleAttr = node.attrs._data['neft:style']
			clone.isAutoParent = not /^styles:(.+?)\:(.+?)\:(.+?)$/.test(styleAttr)

		# attrs class
		if @attrs
			clone.attrsClass = Renderer.Class.New emptyComponent
			clone.attrsClass.priority = 9999

		# clone children
		for child in @children
			child = child.clone originalFile, file
			child.parent = clone
			clone.children.push child

		# break for the abstract
		unless utils.isClient
			return clone

		# changes
		if node instanceof Tag
			clone.node.onAttrsChange attrsChangeListener, clone

		# set attrs
		if @attrs
			for attr of @attrs
				attrVal = clone.node.attrs._data[attr]
				if attrVal?
					clone.setAttr attr, attrVal, null

		clone

	toJSON: do ->
		callToJSON = (elem) ->
			elem.toJSON()

		(key, arr) ->
			unless arr
				arr = new Array JSON_ARGS_LENGTH
				arr[0] = JSON_CTOR_ID
			arr[JSON_NODE] = @node.getAccessPath @file.node
			arr[JSON_ATTRS] = @attrs
			arr[JSON_CHILDREN] = @children.map callToJSON
			arr

	# synchronize visibility
	opts = utils.CONFIGURABLE
	getter = utils.lookupGetter Element::, 'visible'
	setter = utils.lookupSetter Element::, 'visible'
	utils.defineProperty Element::, 'visible', opts, getter, do (_super = setter) ->
		updateVisibility = (node) ->
			if style = node._documentStyle
				hasItem = !!style.item
				style.updateVisibility()
				if hasItem and style.isAutoParent
					return
			if node instanceof Tag
				for child in node.children
					updateVisibility child
			return

		(val) ->
			if _super.call @, val
				updateVisibility @
				true
			false

	Style
