Pointer events
==============

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils, Item) ->
		class Pointer extends itemUtils.DeepObject
			@__name__ = 'Pointer'

*Pointer* Pointer()
-------------------

			constructor: ->
				super()

*Signal* Pointer::clicked(*Object* event)
-----------------------------------------

*Signal* Pointer::pressed(*Object* event)
-----------------------------------------

*Signal* Pointer::released(*Object* event)
------------------------------------------

*Signal* Pointer::entered(*Object* event)
-----------------------------------------

*Signal* Pointer::exited(*Object* event)
----------------------------------------

*Signal* Pointer::wheel(*Object* event)
---------------------------------------

*Signal* Pointer::move(*Object* event)
--------------------------------------

			onLazySignalInitialized = (pointer, signalName, uniqueName) ->
				Impl.attachItemSignal.call pointer._ref, 'pointer', uniqueName, signalName

			@SIGNALS = ['clicked', 'pressed', 'released',
			            'entered', 'exited', 'wheel', 'move']

			for signalName in @SIGNALS
				uniqueName = "pointer#{utils.capitalize(signalName)}"
				signal.Emitter.createSignal @, signalName, uniqueName, '_ref', onLazySignalInitialized

*Item* Item()
-------------

*Pointer* Item::pointer
-----------------------

		pointer = new Pointer

		utils.defineProperty Item::, 'pointer', null, ->
			pointer._ref = @
			pointer
		, null

		Pointer