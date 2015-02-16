Loading assets
==============

	'use strict'

	module.exports = (Renderer, Impl, itemUtils) ->
		Font: require('./loader/types/font') Renderer, Impl, itemUtils