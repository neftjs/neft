Renderer.State
==============

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

*State* State() @low-level
--------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class State

		@supportObjectProperty = (propName) ->
			utils.defineProperty State::, propName, null, ->
				utils.defineProperty @, propName, utils.ENUMERABLE, val = {}
				val
			, (val) ->
				utils.defineProperty @, propName, utils.ENUMERABLE, val

		constructor: (opts) ->
			if opts?
				utils.merge @, opts

		update: (item) ->
			expect(item).toBe.any Renderer.Item

			# apply changes
			for prop, val of @ when @hasOwnProperty prop
				itemUtils.setProperty item, prop, val
			
			null

		restore: (item) ->
			expect(item).toBe.any Renderer.Item

			# disconnect listeners
			for prop, val of @ when @hasOwnProperty prop
				if typeof val is 'function'
					item[prop].diconnect val

			null