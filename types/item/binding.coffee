'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = class Binding
	@BINDING_RE = ///([a-zA-Z0-9_]+)\.(x|y|width|height)///g
	@BINDED_PROPS = ['x', 'y', 'width', 'height']
	@SPECIAL_TARGETS =
		parent: true
		this: true

	constructor: (item, @value) ->
		expect(value).toBe.truthy().string()

		@items = []
		@setup = value.replace Binding.BINDING_RE, (_, item, prop) =>
			# save an item
			itemId = @items.indexOf item
			if itemId is -1
				itemId = @items.push(item) - 1

			# replace value chunk
			"i#{itemId}.#{prop}"

		# parse items to uid's
		if item?
			for bingingItem, i in @items
				unless Binding.SPECIAL_TARGETS[bingingItem]
					@items[i] = item.scope.items[bingingItem]._uid

		Object.freeze @

	value: ''
	setup: ''
	items: null
