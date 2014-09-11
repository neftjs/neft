'use strict'

[expect, utils, log] = ['expect', 'utils', 'log'].map require

log = log.scope 'View', 'Condition'

funcCache = {}
funcCacheLen = 0
MAX_IN_FUNC_CACHE = 4000

expCache = {}
expCacheLen = 0
MAX_IN_EXP_CACHE = 4000

module.exports = (File) -> class Condition

	@__name__ = 'Condition'
	@__path__ = 'File.Condition'

	@FALSE_FUNC = -> false

	@getCondFunc: (exp) ->
		try
			cond = "!!(#{unescape(exp)})"
			new Function "return #{cond};"
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

		# get cached exp result
		if expCache.hasOwnProperty exp
			return expCache[exp]

		# cache func
		unless funcCache.hasOwnProperty exp
			if funcCacheLen++ > MAX_IN_FUNC_CACHE
				funcCache = {}
				funcCacheLen = 0

			funcCache[exp] = Condition.getCondFunc exp

		# get result
		result = utils.tryFunc funcCache[exp], null, null, false

		# save result to the exp cache
		if expCacheLen++ > MAX_IN_EXP_CACHE
			expCache = {}
			expCacheLen = 0
		expCache[exp] = result

		return result

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
