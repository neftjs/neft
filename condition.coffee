'use strict'

[expect, utils, log] = ['expect', 'utils', 'log'].map require

log = log.scope 'View', 'Condition'

cache = {}
cachelen = 0
MAX_IN_CACHE = 4000

module.exports = (File) -> class Condition

	@__name__ = 'Condition'
	@__path__ = 'File.Condition'

	@FALSE_FUNC = -> false

	@getCondFunc: (exp) ->

		try
			cond = "!!(#{unescape(exp)})"
			new Function "try { return #{cond}; } catch(_){ return false; }"
		catch err
			log.error "Can't build `#{exp}` function: #{err}"
			Condition.FALSE_FUNC

	constructor: (opts) ->

		expect(opts).toBe.simpleObject()
		expect(opts.self).toBe.any File
		expect(opts.node).toBe.any File.Element

		utils.fill @, opts

	self: null
	node: null

	execute: ->

		exp = @node.attrs.get 'x:if'

		unless cache[exp]
			if cachelen++ > MAX_IN_CACHE
				cache = {}
				cachelen = 0

			cache[exp] = Condition.getCondFunc exp

		return cache[exp].call()

	render: ->
		expect(@self.isRendered).toBe.truthy()

		result = @execute()
		return if @node.visible is result

		@node.visible = result

	revert: ->
		expect(@self.isRendered).toBe.falsy()

		@node.visible = true

	clone: (original, self) ->

		clone = Object.create @

		clone.clone = undefined
		clone.self = self
		clone.node = original.node.getCopiedElement @node, self.node
		clone.render = => @render.call clone
		clone.revert = => @revert.call clone

		clone.node.on 'attrChanged', (e) ->
			if self.isRendered
				clone.render() if e.name is 'x:if'

		clone
