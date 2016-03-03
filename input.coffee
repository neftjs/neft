'use strict'

utils = require 'neft-utils'
assert = require 'neft-assert'
log = require 'neft-log'
Dict = require 'neft-dict'
List = require 'neft-list'

assert = assert.scope 'View.Input'
log = log.scope 'View', 'Input'

module.exports = (File) -> class Input
	{Element} = File
	{Tag} = Element

	@__name__ = 'Input'
	@__path__ = 'File.Input'

	JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Input) - 1

	i = 1
	JSON_NODE = @JSON_NODE = i++
	JSON_TEXT = @JSON_TEXT = i++
	JSON_FUNC_BODY = @JSON_FUNC_BODY = i++
	JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

	@_fromJSON = (file, arr, obj) ->
		unless obj
			node = file.node.getChildByAccessPath arr[JSON_NODE]
			obj = new Input file, node, arr[JSON_TEXT], arr[JSON_FUNC_BODY]
		obj

	RE = @RE = new RegExp '([^$]*)\\${([^}]*)}([^$]*)', 'gm'
	VAR_RE = @VAR_RE = ///(^|\s|\[|:|\()([a-zA-Z_$][\w:_]*)+(?!:)///g
	PROP_RE = @PROP_RE = ///(\.[a-zA-Z_$][a-zA-Z0-9_$]*)+///
	PROPS_RE = @PROPS_RE = ///[a-zA-Z_$][a-zA-Z0-9_$]*(\.[a-zA-Z_$][a-zA-Z0-9_$]*)+\s*///g
	CONSTANT_VARS = @CONSTANT_VARS = ['undefined', 'false', 'true', 'null', 'this', 'JSON']

	cache = Object.create null
	GLOBAL =
		Math: Math
		Array: Array
		Object: Object
		Number: Number
		RegExp: RegExp
		String: String
		db: require 'neft-db'
		utils: require 'neft-utils'

	@getVal = do ->
		getFromElement = (elem, prop) ->
			if elem instanceof Element
				elem.attrs._data[prop]

		getFromObject = (obj, prop) ->
			if obj
				obj[prop]

		getElement = (obj, prop) ->
			while obj
				if elem = obj.ids?[prop]
					return elem
				obj = obj.parentUse?.file or obj.file or obj.source?.file
			return

		getFunction = (obj, prop) ->
			while obj
				if elem = obj.funcs?[prop]
					return elem
				obj = obj.parentUse?.file or obj.file or obj.source?.file
			return

		(file, prop) ->
			if file.source instanceof File.Iterator
				destFile = file.source.file
			else
				destFile = file
			if v is undefined and source = destFile.source
				v = getFromElement source.node, prop
			if v is undefined and file.source instanceof File.Iterator
				v = getFromElement file.source.node, prop
			if v is undefined
				v = getFromElement destFile.node, prop
			if v is undefined and source
				v = getFromObject source.storage, prop
			if v is undefined
				v = getFromObject file.storage, prop
			if v is undefined
				v = getElement file, prop
			if v is undefined
				v = getFunction file, prop
			if v is undefined
				v = GLOBAL[prop]

			v

	@get = (input, prop) ->
		if prop is 'this'
			input.node
		else
			Input.getVal input.file, prop

	@getStoragesArray = do (arr = []) -> (file) ->
		assert.instanceOf file, File

		arr[0] = file.node
		arr[1] = file.source?.node
		arr[2] = file.source?.storage
		arr[3] = file.storage
		arr[4] = file.source?.file?.node
		arr[5] = file.source?.file?.source?.node

		arr

	@test = (str) ->
		RE.lastIndex = 0
		RE.test str

	@parse = (text) ->
		# build toString()
		text = text.replace(/[\t\n]/gm, '')
		func = ""

		chunks = []
		str = ''
		isString = isBlock = false
		innerBlocks = 0
		i = 0
		n = text.length
		while i < n
			charStr = text[i]
			if charStr is '$' and text[i+1] is '{'
				isBlock = true
				chunks.push str
				str = ''
				i++
			else if charStr is '{'
				innerBlocks++
				str += charStr
			else if charStr is '}'
				if innerBlocks > 0
					innerBlocks--
					str += charStr
				else if isBlock
					chunks.push str
					str = ''
				else
					log.error "Interpolated string parse error: '#{text}'"
					return
			else
				str += charStr
			i++
		chunks.push str

		while chunks.length > 1
			match = [chunks.shift(), chunks.shift()]

			# parse prop
			prop = match[1]

			if prop
				prop = prop.replace PROPS_RE, (str, _, index, allStr) ->
					postfix = allStr.substr index+str.length, 2
					prefix = ''
					str = str.replace PROP_RE, (props) ->
						props = props.split '.'
						props.shift()
						if postfix[0] is '(' or (postfix[0] is '=' and postfix isnt '==')
							prefix += "__input.trace("
							ends = ').' + props[props.length - 1]
							props.pop()
						else
							ends = ''
						r = ''
						for prop in props
							prefix += "__input.traceObj("
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
				func += "(#{prop}) + "

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

	constructor: (@file, @node, @text, @funcBody) ->
		assert.instanceOf @file, File
		assert.instanceOf @node, File.Element
		assert.isString @text
		assert.isString @funcBody

		@traces = []
		@updatePending = false
		@traceChanges = true
		@func = cache[@funcBody] ?= Input.createFunction @funcBody

		`//<development>`
		if @constructor is Input
			Object.preventExtensions @
		`//</development>`

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

	trace: (obj) ->
		if obj and @traceChanges
			if obj instanceof Dict
				obj.onChange onChange, @
				@traces.push obj, 'onChange'
			else if obj instanceof List
				obj.onChange onChange, @
				@traces.push obj, 'onChange'
				obj.onInsert onChange, @
				@traces.push obj, 'onInsert'
				obj.onPop onChange, @
				@traces.push obj, 'onPop'
		obj

	traceObj: (obj, prop) ->
		@trace obj

		if obj
			signal = getNamedSignal prop
			if typeof obj[signal] is 'function'
				obj[signal] onChange, @
				@traces.push obj, signal

			val = obj[prop]
		val

	render: ->
		for storage in Input.getStoragesArray @file
			if storage instanceof Tag
				storage.onAttrsChange onChange, @
			else if storage instanceof Dict
				storage.onChange onChange, @

		@update()

	revert: ->
		for storage in Input.getStoragesArray @file
			if storage instanceof Tag
				storage.onAttrsChange.disconnect onChange, @
			else if storage instanceof Dict
				storage.onChange.disconnect onChange, @

		revertTraces.call @
		return

	update: ->
		@updatePending = false
		return

	toString: do ->
		callFunc = ->
			revertTraces.call @
			@func.call @node, @, Input.get

		->
			try
				callFunc.call @
			catch err
				log.warn "Interpolated string error in '#{@text}';\n#{err.stack || err}"

	clone: (original, file) ->
		node = original.node.getCopiedElement @node, file.node

		new Input file, node, @text, @funcBody

	toJSON: (key, arr) ->
		unless arr
			arr = new Array JSON_ARGS_LENGTH
			arr[0] = JSON_CTOR_ID
		arr[JSON_NODE] = @node.getAccessPath @file.node
		arr[JSON_TEXT] = @text
		arr[JSON_FUNC_BODY] = @funcBody
		arr

	@Text = require('./input/text.coffee') File, @
	@Attr = require('./input/attr.coffee') File, @
