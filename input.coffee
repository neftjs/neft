'use strict'

utils = require 'utils'
assert = require 'assert'
log = require 'log'
Dict = require 'dict'
List = require 'dict'

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

	RE = @RE = new RegExp '([^$]*)\\${([^}]*)}([^$]*)', 'gm'
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
				v = obj.get prop
			if v is undefined and obj
				v = obj[prop]
			v

		(file, prop) ->
			if file.source instanceof File.Iterator
				destFile = file.source.self
			else
				destFile = file
			v = getFromElement destFile.node, prop
			if v is undefined and file.source instanceof File.Iterator
				v = getFromElement file.source.node, prop
			if v is undefined and source = destFile.source
				v = getFromElement source.node, prop
				if v is undefined
					v = getFromObject source.storage, prop
			if v is undefined
				v = getFromObject file.storage, prop

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

	@test = (str) ->
		RE.lastIndex = 0
		RE.test str

	@parse = (text) ->
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
							prefix += "__input.traceProp("
							r += ", '#{prop}')"
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
		func = utils.tryFunction coffee.compile, coffee, [func, bare: true], func

		try
			new Function func
		catch err
			log.error "Can't parse string literal:\n#{text}\n#{err.message}\n#{func}"

		func

	@createFunction = (funcBody) ->
		assert.isString funcBody
		assert.notLengthOf funcBody, 0

		new Function '__input', '__get', funcBody

	@fromAssembled = (input) ->
		input.func = cache[input.funcBody] ?= Input.createFunction(input.funcBody)

	constructor: (@node, @func) ->
		assert.instanceOf node, File.Element
		assert.isFunction func

		@self = null
		@funcBody = ''
		@traces = {}
		@text = ''
		@updatePending = false

		Object.preventExtensions @

	queueIndex = 0
	queues = [[], []]
	queue = queues[queueIndex]
	pending = false

	updateItems = ->
		pending = false
		currentQueue = queue
		queue = queues[++queueIndex % queues.length]
		while input = currentQueue.pop()
			input.update()
		return

	if utils.isServer
		onChanged = ->
			@update()
	else
		onChanged = ->
			return if @updatePending

			queue.push @
			@updatePending = true
			unless pending
				setImmediate updateItems
				pending = true
			return

	trace: (val) ->
		if val instanceof Dict and not @traces[val.__hash__]
			val.onChanged onChanged, @
			@traces[val.__hash__] = val
		val

	traceProp: (obj, prop) ->
		if obj instanceof Dict
			val = obj.get prop
		else if obj instanceof List
			val = obj.get prop

		if val is undefined
			val = obj[prop]

		if val
			@trace val
		val

	render: ->
		for storage in Input.getStoragesArray @self
			if storage instanceof Element
				storage.onAttrsChanged onChanged, @
			else if storage instanceof Dict
				@trace storage
		
		@update()

	revert: ->
		for storage in Input.getStoragesArray @self
			if storage instanceof Element
				storage.onAttrsChanged.disconnect onChanged, @

		for hash, dict of @traces when dict?
			dict.onChanged.disconnect onChanged, @
			@traces[hash] = null

		return

	update: ->
		@updatePending = false
		return

	toString: do ->
		callFunc = ->
			@func.call @self, @, Input.get

		->
			try
				callFunc.call @
			catch err
				log.warn "Interpolated string error in '#{@text}';\n#{err}"

	clone: (original, self) ->
		node = original.node.getCopiedElement @node, self.node

		clone = new @constructor node, @func
		clone.self = self
		clone.text = @text

		clone

	@Text = require('./input/text.coffee') File, @
	@Attr = require('./input/attr.coffee') File, @
