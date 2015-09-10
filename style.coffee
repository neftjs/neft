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

		style.textWatchingNodes.push node
		if 'onTextChange' of node
			node.onTextChange textChangeListener, style
		if 'onVisibleChange' of node
			node.onVisibleChange textChangeListener, style

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
			if e.name is 'class'
				@syncClassAttr e.oldValue

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
		@waiting = false

		Object.preventExtensions @

	showEvent = new Renderer.Item::document.constructor.ShowEvent
	hideEvent = new Renderer.Item::document.constructor.HideEvent
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
				# render styles
				if globalShowDelay + globalHideDelay <= 0
					for style in stylesToRender
						style.waiting = false
						style.renderItem()
						style.findItemParent()
						style.file.readyToUse = true

					globalShowDelay = 0
					utils.clear stylesToRender

				# revert styles
				if globalHideDelay <= 0
					for style in stylesToRevert
						style.waiting = false
						style.revertItem()
						style.file.readyToUse = true
						assert.notOk style.file.isRendered

					globalHideDelay = 0
					utils.clear stylesToRevert

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

		for child in @children
			child.render()

		if @isScope
			@item.document.onShow.emit showEvent
			globalShowDelay += showEvent.delay
			showEvent.delay = 0

		@item.visible = not @isAutoParent and @visible
		@item.document.visible = false
		@file.readyToUse = false
		stylesToRender.push @
		updateWhenPossible @
		return

	renderItem: ->
		if not @item or not @file.isRendered
			return

		# save classes
		if classes = @item._classes
			unless utils.isEqual(classes.items(), @classes)
				@classes = utils.clone(classes.items())

		@item.visible = @visible
		@item.document.node = @node
		@item.document.visible = true
		@updateText()
		@updateVisibility()
		@syncClassAttr('')

		if @lastItemParent
			@item.parent = @lastItemParent
		
		for name of @attrs
			val = @node.attrs.get name
			@setAttr name, val
		return

	revert: ->
		if @waiting or not @item
			return

		# parent
		if @isAutoParent and @isScope
			@item.document.onHide.emit hideEvent
			globalHideDelay += hideEvent.delay
			globalShowDelay += hideEvent.nextShowDelay
			event.delay = 0
			event.nextShowDelay = 0
		@item.document.visible = false

		@file.readyToUse = false
		stylesToRevert.push @
		updateWhenPossible @

		for child in @children
			child.revert()
		return

	revertItem: ->
		unless @item
			return

		# parent
		if @isAutoParent
			@lastItemParent = null
			if !@parentSet
				@lastItemParent = @item.parent
			@item.parent = null

		itemDocumentNode = @item.document.node
		@item.document.node = null
		@item.visible = @visible
		@item.document.visible = true

		tmpNode = @node
		while tmpNode = tmpNode._parent
			if tmpNode._documentStyle is @
				tmpNode._documentStyle = null
			else
				break

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
		{item} = @
		unless item
			return
		if item.$? and 'text' of item.$
			item.$
		else if 'text' of item
			item
		else if item.label? and 'text' of item.label
			item.label

	updateText: ->
		if @waiting
			return

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
		if @waiting or not @item or not @visible
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

	getInternalProperty = do ->
		cache = Object.create null
		(prop) ->
			cache[prop] ||= "_#{prop}"

	setAttr: (name, val) ->
		assert.instanceOf @, Style

		if @waiting
			return

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
					continue

				internalProp = getInternalProperty prop

				if val of ATTR_PRIMITIVE_VALUES
					val = ATTR_PRIMITIVE_VALUES[val]

				propType = typeof obj[prop]
				if propType is 'object'
					propType = typeof obj[prop]?.valueOf()
				switch propType
					when 'number'
						baseVal = val
						val = parseFloat val
						if isNaN(val) and baseVal isnt 'NaN'
							val = baseVal
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
						internalVal = if internalProp of obj then obj[internalProp] else obj[prop]
						@attrValues.push obj, prop, internalVal
					obj[prop] = val
				return true
			else
				obj = obj[prop]
				unless obj
					return false
		return false

	syncClassAttr: (oldVal) ->
		assert.isString oldVal

		if @waiting
			return

		{item} = @
		unless item
			return
		{classes} = item
		val = @node.attrs.get('class')
		newClasses = val and val.split(' ')

		# check removed values
		if oldVal
			oldClasses = oldVal.split ' '
			for name in oldClasses
				if not newClasses or not utils.has(newClasses, name)
					classes.remove name

		# add new classes
		if val
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
		@node.name is 'a' and not @attrs?.hasOwnProperty('neft:style:onPointerClicked') and @node.attrs.get('href')?[0] isnt '#'

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

		if @item and @isAutoParent
			@item.visible = @visible
			@item.parent = null

		if @item
			while elem = @textWatchingNodes.pop()
				if 'onTextChange' of elem
					elem.onTextChange.disconnect textChangeListener, @
				if 'onVisibleChange' of elem
					elem.onVisibleChange.disconnect textChangeListener, @

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
							@item = scope?.objects[subid]# or scope?.item.$?[subid]
						# @item ?= scope?.?(id)
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
		@visible = @item.visible

		if @isLink()
			@item.linkUri = @getLinkUri()

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
		parent = parent.children.target or parent
		while tmpIndexNode
			tmpSiblingNode = tmpIndexNode
			while tmpSiblingNode = tmpSiblingNode._nextSibling
				if tmpSiblingItem = tmpSiblingNode._documentStyle?.item
					if tmpSiblingTargetItem = findItemWithParent(tmpSiblingItem, parent)
						item.index = tmpSiblingTargetItem.index
						return

			# tmpSiblingNode = tmpIndexNode
			# while tmpSiblingNode = tmpSiblingNode._previousSibling
			# 	if tmpSiblingItem = tmpSiblingNode._documentStyle?.item
			# 		if tmpSiblingTargetItem = findItemWithParent(tmpSiblingItem, parent)
			# 			item.index = tmpSiblingTargetItem.index + 1
			# 			return
			if tmpIndexNode isnt node and tmpIndexNode.style
				return
			tmpIndexNode = tmpIndexNode._parent
		return

	findItemParent: ->
		if @waiting
			return

		if @isAutoParent and @item and not @item.parent
			@parentSet = true
			{node} = @
			tmpNode = node._parent
			while tmpNode
				if style = tmpNode._documentStyle
					item = style.item
					if style.node isnt tmpNode
						item = item._parent

				tmpNode._documentStyle ?= @

				if item
					@item.parent = item

					# find index
					findItemIndex node, @item, item
					break
				tmpNode = tmpNode._parent

			unless item
				@item.parent = null

		for child in @children
			child.findItemParent()

		# HACK
		if item
			while (tmpNode = tmpNode._parent) && not tmpNode.style
				if tmpNode.name is 'neft:use'
					tmpNode._documentStyle = tmpNode.children[0]._documentStyle

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
			if tmpNode.attrs.has('neft:if') or tmpNode.attrs.has('neft:else')
				tmpNode.onVisibleChange visibilityChangeListener, clone

			tmpNode = tmpNode.parent
			if not tmpNode or tmpNode.attrs.has('neft:style')
				break

		clone
