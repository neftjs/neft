'use strict'

[utils, expect, signal, Dict] = ['utils', 'expect', 'signal', 'dict'].map require
log = require 'log'
coffee = require 'coffee-script' if utils.isNode

log = log.scope 'View', 'Input'

module.exports = (File) -> class Input

	{Element} = File
	{ObservableObject} = File

	@__name__ = 'Input'
	@__path__ = 'File.Input'

	RE = @RE = new RegExp '([^#]*)#{([^}]*)}([^#]*)', 'gm'
	VAR_RE = @VAR_RE = ///(^|\s|\[|:|\()([a-z_][\w:_]*)+(?!:)///gi
	CONSTANT_VARS = @CONSTANT_VARS = ['undefined', 'false', 'true', 'null']

	cache = {}

	@get = (storages, prop) ->
		for storage in storages
			if storage instanceof Element
				v = storage.attrs.get prop
			else if storage instanceof Dict
				v = storage.get prop
			else if storage
				v = storage[prop]

			return v if v?

		null

	@getStoragesArray = do (arr = []) -> (file) ->
		expect(file).toBe.any File

		arr[0] = file.source?.node
		arr[1] = file.source?.storage
		arr[2] = file.storage

		arr

	@fromAssembled = (input) ->
		input._func = cache[input.func] ?= new Function 'file', 'get', input.func

	constructor: (@node, @text) ->
		expect(node).toBe.any File.Element
		expect(text).toBe.truthy().string()

		vars = @vars = []

		# build toString()
		func = ''
		RE.lastIndex = 0
		while (match = RE.exec text) isnt null

			# parse prop
			prop = match[2].replace VAR_RE, (_, prefix, elem) ->
				if prefix.trim() or not utils.has CONSTANT_VARS, elem
					vars.push elem
					str = "get(file, '#{utils.addSlashes elem}')"
				"#{prefix}#{str}"

			# add into func string
			if match[1] then func += "'#{utils.addSlashes match[1]}' + "
			func += "#{prop} + "
			if match[3] then func += "'#{utils.addSlashes match[3]}' + "

		func = 'return ' + func.slice 0, -3
		@func = utils.tryFunc coffee.compile, coffee, [func, bare: true], func

		Input.fromAssembled @

	_func: null

	self: null
	node: null
	vars: null
	text: ''
	func: ''

	_onChanged: (prop) ->
		unless utils.has @vars, prop
			return

		@update()

	render: (self) ->
		for storage in Input.getStoragesArray @self
			if storage instanceof Element
				storage.onAttrChanged.connect @_onChanged
			else if storage instanceof Dict
				storage.onChanged.connect @_onChanged
		
		@update()

	revert: ->
		for storage in Input.getStoragesArray @self
			if storage instanceof Element
				storage.onAttrChanged.disconnect @_onChanged
			else if storage instanceof Dict
				storage.onChanged.disconnect @_onChanged

		null

	update: ->
		throw "`update()` method not implemented"

	toString: ->
		try
			@_func Input.getStoragesArray(@self), Input.get
		catch err
			log.warn "`#{@text}` interpolation is skipped due to an error;\n#{err}"

	clone: (original, self) ->

		clone = Object.create @

		clone.clone = undefined
		clone.self = self
		clone.node = original.node.getCopiedElement @node, self.node
		clone._onChanged = @_onChanged.bind clone

		self.onRender.connect @render.bind clone, self
		self.onRevert.connect @revert.bind clone, self

		clone

	@Text = require('./input/text.coffee') File, @
	@Attr = require('./input/attr.coffee') File, @
