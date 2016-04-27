'use strict'

module.exports = (impl) ->
	initNavigatorNamespace: ->
		@_language = window.navigator.language
		@_browser = true