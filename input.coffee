'use strict'

utils = require 'utils'
assert = require 'assert'
log = require 'log'
Dict = require 'dict'

if utils.isNode
	coffee = require 'coffee-script'
	PEG = require 'pegjs'
	grammar = require './input/grammar.pegjs'

	parser = PEG.buildParser grammar,
		optimize: 'speed'

assert = assert.scope 'View.Input'
log = log.scope 'View', 'Input'

module.exports = (File) -> class Input
	{Element} = File

	@__name__ = 'Input'
	@__path__ = 'File.Input'

	RE = @RE = new RegExp '([^#]*)#{([^}]*)}([^#]*)', 'gm'
	VAR_RE = @VAR_RE = ///(^|\s|\[|:|\()([a-zA-Z_$][\w:_]*)+(?!:)///g
	PROP_RE = @PROP_RE = ///(\.[a-zA-Z_$][a-zA-Z0-9_$]*)+///
	PROPS_RE = @PROPS_RE = ///[a-zA-Z_$][a-zA-Z0-9_$]*(\.[a-zA-Z_$][a-zA-Z0-9_$]*)+(.)?///g
	CONSTANT_VARS = @CONSTANT_VARS = ['undefined', 'false', 'true', 'null', 'this', 'JSON']

	cache = {}

	@getVal = do ->
		getFromElement = (elem, prop) ->
			if elem instanceof Element
				elem.attrs.get prop

		getFromObject = (obj, prop) ->
			if obj instanceof Dict
				obj.get prop
			else if obj
				obj[prop]

		(file, prop) ->
			v = getFromElement file.node, prop
			if file.source
				v ?= getFromElement file.source.node, prop
				v ?= getFromObject file.source.storage, prop
			v ?= getFromObject file.storage, prop

			v

	@get = (input, prop) ->
		val = Input.getVal input.self, prop
		input.trace val

		val

	@getStoragesArray = do (arr = []) -> (file) ->
		assert.instanceOf file, File

		arr[0] = file.node
		arr[1] = file.source?.node
		arr[2] = file.source?.storage
		arr[3] = file.storage

		arr

	@fromAssembled = (input) ->
		input._func = cache[input.func] ?= new Function '__input', '__get', input.func

	@test = (str) ->
		RE.lastIndex = 0
		RE.test str

	constructor: (@node, @text) ->
		assert.instanceOf node, File.Element
		assert.isString text
		assert.notLengthOf text, 0

		# build toString()
		func = ""

		try
			chunks = parser.parse text
		catch err
			log.error "Can't parse string literal:\n#{text}\n#{err.message}"
			return

		while chunks.length > 1
			match = [chunks.shift(), chunks.shift()]

			# parse prop
			prop = match[1]

			if prop
				prop = prop.replace PROPS_RE, (str, _, postfix) ->
					prefix = ''
					postfix ?= ''
					str = str.replace PROP_RE, (props) ->
						props = props.split '.'
						props.shift()
						if postfix is '('
							ends = '.' + props[props.length - 1]
							props.pop()
						else
							ends = ''
						r = ''
						for prop in props
							prefix += "__input.trace("
							r += ".#{prop})"
						r + ends
					"#{prefix}#{str}"

				prop = prop.replace VAR_RE, (matched, prefix, elem) ->
					if elem.indexOf('__') is 0
						return matched

					if prefix.trim() or not utils.has CONSTANT_VARS, elem
						str = "__get(__input, '#{utils.addSlashes elem}')"
					else
						str = elem
					"#{prefix}#{str}"

			prop ?= ''

			# add into func string
			if match[0] then func += "'#{utils.addSlashes match[0]}' + "
			if prop
				func += "#{prop} + "

		if chunks.length then func += "'#{utils.addSlashes chunks[0]}' + "

		func = 'return ' + func.slice 0, -3
		@func = utils.tryFunction coffee.compile, coffee, [func, bare: true], func

		try
			Input.fromAssembled @
		catch err
			log.error "Can't parse string literal:\n#{text}\n#{err.message}\n#{func}"

	_func: null

	self: null
	node: null
	text: ''
	func: ''
	traces: null
	updatePending: false

	_onChanged: (prop) ->
		return if @updatePending

		setImmediate @update
		@updatePending = true

	_onAttrChanged: (e) ->
		@_onChanged e.name

	trace: (val) ->
		if val instanceof Dict and not @traces[val.__hash__]
			val.onChanged @_onChanged
			@traces[val.__hash__] = val
		val

	render: ->
		for storage in Input.getStoragesArray @self
			if storage instanceof Element
				storage.onAttrChanged @_onAttrChanged
			else if storage instanceof Dict
				@trace storage
		
		@update()

	revert: ->
		for storage in Input.getStoragesArray @self
			if storage instanceof Element
				storage.onAttrChanged.disconnect @_onAttrChanged

		for hash, dict of @traces
			dict.onChanged.disconnect @_onChanged
			delete @traces[hash]

		return

	update: ->
		@updatePending = false

	toString: do ->

		callFunc = ->
			@_func.call @self, @, Input.get

		->
			try
				callFunc.call @
			catch err
				log.warn "`#{@text}` variable is skipped due to an error;\n#{err}"

	clone: (original, self) ->

		clone = Object.create @

		clone.clone = undefined
		clone.self = self
		clone.node = original.node.getCopiedElement @node, self.node
		clone.traces = {}
		clone.update = => @update.call clone
		clone._onAttrChanged = (arg1) => @_onAttrChanged.call clone, arg1
		clone._onChanged = (arg1) => @_onChanged.call clone, arg1

		clone

	@Text = require('./input/text.coffee') File, @
	@Attr = require('./input/attr.coffee') File, @
