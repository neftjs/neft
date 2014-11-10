'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Renderer, Impl, itemUtils) -> class State

	@supportObjectProperty = (propName) ->
		utils.defProp State::, propName, '', ->
			utils.defProp @, propName, 'e', val = {}
			val
		, (val) ->
			utils.defProp @, propName, 'e', val

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