'use strict'

[utils, expect] = ['utils', 'expect'].map require
coffee = require 'coffee-script' if utils.isNode

module.exports = (File) -> class Input

	{Element} = File

	@__name__ = 'Input'
	@__path__ = 'File.Input'

	RE = @RE = new RegExp '([^#]*)#{([^}]*)}([^#]*)', 'gm'
	VAR_RE = @VAR_RE = ///(^|\s|\[|:)([a-z]\w*)+///gi

	@Text = require('./input/text.coffee') File, @
	@Attr = require('./input/attr.coffee') File, @

	@get = (input, prop) ->

		v = input.sourceNode?.attrs.get prop
		v ?= input.sourceStorage?[prop]
		v ?= input.storage?[prop]
		v

	constructor: (@node, text) ->

		expect(node).toBe.any File.Element
		expect(text).toBe.truthy().string()

		# build toString()
		func = ''
		RE.lastIndex = 0
		while (match = RE.exec text) isnt null

			# parse prop
			prop = match[2].replace VAR_RE, (_, prefix, elem) ->
				str = "get(input, '#{escape(elem)}')"
				"#{prefix}#{str}"

			# add into func string
			if match[1] then func += "'#{utils.addSlashes match[1]}' + "
			func += "#{prop} + "
			if match[3] then func += "'#{utils.addSlashes match[3]}' + "

		func = 'return ' + func.slice 0, -3
		@_func = func = coffee.compile func, bare: true

	_func: ''
	node: null
	sourceNode: null
	sourceStorage: null
	storage: null

	parse: ->
		throw "`parse()` method not implemented"

	###
	Override `toString()` method on first call by `@_func` generated in the ctor.
	`utils.simplify()` currently does not support `fromJSON()` and `toJSON()` methods
	on the constructors, so it's the only way to support such functionality.
	###
	toString: do (cache = {}) -> ->
		func = cache[@_func] ?= new Function 'input', 'get', @_func

		toString = @toString = -> try func @, Input.get
		toString.call @

	clone: (original, self) ->

		clone = Object.create @

		clone.clone = undefined
		clone.node = original.node.getCopiedElement @node, self.node

		clone