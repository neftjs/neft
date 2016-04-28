'use strict'

utils = require 'src/utils'
assert = require 'src/assert'
log = require 'src/log'

module.exports = (File) -> class AttrsToSet
	@__name__ = 'AttrsToSet'
	@__path__ = 'File.AttrsToSet'

	JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(AttrsToSet) - 1

	i = 1
	JSON_NODE = i++
	JSON_ATTRS = i++
	JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

	@_fromJSON = (file, arr, obj) ->
		unless obj
			node = file.node.getChildByAccessPath arr[JSON_NODE]
			obj = new AttrsToSet file, node, arr[JSON_ATTRS]
		obj

	constructor: (@file, @node, @attrs) ->
		assert.instanceOf @file, File
		assert.instanceOf @node, File.Element
		assert.isPlainObject @attrs

		# set current attributes
		for attr of @attrs
			if @node.attrs[attr]?
				this.setAttribute attr, null

		# listen on changes
		@node.onAttrsChange @setAttribute, this

		`//<development>`
		if @constructor is AttrsToSet
			Object.preventExtensions @
		`//</development>`

	setAttribute: (attr, oldValue) ->
		unless @attrs[attr]
			return

		val = @node.attrs[attr]
		if typeof @node[attr] is 'function' and @node[attr].connect
			if typeof oldValue is 'function'
				@node[attr].disconnect oldValue
			if typeof val is 'function'
				@node[attr] val
		else
			@node[attr] = val
		return

	clone: (original, file) ->
		node = original.node.getCopiedElement @node, file.node

		new AttrsToSet file, node, @attrs

	toJSON: (key, arr) ->
		unless arr
			arr = new Array JSON_ARGS_LENGTH
			arr[0] = JSON_CTOR_ID
		arr[JSON_NODE] = @node.getAccessPath @file.node
		arr[JSON_ATTRS] = @attrs
		arr
