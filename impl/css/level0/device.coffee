'use strict'

module.exports = (impl) ->
	initDeviceNamespace: ->
		@_pixelRatio = window.devicePixelRatio or 1
		@_isDesktop = not 'ontouchstart' of window
		@_isPhone = 'ontouchstart' of window and Math.min(@_width, @_height)/Math.max(@_width, @_height) < 0.75

		@_platform = do ->
			{userAgent} = navigator
			switch true
				when /Android/i.test(userAgent)
					'android'
				when /iPhone|iPad|iPod/i.test(userAgent)
					'ios'
				when /BlackBerry/i.test(userAgent)
					'blackberry'
				when /IEMobile|WPDesktop/i.test(userAgent)
					'winphone'
				when /Linux|X11/i.test(userAgent)
					'linux'
				when /Windows/i.test(userAgent)
					'windows'
				when /Mac_PowerPC|Macintosh/i.test(userAgent)
					'osx'
				else
					'unix'