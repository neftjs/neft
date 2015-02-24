Document Modeling integration
=============================

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils, Item) ->

*Item* Item()
-------------

*Signal* Item::show()
---------------------

This signal is called when the **style item** parent has been found.

		signal.Emitter.createSignal Item, 'show'

*Signal* Item::hide()
---------------------

This signal is called when the **style item** is no longer used.

		signal.Emitter.createSignal Item, 'hide'

		return