Document @extension
===================

	'use strict'

	utils = require 'utils'
	signal = require 'signal'
	assert = require 'neft-assert'
	log = require 'log'

	log = log.scope 'Renderer', 'Document'

	module.exports = (Renderer, Impl, itemUtils, Item) -> exports = (ctor) -> class ItemDocument extends itemUtils.DeepObject
		@__name__ = 'Document'

		itemUtils.defineProperty
			constructor: ctor
			name: 'document'
			valueConstructor: ItemDocument

		setProperty = (props, attr, val, oldVal) ->
			if typeof props[attr] is 'function' and props[attr].connect
				if typeof val is 'function'
					props[attr] val
				if typeof oldVal is 'function'
					props[attr].disconnect oldVal
			else
				@_updatingProperty = attr
				props[attr] = val
			return

		onPropertyChange = (prop, oldVal) ->
			if @_updatingProperty is prop or not (node = @_node) or not node.attrs.has(prop)
				return
			if oldVal is undefined
				setProperty.call @, @_ref._$, prop, node._attrs[prop], oldVal
			else
				node.attrs.set prop, @_ref._$[prop]
			return

		onNodeAttrsChange = (attr, oldVal) ->
			unless props = @_ref._$
				return
			setProperty.call @, props, attr, @_node._attrs[attr], oldVal
			return

		enableProperties = ->
			unless props = @_ref._$
				return
			# attrs to properties
			for attr, val of @_node._attrs
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
			@_node = null
			@_visible = false
			@_query = ''
			@_updatingProperty = ''
			@_propertiesCleanQueue = []
			ref.on$Change onPropertyChange, @
			super ref

*ReadOnly* *String* Document::query
-----------------------------------

		utils.defineProperty @::, 'query', null, ->
			@_query
		, (val) ->
			if @_query is ''
				@_query = val
			return

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
			setter: (_super) -> (val) ->
				if @_node
					@_node.onAttrsChange.disconnect onNodeAttrsChange, @
					disableProperties.call @
				_super.call @, val
				if val
					val.onAttrsChange onNodeAttrsChange, @
					enableProperties.call @

*ReadOnly* *Boolean* Document::visible = false
----------------------------------------------

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

This signal is called when the **style item** parent has been found.

		signal.Emitter.createSignal @, 'onShow'

*Signal* Document::onHide(*DocumentHideEvent* event)
----------------------------------------------------

This signal is called when the **style item** is no longer used.

		signal.Emitter.createSignal @, 'onHide'

*DocumentShowEvent* DocumentShowEvent()
---------------------------------------

		exports.ShowEvent = class DocumentShowEvent
			constructor: ->
				@delay = 0
				Object.preventExtensions @

*Integer* DocumentShowEvent::delay = 0
--------------------------------------

*DocumentHideEvent* DocumentHideEvent()
---------------------------------------

		exports.HideEvent = class DocumentHideEvent
			constructor: ->
				@delay = 0
				@nextShowDelay = 0
				Object.preventExtensions @

*Integer* DocumentHideEvent::delay = 0
--------------------------------------

*Integer* DocumentHideEvent::nextShowDelay = 0
----------------------------------------------
