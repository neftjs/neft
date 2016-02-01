'use strict'

assert = require 'assert'
utils = require 'utils'
log = require 'log'

assert = assert.scope 'View.AttrChange'
log = log.scope 'View', 'AttrChange'

module.exports = (File) -> class AttrChange
	@__name__ = 'AttrChange'
	@__path__ = 'File.AttrChange'

	JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(AttrChange) - 1

	i = 1
	JSON_NODE = i++
	JSON_TARGET = i++
	JSON_NAME = i++
	JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

	@_fromJSON = (file, arr, obj) ->
		unless obj
			node = file.node.getChildByAccessPath arr[JSON_NODE]
			target = file.node.getChildByAccessPath arr[JSON_TARGET]
			obj = new AttrChange file, node, target, arr[JSON_NAME]
		obj

	constructor: (@file, @node, @target, @name) ->
		assert.instanceOf file, File
		assert.instanceOf node, File.Element
		assert.instanceOf target, File.Element
		assert.isString name
		assert.notLengthOf name, 0

		@_defaultValue = target.attrs.get name

		@update()
		node.onVisibleChange onVisibleChange, @
		node.onAttrsChange onAttrsChange, @

		`//<development>`
		if @constructor is AttrChange
			Object.preventExtensions @
		`//</development>`

	update: ->
		val = if @node.visible then @node.attrs.get('value') else @_defaultValue
		@target.attrs.set @name, val
		return

	onVisibleChange = ->
		@update()

	onAttrsChange = (name, oldValue) ->
		if name is 'name'
			throw new Error "Dynamic neft:attr name is not implemented"
		else if name is 'value'
			@update()
		return

	clone: (original, file) ->
		node = original.node.getCopiedElement @node, file.node
		target = original.node.getCopiedElement @target, file.node

		new AttrChange file, node, target, @name

	toJSON: (key, arr) ->
		unless arr
			arr = new Array JSON_ARGS_LENGTH
			arr[0] = JSON_CTOR_ID
		arr[JSON_NODE] = @node.getAccessPath @file.node
		arr[JSON_TARGET] = @target.getAccessPath @file.node
		arr[JSON_NAME] = @name
		arr
