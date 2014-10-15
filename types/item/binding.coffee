'use strict'

log = require 'log'
utils = require 'utils'
expect = require 'expect'

log = log.scope 'Renderer', 'Binding'

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
			for bindingItem, i in @items
				unless Binding.SPECIAL_TARGETS[bindingItem]
					item = item.scope.getItemById bindingItem
					unless item
						log.warn "Unexpected item (`#{bindingItem}`) in binding;\n" +
						         "Can't find such id in this scope"
					else
						@items[i] = item._uid

		Object.freeze @

	value: ''
	setup: ''
	items: null
