'use strict'

module.exports = (impl) ->
	initNavigatorNamespace: ->
		@_impl = bindings: null
		@_language = window.navigator.language
		@_browser = true