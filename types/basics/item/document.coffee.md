Document Modeling integration
=============================

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils, Item) ->
		class Document extends itemUtils.DeepObject
			@__name__ = 'Document'

*Document* Document()
-------------------
			
			constructor: (ref) ->
				@_node = null
				super ref

*Document.Element* Document::node
---------------------------------

### *Signal* Document::nodeChanged(*Document.Element* oldValue)

		itemUtils.defineProperty
			constructor: Document
			name: 'node'
			defaultValue: null
			namespace: 'document'
			parentConstructor: Item

*Signal* Document::show()
-------------------------

This signal is called when the **style item** parent has been found.

		signal.Emitter.createSignal Document, 'show'

*Signal* Document::hide()
-------------------------

This signal is called when the **style item** is no longer used.

		signal.Emitter.createSignal Document, 'hide'

*Item* Item()
-------------

*Document* Item::document
-------------------------

Reference to the **Document** class instance.

Always use access by item, because all [Renderer.Item][]s shares the same instance.

		itemUtils.defineProperty
			constructor: Item
			name: 'document'
			valueConstructor: Document

		Document
