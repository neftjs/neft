'use strict'

module.exports = (DOC) ->

	getItem: (i, target) ->

		attribs = @_element._node.attribs

		unless attribs? then return

		for name, value of attribs when not i--

			target[0] = name
			target[1] = value
			return

	get: (name) ->

		@_element._node.attribs?[name]

	set: (name, value) ->

		attribs = @_element._node.attribs

		unless attribs? then return

		if typeof value is 'undefined'

			return delete attribs[name]

		attribs[name] = value