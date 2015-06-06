Navigator @namespace
=========

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) ->
		class Navigator extends itemUtils.Object

*Object* Navigator
------------------

			constructor: ->
				@_impl = null
				@_language = 'en'
				@_browser = true
				@_online = true
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

*Boolean* Navigator.browser = true
----------------------------------

			utils.defineProperty @::, 'browser', null, ->
				@_browser
			, null

*Boolean* Navigator.native = false
----------------------------------

#### Detect native application @snippet

```style
Text {
  text: Navigator.native ? "Native" : "Browser"
  font.pixelSize: 30
}
```

			utils.defineProperty @::, 'native', null, ->
				not @_browser
			, null

*Boolean* Navigator.online = true
---------------------------------

#### @todo

Browser and qml implementations 

### *Signal* Navigator.onOnlineChange(*Boolean* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'online'
				setter: (_super) -> (val) ->

		navigator = new Navigator
		Impl.initNavigatorNamespace?.call navigator
		navigator
