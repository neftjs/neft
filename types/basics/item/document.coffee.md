Document @extension
===================

	'use strict'

	utils = require 'neft-utils'
	signal = require 'neft-signal'
	assert = require 'neft-assert'
	log = require 'neft-log'

	log = log.scope 'Renderer', 'Document'

	module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class ItemDocument extends itemUtils.DeepObject
		Document = DocElement = DocTag = DocText = null
		setImmediate ->
			Document = require 'neft-document'
			DocElement = Document.Element
			DocTag = DocElement.Tag
			DocText = DocElement.Text

		@__name__ = 'Document'

		itemUtils.defineProperty
			constructor: ctor
			name: 'document'
			valueConstructor: ItemDocument

		setProperty = (props, attr, val, oldVal) ->
			prop = props[attr]
			if typeof prop is 'function' and prop.connect
				if typeof val is 'function' and prop isnt val
					prop val
				if typeof oldVal is 'function' and prop isnt oldVal
					prop.disconnect oldVal
			else
				@_updatePending = true
				props[attr] = val
				@_updatePending = false
			return

		onPropertyChange = (prop, oldVal) ->
			if @_updatePending or not (node = @_node)
				return
			node.attrs.set prop, @_ref._$[prop]
			return

		onNodeAttrsChange = (attr, oldVal) ->
			unless props = @_ref._$
				return
			if attr of props
				setProperty.call @, props, attr, @_node.attrs.get(attr), oldVal
			return

		enableProperties = ->
			unless props = @_ref._$
				return
			# attrs to properties
			for attr, val of @_node.attrs._data
				if attr of props
					@_propertiesCleanQueue.push attr, props[attr], val
					setProperty.call @, props, attr, val, null
			return

		disableProperties = ->
			unless (propertiesCleanQueue = @_propertiesCleanQueue).length
				return
			props = @_ref._$
			for attr, i in propertiesCleanQueue by 3
				setProperty.call @, props, attr, propertiesCleanQueue[i+1], propertiesCleanQueue[i+2]
			utils.clear propertiesCleanQueue
			return

*Document* Document()
---------------------

		constructor: (ref) ->
			super ref
			@_node = null
			@_visible = false
			@_query = ''
			@_propertiesCleanQueue = []
			@_updatePending = false

			Object.seal @

			ref.on$Change onPropertyChange, @

ReadOnly *String* Document::query
---------------------------------

		utils.defineProperty @::, 'query', null, ->
			@_query
		, (val) ->
			if @_query is ''
				@_query = val
			return

*Document.Element* Document::node
---------------------------------

## *Signal* Document::onNodeChange(*Document.Element* oldValue)

```nml
`Text {
`  text: this.document.node.attrs.get('value')
`}
```

```nml
`Text {
`	document.onNodeChange: function(){
`		var inputs = this.document.node.queryAll('input[type=string]');
`	}
`}
```

		itemUtils.defineProperty
			constructor: @
			name: 'node'
			defaultValue: null
			namespace: 'document'
			parentConstructor: ctor
			developmentSetter: (val) ->
				if val?
					assert.instanceOf val, DocElement
			setter: (_super) -> (val) ->
				if @_node instanceof DocTag
					@_node.onAttrsChange.disconnect onNodeAttrsChange, @
					disableProperties.call @
				_super.call @, val
				if val instanceof DocTag
					val.onAttrsChange onNodeAttrsChange, @
					enableProperties.call @

ReadOnly *Boolean* Document::visible = false
--------------------------------------------

		itemUtils.defineProperty
			constructor: @
			name: 'visible'
			defaultValue: false
			namespace: 'document'
			parentConstructor: ctor
			developmentSetter: (val) ->
				assert.isBoolean val

*Signal* Document::onShow(*DocumentShowEvent* event)
----------------------------------------------------

This signal is called when the style item parent has been found.

		signal.Emitter.createSignal @, 'onShow'

*Signal* Document::onHide(*DocumentHideEvent* event)
----------------------------------------------------

This signal is called when the style item is no longer used.

		signal.Emitter.createSignal @, 'onHide'

*DocumentShowEvent* DocumentShowEvent()
---------------------------------------

		@ShowEvent = class DocumentShowEvent
			constructor: ->
				@delay = 0
				Object.preventExtensions @

Hidden *Integer* DocumentShowEvent::delay = 0
---------------------------------------------

*DocumentHideEvent* DocumentHideEvent()
---------------------------------------

		@HideEvent = class DocumentHideEvent
			constructor: ->
				@delay = 0
				@nextShowDelay = 0
				Object.preventExtensions @

Hidden *Integer* DocumentHideEvent::delay = 0
---------------------------------------------

Hidden *Integer* DocumentHideEvent::nextShowDelay = 0
-----------------------------------------------------
