Device @namespace
======

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) ->
		class Device extends itemUtils.Object

*Object* Device
---------------

			constructor: ->
				@_platform = 'unix'
				@_desktop = true
				@_phone = false
				@_pixelRatio = 1
				super()

*Boolean* Device.platform = 'unix'
----------------------------------

Possible values are:
 - **android**,
 - **ios**,
 - **blackberry**,
 - **wince** (Windows CE),
 - **winrt** (Windows RT),
 - **winphone** (Windows Phone),
 - **linux**,
 - **windows**,
 - **unix**,
 - **osx**.

#### Detect client device platform @snippet

```style
Text {
  text: "You are using: " + Device.platform
  font.pixelSize: 30
}
```

			utils.defineProperty @::, 'platform', null, ->
				@_platform
			, null

*Boolean* Device.desktop = true
-------------------------------

			utils.defineProperty @::, 'desktop', null, ->
				@_desktop
			, null

*Boolean* Device.tablet = false
-------------------------------

			utils.defineProperty @::, 'tablet', null, ->
				not @desktop and not @phone
			, null

*Boolean* Device.phone = false
------------------------------

			utils.defineProperty @::, 'phone', null, ->
				@_phone
			, null

*Boolean* Device.mobile = false
-------------------------------

Tablet or a phone.

#### Detect mobile device @snippet

```style
Text {
  text: Device.mobile ? 'Mobile' : 'Desktop'
  font.pixelSize: 30
}
```

			utils.defineProperty @::, 'mobile', null, ->
				@tablet or @phone
			, null

*Boolean* Device.pixelRatio = 1
-------------------------------

#### Detect retina display @snippet

```style
Text {
  text: Device.pixelRatio >= 2 ? 'Retina' : 'Non-retina'
  font.pixelSize: 30
}
```

			utils.defineProperty @::, 'pixelRatio', null, ->
				@_pixelRatio
			, null

		device = new Device
		Impl.initDeviceNamespace?.call device
		device
