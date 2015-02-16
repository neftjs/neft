Loading assets
==============

Types in this category are used to load external assets.

They don't extends [Renderer.Item][] and no bindings are supported

	'use strict'

	module.exports = (Renderer, Impl, itemUtils) ->
		Font: require('./loader/font') Renderer, Impl, itemUtils