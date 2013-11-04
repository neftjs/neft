'use strict'

module.exports = (DOC) ->

	getItem: (i, target) ->

		attr = @_element._node.attributes.item i

		unless attr then return

		target[0] = attr.name
		target[1] = attr.value

	get: (name) ->

		@_element._node.getAttribute name

	set: (name, value) ->

		_node = @_element._node

		if typeof value is 'undefined'

			return _node.removeAttribute name

		_node.setAttribute name, value