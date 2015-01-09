'use strict'

assert = require 'assert'
utils = require 'utils'
log = require 'log'

assert = assert.scope 'View.Condition'
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
	@HTML_ATTR = "#{File.HTML_NS}:if"

	@getCondFunc: (exp) ->
		try
			cond = "!!(#{unescape(exp)})"
			new Function "return #{cond};"
		catch err
			log.error "Can't build `#{exp}` function: #{err}"
			Condition.FALSE_FUNC

	constructor: (opts) ->
		assert.isPlainObject opts
		assert.instanceOf opts.self, File
		assert.instanceOf opts.node, File.Element

		utils.fill @, opts

	self: null
	node: null

	execute: ->
		exp = @node.attrs.get Condition.HTML_ATTR

		if typeof exp is 'string'
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
			result = utils.tryFunction funcCache[exp], @self, null, (err) =>
				cond = Object.getPrototypeOf(@node).attrs.get Condition.HTML_ATTR
				log.error "Can't execute condition `#{cond}` (`#{exp}` now);\n#{err};\n" +
				          "Rewrite your `neft:if` to always return boolean"
				false

			# save result to the exp cache
			if expCacheLen++ > MAX_IN_EXP_CACHE
				expCache = {}
				expCacheLen = 0
			expCache[exp] = result
		else
			result = !!exp

		return result

	render: ->
		result = @execute()
		return if @node.visible is result

		@node.visible = result

	revert: ->
		assert.notOk @self.isRendered

		@node.visible = true

	clone: (original, self) ->
		clone = Object.create @

		clone.clone = undefined
		clone.self = self
		clone.node = original.node.getCopiedElement @node, self.node
		clone.render = => @render.call clone
		clone.revert = => @revert.call clone

		clone.node.onAttrChanged (e) ->
			if self.isRendered
				clone.render() if e.name is Condition.HTML_ATTR

		clone
