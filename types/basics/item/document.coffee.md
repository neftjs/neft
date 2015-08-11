Document @extension
===================

	'use strict'

	utils = require 'utils'
	signal = require 'signal'
	assert = require 'neft-assert'
	log = require 'log'
	# Document = require 'document'

	log = log.scope 'Renderer', 'Document'

	# {Element} = Document
	# {Tag, Text} = Element

	module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class ItemDocument extends itemUtils.DeepObject
		@__name__ = 'Document'

		itemUtils.defineProperty
			constructor: ctor
			name: 'document'
			valueConstructor: ItemDocument

*Document* Document()
---------------------
			
		constructor: (ref) ->
			# @_query = ''
			@_node = null
			@_visible = false
			@_documentStyle = null
			# @_isAutoParent = false
			# @_parentDocument = @
			# @_watcher = null
			# @_watcherNodes = []
			# @_defaultText = ''
			# @_isLinkUriSet = false
			# @_baseLinkUri = ''
			# @_isTextSet = false
			# @_baseText = ''
			@_query = ''
			super ref

*ReadOnly* *String* Document::query
-----------------------------------

		utils.defineProperty @::, 'query', null, ->
			@_query
		, (val) ->
			if @_query is ''
				@_query = val
			return

	# 	onWatchNodeAdd = (node) ->
	# 		ref = @_ref

	# 		# get item
	# 		if @_node is null
	# 			item = ref
	# 		else
	# 			if ref._file.item is ref
	# 				item = ref._file.createItem()
	# 			else
	# 				item = ref._file.cloneItem ref.id
	# 			item.document._parentDocument = @

	# 		@_watcherNodes.push node

	# 		node._styles ?= []
	# 		if node._styles.push(item) is 1
	# 			item.document.node = node
	# 		return

	# 	onWatchNodeRemove = (node) ->
	# 		item = node.style
	# 		parentDoc = item._document._parentDocument
	# 		if parentDoc is @
	# 			item._document.node = null
	# 			node._styles.shift()
	# 			node.style?.document.node = node
	# 		else
	# 			for style, i in node._styles
	# 				parentDoc = style._document._parentDocument
	# 				if parentDoc is @
	# 					node._styles.splice i, 1
	# 					break
	# 		utils.remove parentDoc._watcherNodes, node
	# 		return

	# 	updateChildrenQueryWatchersRec = (item, parentNode) ->
	# 		for child in item.children
	# 			if child._file is item._file and child._file.item isnt child._file and child._document?._query
	# 				child._document.updateQueryWatcher parentNode
	# 			else
	# 				updateChildrenQueryWatchersRec child, parentNode
	# 		return

	# 	updateQueryWatcher: (parentNode) ->
	# 		ref = @_ref
	# 		file = ref._file

	# 		if @_watcher
	# 			# watcher
	# 			@_watcher.disconnect()
	# 			@_watcher = null

	# 			# nodes
	# 			watcherNodes = @_watcherNodes
	# 			n = watcherNodes.length
	# 			i = 0
	# 			while n--
	# 				onWatchNodeRemove.call @, watcherNodes[0]

	# 		if val = @_query
	# 			if file.item isnt ref and not (watchNode = parentNode)
	# 				tmp = ref
	# 				while tmp = tmp._parent
	# 					if tmp._document?._query
	# 						watchNode = tmp._document._node
	# 						break
	# 					if tmp is file.item
	# 						break
	# 			watchNode ?= Renderer.documentGlobalNode

	# 			# nodes
	# 			nodes = watchNode.queryAll val
	# 			for node in nodes
	# 				onWatchNodeAdd.call @, node

	# 			# watcher
	# 			watcher = @_watcher = watchNode.watch val
	# 			watcher.onAdd onWatchNodeAdd, @
	# 			watcher.onRemove onWatchNodeRemove, @
	# 		return

	# 	itemUtils.defineProperty
	# 		constructor: @
	# 		name: 'query'
	# 		defaultValue: ''
	# 		namespace: 'document'
	# 		parentConstructor: ctor
	# 		developmentSetter: (val) ->
	# 			assert.isString val
	# 		setter: (_super) -> (val) ->
	# 			if @_query is val
	# 				return

	# 			_super.call @, val

	# 			file = @_ref._file
	# 			if not file or file.isClone
	# 				return

	# 			@updateQueryWatcher null

	# 			return

*Document.Element* Document::node
---------------------------------

### *Signal* Document::onNodeChange(*Document.Element* oldValue)

#### Get node attribute in a style item @snippet

```
Text {
  text: this.document.node.attrs.get('value')
}
```

#### Find node child in a style item @snippet

```
Text {
\  document.onNodeChange: function(){
\    var inputs = this.document.node.queryAll('input[type=string]');
\  }
}
```

		itemUtils.defineProperty
			constructor: @
			name: 'node'
			defaultValue: null
			namespace: 'document'
			parentConstructor: ctor
			developmentSetter: (val) ->
				if val?
					assert.instanceOf val, require('document').Element.Tag

*ReadOnly* *Boolean* Document::visible
--------------------------------------

		itemUtils.defineProperty
			constructor: @
			name: 'visible'
			defaultValue: false
			namespace: 'document'
			parentConstructor: ctor
			developmentSetter: (val) ->
				assert.isBoolean val

		# itemUtils.defineProperty
		# 	constructor: @
		# 	name: 'node'
		# 	defaultValue: null
		# 	namespace: 'document'
		# 	parentConstructor: ctor
		# 	developmentSetter: (val) ->
		# 		if val?
		# 			assert.instanceOf val, Tag
		# 	setter: (_super) -> (val) ->
		# 		oldVal = @_node
		# 		ref = @_ref
		# 		if oldVal is val
		# 			return

		# 		_super.call @, val

		# 		if oldVal
		# 			if @_isAutoParent
		# 				ref.parent = null
		# 			if @_parentDocument isnt @
		# 				ref._file.cacheItem ref
		# 			if textObj = getTextObject(ref)
		# 				textObj.text = @_defaultText

		# 		if val
		# 			val._documentStyle = @
		# 			if @_isAutoParent = !ref._parent
		# 				@updateParent()
		# 			@_defaultText = getTextObject(ref)?.text or ''
		# 			@updateLinkUri()
		# 			@updateText()
		# 			@updateVisibility()
		# 			@updateIndex()
		# 			@updateAttributes()

		# 		updateChildrenQueryWatchersRec ref, val

		# 		return

		# updateLinkUri: ->
		# 	uri = ''
		# 	node = @_node
		# 	isLink = node.name is 'a'
		# 	isLink &&= node.attrs.get('href')?[0] isnt '#'
		# 	isLink &&= not node.attrs.get('neft:style:onPointerClick') and not node.attrs.get('onPointerClick')
		# 	unless isLink
		# 		node = node.children[0]
		# 		isLink = !!node
		# 		isLink &&= node.name is 'a'
		# 		isLink &&= not node._nextSibling
		# 		isLink &&= node.attrs.get('href')?[0] isnt '#'
		# 	if isLink
		# 		uri = node.attrs.get('href') + ''
		# 		`//<development>`
		# 		unless ///^([a-z]+:|\/|\$\{)///.test(uri)
		# 			log.warn "Relative link found '#{uri}'"
		# 		`//</development>`

		# 	@_ref.linkUri = uri
		# 	return

		# ###
		# Visibility synchronization
		# ###
		# propagateVisibilityChange = (node, val) ->
		# 	if node.style
		# 		node.style.visible = val
		# 	else
		# 		for child in node.children
		# 			if child instanceof Tag
		# 				propagateVisibilityChange child, val
		# 	return

		# updateVisibility: ->
		# 	tmp = @_node
		# 	while tmp
		# 		unless tmp.visible
		# 			@_ref.visible = false
		# 			break
		# 		if tmp.style
		# 			break
		# 		tmp = tmp._parent
		# 	return

		# opts = utils.CONFIGURABLE
		# getter = utils.lookupGetter Tag::, 'visible'
		# setter = utils.lookupSetter Tag::, 'visible'
		# utils.defineProperty Tag::, 'visible', opts, getter, do (_super = setter) -> (val) ->
		# 	if r = _super.call(@, val)
		# 		propagateVisibilityChange @, val
		# 	r

		# ###
		# Text synchronization
		# ###
		# getTextObject = (item) ->
		# 	if item.$? and 'text' of item.$
		# 		item.$
		# 	else if 'text' of item
		# 		item
		# 	else if item.label? and 'text' of item.label
		# 		item.label

		# updateText: ->
		# 	ref = @_ref
		# 	obj = getTextObject ref
		# 	node = @_node
		# 	if node.children.length is 1 and node.children[0].name is 'a'
		# 		node = node.children[0]
		# 		# href = node.attrs.get('href')
		# 		# if typeof href is 'string'
		# 			# unless @_isLinkUriSet
		# 			# 	@_isLinkUriSet = true
		# 			# 	@_baseLinkUri = ref.linkUri
		# 			# ref.linkUri = href

		# 	if obj
		# 		text = node.stringifyChildren()

		# 		if text.length > 0# or @_isTextSet
		# 			# @_isTextSet = true
		# 			# @_baseText = obj.text
		# 			obj.text = text
		# 	return

		# opts = utils.CONFIGURABLE
		# getter = utils.lookupGetter Text::, 'text'
		# setter = utils.lookupSetter Text::, 'text'
		# utils.defineProperty Text::, 'text', opts, getter, do (_super = setter) -> (val) ->
		# 	if r = _super.call(@, val)
		# 		tmp = @
		# 		while tmp = tmp._parent
		# 			if tmp.style
		# 				tmp.style._document.updateText()
		# 				break
		# 	r

		# ###
		# Attributes synchronization
		# ###
		# ATTR_PRIMITIVE_VALUES =
		# 	__proto__: null
		# 	'null': null
		# 	'undefined': undefined
		# 	'false': false
		# 	'true': true

		# getSplitAttr = do ->
		# 	cache = Object.create null
		# 	(prop) ->
		# 		cache[prop] ||= (prop.slice('neft:style:'.length)).split ':'

		# setAttr: (name, val) ->
		# 	# {funcs} = @file
		# 	# if funcs?.hasOwnProperty(val)
		# 	# 	val = funcs[val]
			
		# 	if name.indexOf('neft:style') isnt 0
		# 		r = @setAttr("neft:style:$:#{name}", val)
		# 		r ||= @setAttr("neft:style:#{name}", val)
		# 		return r

		# 	props = getSplitAttr(name)

		# 	obj = @_ref
		# 	for i in [0...props.length-1] by 1
		# 		obj = obj[props[i]]
		# 		unless obj
		# 			return false

		# 	prop = props[props.length-1]
		# 	unless prop of obj
		# 		# log.error "Can't set the '#{prop}' property, because this property doesn't exist"
		# 		return false

		# 	if val of ATTR_PRIMITIVE_VALUES
		# 		val = ATTR_PRIMITIVE_VALUES[val]

		# 	switch typeof obj[prop]
		# 		when 'number'
		# 			val = parseFloat val
		# 		when 'boolean'
		# 			if val is ''
		# 				val = true
		# 			else
		# 				val = !!val
		# 		when 'string'
		# 			val = val+''

		# 	if typeof obj[prop] is 'function' and typeof val is 'function'
		# 		obj[prop] val
		# 		# @attrListeners.push obj, prop, val
		# 	else
		# 		`//<development>`
		# 		if typeof obj[prop] is 'function' and not utils.lookupSetter(obj, prop)
		# 			log.error "#{name} is a signal handler and expects function, but #{val} got"
		# 		`//</development>`

		# 		# unless @setAttrs[name]
		# 		# 	@setAttrs[name] = true
		# 		# 	@attrValues.push obj, prop, obj[prop]
		# 		obj[prop] = val
		# 	return true

		# updateAttributes: ->
		# 	for attr, val of @_node._attrs
		# 		@setAttr attr, val
		# 	return

		# Tag.Attrs.set = do (_super = Tag.Attrs.set) -> (name, val) ->
		# 	if r = _super.call(@, name, val)
		# 		{tag} = Tag.Attrs
		# 		if style = tag.style
		# 			if name is 'href' and tag.name is 'a'
		# 				style._document.updateLinkUri()
		# 			else
		# 				style._document.setAttr name, val
		# 		else if name is 'href' and (style = tag._parent.style)
		# 			style._document.updateLinkUri()
		# 	r

		# ###
		# Index synchronization
		# ###
		# updateIndex: ->

		# propagateIndexChange = (node) ->
		# 	if node.style
		# 		node.style._document.updateIndex()
		# 	else
		# 		for child in node.children
		# 			if child instanceof Tag
		# 				propagateIndexChange child
		# 	return

		# opts = utils.CONFIGURABLE
		# getter = utils.lookupGetter Element::, 'index'
		# setter = utils.lookupSetter Element::, 'index'
		# utils.defineProperty Element::, 'index', opts, getter, do (_super = setter) -> (val) ->
		# 	if r = _super.call(@, val)
		# 		propagateIndexChange @
		# 	r

		# ###
		# Parent synchronization
		# ###
		# updateParent: ->
		# 	unless @_isAutoParent
		# 		return

		# 	ref = @_ref
		# 	node = @_node
		# 	tmpNode = node._parent
		# 	while tmpNode
		# 		if style = tmpNode._documentStyle
		# 			item = style._ref
		# 			if style.node isnt tmpNode
		# 				item = item._parent

		# 		tmpNode._documentStyle ?= @

		# 		if item
		# 			ref.parent = item

		# 			# find index
		# 			tmpIndexNode = node
		# 			item = item._sourceItem or item
		# 			while tmpIndexNode
		# 				if tmpIndexNode._nextSibling?._documentStyle?._ref?.parent is item
		# 					ref.index = tmpIndexNode._nextSibling._documentStyle._ref.index
		# 					break
		# 				if tmpIndexNode isnt node and tmpIndexNode.style
		# 					break
		# 				tmpIndexNode = tmpIndexNode._parent

		# 			@onShow.emit()
		# 			break
		# 		tmpNode = tmpNode._parent

		# 	unless item
		# 		ref.parent = null

		# 	# HACK
		# 	if item
		# 		while (tmpNode = tmpNode._parent) && not tmpNode.style
		# 			if tmpNode.name is 'neft:use'
		# 				tmpNode._documentStyle = tmpNode.children[0]._documentStyle

		# 	return

		# propagateParentChange = (node) ->
		# 	if node.style
		# 		node.style._document.updateParent()
		# 	else
		# 		for child in node.children
		# 			if child instanceof Tag
		# 				propagateParentChange child
		# 	return

		# opts = utils.CONFIGURABLE
		# getter = utils.lookupGetter Tag::, 'parent'
		# setter = utils.lookupSetter Tag::, 'parent'
		# utils.defineProperty Tag::, 'parent', opts, getter, do (_super = setter) -> (val) ->
		# 	if r = _super.call(@, val)
		# 		propagateParentChange @
		# 	r

*Signal* Document::onShow(*DocumentShowEvent* event)
----------------------------------------------------

This signal is called when the **style item** parent has been found.

		signal.Emitter.createSignal @, 'onShow'

*Signal* Document::onHide(*DocumentHideEvent* event)
----------------------------------------------------

This signal is called when the **style item** is no longer used.

		signal.Emitter.createSignal @, 'onHide'

*DocumentShowEvent* DocumentShowEvent()
---------------------------------------

		@ShowEvent = class DocumentShowEvent
			constructor: ->
				@delay = 0
				Object.preventExtensions @

*Integer* DocumentShowEvent::delay = 0
--------------------------------------

*DocumentHideEvent* DocumentHideEvent()
---------------------------------------

		@HideEvent = class DocumentHideEvent
			constructor: ->
				@delay = 0
				@nextShowDelay = 0
				Object.preventExtensions @

*Integer* DocumentHideEvent::delay = 0
--------------------------------------

*Integer* DocumentHideEvent::nextShowDelay = 0
----------------------------------------------
