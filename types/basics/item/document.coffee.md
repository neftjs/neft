Document @extension
===================

	'use strict'

	utils = require 'utils'
	signal = require 'signal'
	assert = require 'neft-assert'
	log = require 'log'

	log = log.scope 'Renderer', 'Document'

	module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class ItemDocument extends itemUtils.DeepObject
		@__name__ = 'Document'

		itemUtils.defineProperty
			constructor: ctor
			name: 'document'
			valueConstructor: ItemDocument

*Document* Document()
---------------------
			
		constructor: (ref) ->
			@_node = null
			@_visible = false
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
