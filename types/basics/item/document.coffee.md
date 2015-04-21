Document @extension
===================

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class Document extends itemUtils.DeepObject
		@__name__ = 'Document'

		itemUtils.defineProperty
			constructor: ctor
			name: 'document'
			valueConstructor: Document

*Document* Document()
---------------------
			
		constructor: (ref) ->
			@_node = null
			super ref

*Document.Element* Document::node
---------------------------------

### *Signal* Document::nodeChanged(*Document.Element* oldValue)

#### Get node attribute in a style item @snippet

```
Text {
  text: this.document.node.attrs.get('value')
}
```

#### Find node child in a style item @snippet

```
Text {
\  document.onNodeChanged: function(){
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

*Signal* Document::show()
-------------------------

This signal is called when the **style item** parent has been found.

		signal.Emitter.createSignal @, 'show'

*Signal* Document::hide()
-------------------------

This signal is called when the **style item** is no longer used.

		signal.Emitter.createSignal @, 'hide'
