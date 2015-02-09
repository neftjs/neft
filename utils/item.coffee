'use strict'

assert = require 'assert'
expect = require 'expect'
utils = require 'utils'
signal = require 'signal'

SignalsEmitter = signal.Emitter

{isArray} = Array

class DeepObject extends signal.Emitter
	constructor: (item, parent) ->
		if parent
			assert.instanceOf parent, @constructor
			data = Object.create parent._data
		else
			data = new @constructor.DATA_CTOR

		@_item = item
		@_data = data

		super()

module.exports = (Renderer, Impl) -> exports =
	DeepObject: DeepObject

	defineProperty: (opts) ->
		assert.isPlainObject opts

		{name, namespace, valueConstructor, implementation} = opts

		`//<development>`
		{developmentGetter, developmentSetter} = opts
		`//</development>`

		prototype = opts.object or opts.constructor::
		customGetter = opts.getter
		customSetter = opts.setter

		# signal
		signalName = "#{name}Changed"
		if opts.hasOwnProperty 'constructor'
			SignalsEmitter.createSignal opts.constructor, signalName
		else
			signal.createLazy prototype, signalName

		# getter
		propGetter = basicGetter = ->
			`//<development>`
			developmentGetter?.call @
			`//</development>`

			@_data[name]

		if valueConstructor
			propGetter = ->
				unless @_data.hasOwnProperty name
					@_data[name] = new valueConstructor @, @_data[name]
				basicGetter.call @

		# setter
		if valueConstructor
			propSetter = basicSetter = (val) ->
				`//<development>`
				developmentSetter?.call @, val
				`//</development>`

				if val?
					if typeof val is 'object'
						utils.merge @[name], val
					else
						for key of @[name]._data
							@[name][key] = val
				return
		else
			propSetter = basicSetter = (val) ->
				`//<development>`
				developmentSetter?.call @, val
				`//</development>`

				oldVal = @_data[name]
				@_data[name] = val
				if oldVal isnt val
					@[signalName]? oldVal

				# TODO: why calling on only changes doesn't work?
				if @_data[name] is val
					if implementation
						implementation.call(@_item or @, val)
					return true
				else
					return false

		if namespace
			Renderer.State.supportObjectProperty namespace
			namespaceSignalName = "#{namespace}Changed"
			propSetter = (val) ->
				basicSetter.call @, val
				@_item[namespaceSignalName] @

		# custom desc
		getter = if customGetter? then customGetter(propGetter) else propGetter
		setter = if customSetter? then customSetter(propSetter) else propSetter

		# accept bindings
		if namespace
			setter = exports.createDeepBindingSetter namespace, name, setter
		else
			setter = exports.createBindingSetter name, setter

		# override
		utils.defineProperty prototype, name, utils.ENUMERABLE, getter, setter

		prototype

	createBindingSetter: (propName, setFunc) ->
		(val) ->
			# synchronize with default state
			if @_data.states and @_data.state is '' and propName isnt 'state' and propName isnt 'parent'
				@_data.states[''][propName] = val

			if val and isArray val.binding
				Impl.setItemBinding.call @, @, propName, val.binding
			else
				setFunc.call @, val

	createDeepBindingSetter: (namespace, propName, setFunc) ->
		(val) ->
			itemData = @_item._data

			# synchronize with default state
			if itemData.states and itemData.state is ''
				state = itemData.states['']
				state[namespace] ?= {}
				state[namespace][propName] ?= val

			if val and isArray val.binding
				Impl.setItemBinding.call @_item, @, propName, val.binding
			else
				setFunc.call @, val

	setProperty: (item, key, val) ->
		if typeof val is 'function' and signal.isHandlerName(key)
			return item[key].connect val

		if val? and typeof val is 'object' and key of item.constructor.prototype and not Array.isArray(val.binding) and not(val instanceof Renderer.Item) 
			return utils.merge item[key], val

		item[key] = val

	fill: (item, opts) ->
		if opts?
			# set properties
			for key, val of opts
				unless key of item
					throw new Error "Unexpected property `#{key}`"

				if typeof val is 'function' and signal.isHandlerName(key)
					continue

				exports.setProperty item, key, val

			# connect handlers
			for key, val of opts
				unless key of item
					throw new Error "Unexpected property `#{key}`"

				if typeof val is 'function' and signal.isHandlerName(key)
					item[key].connect val

	createDataCtor: (data) ->
		func = ->
		func.prototype = data
		func

	initConstructor: (func, opts) ->
		assert.isFunction func
		assert.isPlainObject opts

		{data} = opts

		if opts.extends
			data = utils.merge utils.clone(opts.extends.DATA), data

		func.DATA = data
		func.DATA_CTOR = exports.createDataCtor data

	initObject: (self, impl) ->
		assert.isNotDefined self.__hash__

		self.__hash__ = utils.uid()
		self._data = new self.constructor.DATA_CTOR
		impl? self, self.constructor.__name__

