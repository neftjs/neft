'use strict'

[expect, utils] = ['expect', 'utils'].map require

cache = {}
cachelen = 0
MAX_IN_CACHE = 4000

module.exports = (File) -> class Condition

	@__name__ = 'Condition'
	@__path__ = 'File.Condition'

	@getCondFunc: (exp) ->

		cond = "!!(#{unescape(exp)})"
		new Function "try { return #{cond}; } catch(_){ return false; }"

	constructor: (opts) ->

		expect(opts).toBe.simpleObject()
		expect(opts.self).toBe.any File
		expect(opts.node).toBe.any File.Element
		expect(opts.input).toBe.any File.Input

		utils.fill @, opts

		@inputIndex = @self.inputs.indexOf @input
		expect(@inputIndex).not().toBe -1

	self: null
	node: null
	input: null
	inputIndex: 0

	execute: ->

		exp = @node.attrs.get('if')

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
		@self._tmp.visibleChanges.push @node

	clone: (original, self) ->

		clone = Object.create @

		clone.clone = undefined
		clone.self = self
		clone.node = original.node.getCopiedElement @node, self.node
		clone.render = @render.bind clone
		clone.input = self.inputs[@inputIndex]

		clone.self.onRender.connect clone.render
		clone.input.onChanged.connect clone.render

		clone
