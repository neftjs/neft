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
				@_isDesktop = true
				@_isPhone = false
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

*Boolean* Device.isDesktop = true
---------------------------------

			utils.defineProperty @::, 'isDesktop', null, ->
				@_isDesktop
			, null

*Boolean* Device.isTablet = false
---------------------------------

			utils.defineProperty @::, 'isTablet', null, ->
				not @isDesktop and not @isPhone
			, null

*Boolean* Device.isPhone = false
--------------------------------

			utils.defineProperty @::, 'isPhone', null, ->
				@_isPhone
			, null

*Boolean* Device.isMobile = false
---------------------------------

Tablet or a phone.

#### Detect mobile device @snippet

```style
Text {
  text: Device.isMobile ? 'Mobile' : 'Desktop'
  font.pixelSize: 30
}
```

			utils.defineProperty @::, 'isMobile', null, ->
				@isTablet or @isPhone
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
