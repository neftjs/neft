Screen
======

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) -> class Screen extends itemUtils.Object

*Object* Screen
---------------

		constructor: ->
			@_isTouch = false
			@_isDesktop = true
			@_isPhone = false
			@_pixelRatio = 1
			@_width = 1024
			@_height = 800
			@_orientation = 'Portrait'
			super()

*Boolean* Screen.isTouch
------------------------

		utils.defineProperty @::, 'isTouch', null, ->
			@_isTouch
		, null

*Boolean* Screen.isMobile
-------------------------

		utils.defineProperty @::, 'isMobile', null, ->
			@isTouch and (@isTablet or @isPhone)
		, null

*Boolean* Screen.isDesktop
--------------------------

		utils.defineProperty @::, 'isDesktop', null, ->
			not @isTouch
		, null

*Boolean* Screen.isTablet
-------------------------

		utils.defineProperty @::, 'isTablet', null, ->
			not @isDesktop and not @isPhone
		, null

*Boolean* Screen.isPhone
------------------------

		utils.defineProperty @::, 'isPhone', null, ->
			@_isPhone
		, null

*Boolean* Screen.pixelRatio
---------------------------

		utils.defineProperty @::, 'pixelRatio', null, ->
			@_pixelRatio
		, null

*Boolean* Screen.width
----------------------

		utils.defineProperty @::, 'width', null, ->
			@_width
		, null

*Boolean* Screen.height
-----------------------

		utils.defineProperty @::, 'height', null, ->
			@_height
		, null

*String* Screen.orientation = 'Portrait'
----------------------------------------

May contains: Portrait, Landscape, InvertedPortrait, InvertedLandscape

### *Signal* Screen.orientationChanged(*String* oldValue)

		signal.Emitter.createSignal @, 'orientationChanged'
		utils.defineProperty Screen, 'orientation', null, ->
			@_orientation
		, null

		screen = new Screen
		Impl.initScreenNamespace?.call screen
		screen
