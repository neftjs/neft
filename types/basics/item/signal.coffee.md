Custom signals
==============

	'use strict'

	assert = require 'assert'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils, Item) ->

*Item* Item()
-------------

Item::createSignal(*String* name)
---------------------------------

		Item::createSignal = (name) ->
			assert.isString name
			assert.notLengthOf name, 0

			@$ ?= {}

			signal.create @$, name

			return