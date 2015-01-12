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

		utils.defineProperty @, '_defaultValue', null, @target.attrs.get(@name)

	self: null
	node: null
	target: null
	name: ''
	value: null

	update: ->
		val = if @node.visible then @value else @_defaultValue
		@target.attrs.set @name, val
		return

	visibilityChangedListener = ->
		@update()

	clone: (original, self) ->
		clone = Object.create @

		clone.clone = undefined
		clone.self = self
		clone.node = original.node.getCopiedElement @node, self.node
		clone.target = original.node.getCopiedElement @target, self.node

		clone.update()

		clone.node.onVisibilityChanged visibilityChangedListener, clone

		clone
