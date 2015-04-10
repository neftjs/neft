Navigator
=========

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) -> class Navigator extends itemUtils.Object

*Object* Navigator
------------------

		constructor: ->
			@_impl = null
			@_language = 'en'
			@_isBrowser = true
			@_isOnline = true
			super()

*Boolean* Navigator.language = 'en'
----------------------------------

		utils.defineProperty @::, 'language', null, ->
			@_language
		, null

*Boolean* Navigator.isBrowser = true
------------------------------------

		utils.defineProperty @::, 'isBrowser', null, ->
			@_isBrowser
		, null

*Boolean* Navigator.isOnline = true
-----------------------------------

*TODO:* browser implementation, qml implementation

### *Signal* Navigator.isOnlineChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'isOnline'
			setter: (_super) -> (val) ->

		Navigator = new Navigator
		Impl.initNavigatorNamespace?.call Navigator
		Navigator
