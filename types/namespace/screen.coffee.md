Screen @namespace
======

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) ->
		class Screen extends itemUtils.Object

*Object* Screen
---------------

			constructor: ->
				@_touch = false
				@_width = 1024
				@_height = 800
				@_orientation = 'Portrait'
				super()

*Boolean* Screen.touch = false
------------------------------

#### Detect touch screen @snippet

```style
Text {
  text: Screen.touch ? "Touch" : "Mouse"
  font.pixelSize: 30
}
```

			utils.defineProperty @::, 'touch', null, ->
				@_touch
			, null

*Boolean* Screen.width = 1024
-----------------------------

			utils.defineProperty @::, 'width', null, ->
				@_width
			, null

*Boolean* Screen.height = 800
-----------------------------

			utils.defineProperty @::, 'height', null, ->
				@_height
			, null

*String* Screen.orientation = 'Portrait'
----------------------------------------

May contains: Portrait, Landscape, InvertedPortrait, InvertedLandscape

#### @todo

Browser implementation 

### *Signal* Screen.onOrientationChange(*String* oldValue)

			signal.Emitter.createSignal @, 'onOrientationChange'
			utils.defineProperty Screen::, 'orientation', null, ->
				@_orientation
			, null

		screen = new Screen
		Impl.initScreenNamespace?.call screen
		screen
