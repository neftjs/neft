'use strict'

[utils, expect, signal] = ['utils', 'expect', 'signal'].map require
coffee = require 'coffee-script' if utils.isNode

module.exports = (File) -> class Input

	{Element} = File
	{ObservableObject} = File

	@__name__ = 'Input'
	@__path__ = 'File.Input'

	RE = @RE = new RegExp '([^#]*)#{([^}]*)}([^#]*)', 'gm'
	VAR_RE = @VAR_RE = ///(^|\s|\[|:|\()([a-z]\w*)+(?!:)///gi

	@get = (file, prop) ->

		v = file.source?.node.attrs.get prop
		v ?= file.source?.storage?[prop]
		if file.storage instanceof ObservableObject
			v ?= file.storage.data[prop]
		else
			v ?= file.storage?[prop]
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
				str = "get(file, '#{escape(elem)}')"
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

	signal.create @::, 'onChanged'

	parse: ->
		throw "`parse()` method not implemented"

	###
	Override `toString()` method on first call by `@_func` generated in the ctor.
	`utils.simplify()` currently does not support `fromJSON()` and `toJSON()` methods
	on the constructors, so it's the only way to support such functionality.
	###
	toString: do (cache = {}) -> (file) ->
		expect(file).toBe.any File

		func = cache[@_func] ?= new Function 'file', 'get', @_func

		toString = @toString = -> try func file, Input.get
		toString.call @

	clone: (original, self) ->

		clone = Object.create @

		clone.clone = undefined
		clone.node = original.node.getCopiedElement @node, self.node

		clone

	@Text = require('./input/text.coffee') File, @
	@Attr = require('./input/attr.coffee') File, @
