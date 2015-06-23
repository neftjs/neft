'use strict'

utils = require 'utils'
assert = require 'assert'
log = require 'log'
Dict = require 'dict'
List = require 'dict'

assert = assert.scope 'View.Input'
log = log.scope 'View', 'Input'

module.exports = (File) -> class Input
	{Element} = File

	@__name__ = 'Input'
	@__path__ = 'File.Input'

	RE = @RE = new RegExp '([^$]*)\\${([^}]*)}([^$]*)', 'gm'
	VAR_RE = @VAR_RE = ///(^|\s|\[|:|\()([a-zA-Z_$][\w:_]*)+(?!:)///g
	PROP_RE = @PROP_RE = ///(\.[a-zA-Z_$][a-zA-Z0-9_$]*)+///
	PROPS_RE = @PROPS_RE = ///[a-zA-Z_$][a-zA-Z0-9_$]*(\.[a-zA-Z_$][a-zA-Z0-9_$]*)+\s*(.{0,2})///g
	CONSTANT_VARS = @CONSTANT_VARS = ['undefined', 'false', 'true', 'null', 'this', 'JSON']

	cache = {}

	@getVal = do ->
		getFromElement = (elem, prop) ->
			if elem instanceof Element
				elem._attrs[prop]

		getFromObject = (obj, prop) ->
			if obj instanceof Dict
				v = obj.get prop
			if v is undefined and obj
				v = obj[prop]
			v

		getElement = (obj, prop) ->
			while obj
				if elem = obj.ids?[prop]
					return elem
				obj = obj.parentUse?.self or obj.self
			return

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
			if v is undefined
				v = getElement file, prop

			v

	@get = (input, prop) ->
		Input.getVal input.self, prop

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

		chunks = []
		str = ''
		isString = isBlock = false
		innerBlocks = 0
		i = 0
		n = text.length
		while i < n
			char = text[i]
			if char is '$' and text[i+1] is '{'
				isBlock = true
				chunks.push str
				str = ''
				i++
			else if char is '{'
				innerBlocks++
				str += char
			else if char is '}'
				if innerBlocks > 0
					innerBlocks--
					str += char
				else if isBlock
					chunks.push str
					str = ''
				else
					log.error "Interpolated string parse error: '#{text}'"
					return
			else
				str += char
			i++
		chunks.push str

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
						if postfix[0] is '(' or (postfix[0] is '=' and postfix isnt '==')
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
			if match[0]
				func += "'#{utils.addSlashes match[0]}' + "
			if prop
				func += "#{prop} + "

		if chunks.length and chunks[0]
			func += "'#{utils.addSlashes chunks[0]}' + "

		func = 'return ' + func.slice 0, -3

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
		@traces = []
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
		onChange = ->
			@update()
	else
		onChange = ->
			return if @updatePending

			queue.push @
			@updatePending = true
			unless pending
				setImmediate updateItems
				pending = true
			return

	revertTraces = ->
		{traces} = @
		for obj, i in traces by 2
			signal = traces[i + 1]
			obj[signal].disconnect onChange, @
		utils.clear traces
		return

	getNamedSignal = do ->
		cache = Object.create null
		(name) ->
			cache[name] ||= "on#{utils.capitalize(name)}Change"

	trace: (val, prop) ->
		if val instanceof Dict
			val.onChange onChange, @
			@traces.push val, 'onChange'
		else if val instanceof List
			val.onChange onChange, @
			@traces.push val, 'onChange'
			val.onInsert onChange, @
			@traces.push val, 'onInsert'
			val.onPop onChange, @
			@traces.push val, 'onPop'
		val

	traceProp: (obj, prop) ->
		if obj
			if obj instanceof Dict
				val = obj.get prop
			else if obj instanceof List
				val = obj.get prop

			if val is undefined
				val = obj[prop]

			if val
				@trace val, prop

				signal = getNamedSignal prop
				if typeof obj[signal] is 'function'
					obj[signal] onChange, @
					@traces.push obj, signal
		val

	render: ->
		for storage in Input.getStoragesArray @self
			if storage instanceof Element
				storage.onAttrsChange onChange, @
			else if storage instanceof Dict
				@trace storage, ''
		
		@update()

	revert: ->
		for storage in Input.getStoragesArray @self
			if storage instanceof Element
				storage.onAttrsChange.disconnect onChange, @

		revertTraces.call @
		# for hash, dict of @tracedObjects when dict?
		# 	dict.onChange.disconnect onChange, @
		# 	@tracedObjects[hash] = null
		return

	update: ->
		@updatePending = false
		return

	toString: do ->
		callFunc = ->
			revertTraces.call @
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
