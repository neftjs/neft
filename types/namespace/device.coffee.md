Device
======

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) -> class Device extends itemUtils.Object

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

		utils.defineProperty @::, 'platform', null, ->
			@_platform
		, null

*Boolean* Device.isDesktop
--------------------------

		utils.defineProperty @::, 'isDesktop', null, ->
			@_isDesktop
		, null

*Boolean* Device.isTablet
-------------------------

		utils.defineProperty @::, 'isTablet', null, ->
			not @isDesktop and not @isPhone
		, null

*Boolean* Device.isPhone
------------------------

		utils.defineProperty @::, 'isPhone', null, ->
			@_isPhone
		, null

*Boolean* Device.isMobile
-------------------------

Tablet or phone.

		utils.defineProperty @::, 'isMobile', null, ->
			@isTablet or @isPhone
		, null

*Boolean* Device.pixelRatio
---------------------------

		utils.defineProperty @::, 'pixelRatio', null, ->
			@_pixelRatio
		, null

		Device = new Device
		Impl.initDeviceNamespace?.call Device
		Device
