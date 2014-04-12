'use strict'

{assert} = console

cache = {}
cachelen = 0
MAX_IN_CACHE = 4000

module.exports = (File) -> class Condition

	@__name__ = 'Condition'
	@__path__ = 'File.Condition'

	constructor: (@node) ->

		assert node instanceof File.Element

	node: null

	execute: ->

		exp = @node.attrs.get('if')

		unless cache[exp]
			if cachelen++ > MAX_IN_CACHE
				cache = {}
				cachelen = 0

			cond = "!!(#{unescape(exp)})"
			cache[exp] = new Function "try { return #{cond}; } catch(_){ return false; }"

		return cache[exp].call()
