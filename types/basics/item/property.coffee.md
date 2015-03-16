Custom properties
=================

	'use strict'

	assert = require 'assert'

	module.exports = (Renderer, Impl, itemUtils, Item) ->

*Item* Item()
-------------

Item::createProperty(*String* name)
-----------------------------------

		Item::createProperty = (name) ->
			assert.isString name
			assert.notLengthOf name, 0

			itemUtils.defineProperty
				object: @
				name: name

			@_properties ?= []
			@_properties.push name

			return

		Item::clone = do (_super = Item::clone) -> ->
			clone = _super.call @
			if @_properties
				for prop in @_properties
					clone[prop] = @[prop]
			clone