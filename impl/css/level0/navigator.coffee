'use strict'

module.exports = (impl) ->
	initNavigatorNamespace: ->
		@_impl = bindings: null
		@_language = navigator.language
		@_isBrowser = true