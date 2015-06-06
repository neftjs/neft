'use strict'

assert = require 'assert'
utils = require 'utils'
log = require 'log'

assert = assert.scope 'View.AttrChange'
log = log.scope 'View', 'AttrChange'

module.exports = (File) -> class AttrChange

	@__name__ = 'AttrChange'
	@__path__ = 'File.AttrChange'

	constructor: (opts) ->
		assert.isPlainObject opts
		assert.instanceOf opts.self, File
		assert.instanceOf opts.node, File.Element
		assert.instanceOf opts.target, File.Element
		assert.isString opts.name
		assert.notLengthOf opts.name, 0

		utils.fill @, opts

		@_defaultValue = @target.attrs.get(@name)

	self: null
	node: null
	target: null
	name: ''

	update: ->
		val = if @node.visible then @node.attrs.get('value') else @_defaultValue
		@target.attrs.set @name, val
		return

	onVisibilityChange = ->
		@update()

	onAttrsChange = (e) ->
		if e.name is 'name'
			throw new Error "Dynamic neft:attr name is not implemented"
		else if e.name is 'value'
			@update()
		return

	clone: (original, self) ->
		clone = Object.create @

		clone.clone = undefined
		clone.self = self
		clone.node = original.node.getCopiedElement @node, self.node
		clone.target = original.node.getCopiedElement @target, self.node

		clone.update()

		clone.node.onVisibilityChange onVisibilityChange, clone
		clone.node.onAttrsChange onAttrsChange, clone

		clone
