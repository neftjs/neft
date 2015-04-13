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

#### Detect client language @snippet

```style
Text {
  text: "Your language: " + Navigator.language
  font.pixelSize: 30
}
```

		utils.defineProperty @::, 'language', null, ->
			@_language
		, null

*Boolean* Navigator.isBrowser = true
------------------------------------

		utils.defineProperty @::, 'isBrowser', null, ->
			@_isBrowser
		, null

*Boolean* Navigator.isNative = false
------------------------------------

#### Detect native application @snippet

```style
Text {
  text: Navigator.isNative ? "Native" : "Browser"
  font.pixelSize: 30
}
```

		utils.defineProperty @::, 'isNative', null, ->
			not @_isBrowser
		, null

*Boolean* Navigator.isOnline = true
-----------------------------------

#### @todo

Browser and qml implementations 

### *Signal* Navigator.isOnlineChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'isOnline'
			setter: (_super) -> (val) ->

		Navigator = new Navigator
		Impl.initNavigatorNamespace?.call Navigator
		Navigator
