'use strict'

utils = require 'utils'
log = require 'log'

module.exports = (File) -> class AttrsToSet
	@__name__ = 'AttrsToSet'
	@__path__ = 'File.AttrsToSet'

	attrsKeyGen = (_, value) -> value
	attrsValueGen = -> true

	constructor: (@node, @attrs) ->
		Object.preventExtensions @

	setAttribute: (attr, oldValue) ->
		unless @attrs[attr]
			return

		val = @node._attrs[attr]
		if typeof @node[attr] is 'function' and @node[attr].connect
			if typeof oldValue is 'function'
				@node[attr].disconnect oldValue
			if typeof val is 'function'
				@node[attr] val
		else
			@node[attr] = val
		return

	clone: (original, self) ->
		node = original.node.getCopiedElement @node, self.node

		clone = new AttrsToSet node, @attrs

		# set current attributes
		for attr of @attrs
			clone.setAttribute attr, null

		# listen on changes
		node.onAttrsChange @setAttribute, clone

		clone
