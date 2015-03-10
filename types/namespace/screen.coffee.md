Screen
======

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) ->

*Object* Screen
---------------

		Screen = new itemUtils.Object

*Boolean* Screen.isTouch
------------------------

		Screen._isTouch = false;
		utils.defineProperty Screen, 'isTouch', null, ->
			@_isTouch
		, null

*Boolean* Screen.isMobile
-------------------------

		utils.defineProperty Screen, 'isMobile', null, ->
			@_isTouch and (@_isTablet or @_isPhone)
		, null

*Boolean* Screen.isDesktop
--------------------------

		Screen._isDesktop = true;
		utils.defineProperty Screen, 'isDesktop', null, ->
			not @_isTouch
		, null

*Boolean* Screen.isTablet
-------------------------

		utils.defineProperty Screen, 'isTablet', null, ->
			not @_isDesktop and not @_isPhone
		, null

*Boolean* Screen.isPhone
------------------------

		Screen._isPhone = false;
		utils.defineProperty Screen, 'isPhone', null, ->
			@_isPhone
		, null

*Boolean* Screen.pixelRatio
---------------------------

		Screen._pixelRatio = 1;
		utils.defineProperty Screen, 'pixelRatio', null, ->
			@_pixelRatio
		, null

*Boolean* Screen.width
----------------------

		Screen._width = 1024;
		utils.defineProperty Screen, 'width', null, ->
			@_width
		, null

*Boolean* Screen.height
-----------------------

		Screen._height = 800;
		utils.defineProperty Screen, 'height', null, ->
			@_height
		, null

*String* Screen.orientation = 'Portrait'
----------------------------------------

May contains: Portrait, Landscape, InvertedPortrait, InvertedLandscape

### *Signal* Screen.orientationChanged(*String* oldValue)

		Screen._orientation = 'Portrait';
		signal.create Screen, 'orientationChanged'
		utils.defineProperty Screen, 'orientation', null, ->
			@_orientation
		, null

		Object.preventExtensions Screen
		Impl.initScreenNamespace?.call Screen

		Screen
