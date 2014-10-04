'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = class Binding
	@BINDING_RE = ///([a-zA-Z0-9_]+)\.(x|y|width|height)///g
	@BINDED_PROPS = ['x', 'y', 'width', 'height']

	@cache = {}

	@factory = (value) ->
		if (cached = Binding.cache[value])?
			return cached

		Binding.cache[value] = new Binding value

	constructor: (@value) ->
		expect(value).toBe.truthy().string()

		@items = []
		@setup = value.replace Binding.BINDING_RE, (_, item, prop) =>
			# save an item
			itemId = @items.indexOf item
			if itemId is -1
				itemId = @items.push(item) - 1

			# replace value chunk
			"i#{itemId}.#{prop}"

	value: ''
	setup: ''
	items: null
