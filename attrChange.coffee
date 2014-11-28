'use strict'

expect = require 'expect'
utils = require 'utils'
log = require 'log'

log = log.scope 'View', 'Condition'

module.exports = (File) -> class AttrChange

	@__name__ = 'AttrChange'
	@__path__ = 'File.AttrChange'

	constructor: (opts) ->
		expect(opts).toBe.simpleObject()
		expect(opts.self).toBe.any File
		expect(opts.node).toBe.any File.Element
		expect(opts.target).toBe.any File.Element
		expect(opts.name).toBe.truthy().string()

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

	clone: (original, self) ->
		clone = Object.create @

		clone.clone = undefined
		clone.self = self
		clone.node = original.node.getCopiedElement @node, self.node
		clone.target = original.node.getCopiedElement @target, self.node

		@update()

		clone.node.on 'visibilityChanged', (e) ->
			clone.update()

		clone
