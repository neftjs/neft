'use strict'

getAttrNodeValue = (attr) ->

	# save `_value` if not exists
	unless attr.hasOwnProperty '_value'
		char = attr.value[0]
		if char is '{' or char is '['
			try
				value = JSON.parse attr.value
		attr._value = value or attr.value

	attr._value

module.exports = (DOC) ->

	getItem: (i, target) ->

		attr = @_element._node.attributes?.item i

		unless attr then return

		target[0] = attr.name
		target[1] = getAttrNodeValue attr

	get: (name) ->

		{_node} = @_element

		unless _node.attributes then return

		# get attr node
		attr = _node.getAttributeNode name
		unless attr then return undefined

		getAttrNodeValue attr

	set: (name, value) ->

		{_node} = @_element

		unless _node.attributes then return

		if typeof value is 'undefined'
			return _node.removeAttribute name

		# get attr node
		attr = _node.getAttributeNode name
		unless attr
			attr = DOC.createAttribute name
			_node.setAttributeNode attr

		attr.value = if value and typeof value is 'object' then JSON.parse value else value
		attr._value = value