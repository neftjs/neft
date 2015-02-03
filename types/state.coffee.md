Renderer.State
==============

	'use strict'

	assert = require 'assert'
	utils = require 'utils'

*State* State()
---------------

	module.exports = (Renderer, Impl, itemUtils) -> class State

		@supportObjectProperty = (propName) ->
			return if State::.hasOwnProperty propName

			utils.defineProperty State::, propName, null, ->
				utils.defineProperty @, propName, utils.ENUMERABLE, val = {}
				val
			, (val) ->
				utils.defineProperty @, propName, utils.ENUMERABLE, val

		@update = (state, item) ->
			assert.instanceOf state, State
			assert.instanceOf item, Renderer.Item

			for prop, val of state
				itemUtils.setProperty item, prop, val

			return

		@restore = (state, item) ->
			assert.instanceOf state, State
			assert.instanceOf item, Renderer.Item

			for prop, val of state
				if typeof val is 'function'
					item[prop].disconnect val

			return

		constructor: (opts) ->
			if opts?
				utils.merge @, opts
