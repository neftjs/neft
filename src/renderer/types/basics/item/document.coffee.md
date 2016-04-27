Document @extension
===================

	'use strict'

	utils = require 'neft-utils'
	signal = require 'neft-signal'
	assert = require 'neft-assert'
	log = require 'neft-log'

	log = log.scope 'Renderer', 'Document'

	module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class ItemDocument extends itemUtils.DeepObject
		Document = require 'neft-document'
		DocElement = Document.Element
		DocTag = DocElement.Tag
		DocText = DocElement.Text

		@__name__ = 'Document'

		itemUtils.defineProperty
			constructor: ctor
			name: 'document'
			valueConstructor: ItemDocument

*Document* Document()
---------------------

		constructor: (ref) ->
			super ref
			@_node = null
			@_query = ''

			Object.seal @

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
`  text: this.document.node.attrs.value
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
