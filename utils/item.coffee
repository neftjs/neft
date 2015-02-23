'use strict'

assert = require 'neft-assert'
expect = require 'expect'
utils = require 'utils'
signal = require 'signal'

SignalsEmitter = signal.Emitter

{isArray} = Array

module.exports = (Renderer, Impl) ->

	class UtilsObject extends signal.Emitter
		constructor: ->
			assert.isNotDefined @__hash__
			@__hash__ = utils.uid()
			@_bindings = null
			super()

		createBinding: (prop, val) ->
			assert.isString prop
			assert.ok prop of @
			assert.isArray val if val?

			bindings = @_bindings ?= {}
			if bindings[prop] isnt val
				bindings[prop] = val
				Impl.setItemBinding.call @, '', prop, prop, val
			return

	class DeepObject extends signal.Emitter
		constructor: ->
			@_ref = null
			Object.preventExtensions @

		utils.defineProperty @::, '_signals', null, ->
			@_ref._signals
		, (val) ->
			assert.isNotDefined @_ref._signals
			@_ref._signals = val

		_namespaceName: ''
		_uniquePropertiesNames: {}

		createBinding: (prop, val) ->
			assert.isString prop
			assert.ok prop of @
			assert.isArray val if val?

			ref = @_ref
			namespaceName = @_namespaceName
			uniqueProp = @_uniquePropertiesNames[prop]

			if not val and not ref.bindings
				return

			bindings = ref.bindings ?= {}
			if bindings[uniqueProp] isnt val
				bindings[uniqueProp] = val
				Impl.setItemBinding.call ref, namespaceName, prop, uniqueProp, val
			return

	DEFINE_PROPERTY_OPTS_KEYS = ['name', 'namespace', 'valueConstructor', 'implementation',
	                             'developmentSetter', 'developmentGetter', 'setter', 'getter',
	                             'object', 'constructor', 'defaultValue', 'parentConstructor']

	propertiesDeepObjects = {}

	exports =
	Object: UtilsObject
	DeepObject: DeepObject

	defineProperty: (opts) ->
		assert.isPlainObject opts
		assert.isEqual utils.merge(Object.keys(opts), DEFINE_PROPERTY_OPTS_KEYS), DEFINE_PROPERTY_OPTS_KEYS

		{name, namespace, valueConstructor, implementation} = opts

		`//<development>`
		{developmentGetter, developmentSetter} = opts
		`//</development>`

		prototype = opts.object or opts.constructor::
		customGetter = opts.getter
		customSetter = opts.setter

		# signal
		signalName = "#{name}Changed"
		if namespace?
			signalInternalName = namespace + utils.capitalize(signalName)
		else
			signalInternalName = signalName

		if opts.hasOwnProperty('constructor')
			if namespace?
				SignalsEmitter.createSignal opts.constructor, signalName, signalInternalName, '_ref'
			else
				SignalsEmitter.createSignal opts.constructor, signalName, signalInternalName, null
		else
			assert.isNotDefined namespace
			signal.create prototype, signalName

		# getter
		if namespace?
			internalName = "_#{namespace}#{utils.capitalize(name)}"
		else
			internalName = "_#{name}"

		# default value
		if 'defaultValue' of opts
			if namespace?
				opts.parentConstructor::[internalName] = opts.defaultValue
			else
				opts.constructor::[internalName] = opts.defaultValue

		if namespace?
			propGetter = basicGetter = ->
				`//<development>`
				developmentGetter?.call @
				`//</development>`

				@_ref[internalName]
		else
			propGetter = basicGetter = ->
				`//<development>`
				developmentGetter?.call @
				`//</development>`

				@[internalName]

		if valueConstructor
			assert.isString valueConstructor.__name__
			valueConstructorInstance = propertiesDeepObjects[valueConstructor.__name__] ?= new valueConstructor
			propGetter = ->
				valueConstructorInstance._ref = @
				valueConstructorInstance

		# setter
		if valueConstructor
			propSetter = basicSetter = (val) ->
				null;
				`//<development>`
				developmentSetter?.call @, val
				`//</development>`
				return
		else if namespace?
			Renderer.State.supportObjectProperty namespace
			namespaceSignalName = "#{namespace}Changed"
			uniquePropName = namespace + utils.capitalize(name)
			opts.constructor::_namespaceName = namespace
			opts.constructor::_uniquePropertiesNames[name] = uniquePropName
			propSetter = basicSetter = (val) ->
				null;
				`//<development>`
				developmentSetter?.call @, val
				`//</development>`

				ref = @_ref

				oldVal = ref[internalName]
				if oldVal is val
					return

				ref[internalName] = val
				implementation?.call ref, val
				@[signalName] oldVal
				ref[namespaceSignalName] @
				return
		else
			propSetter = basicSetter = (val) ->
				null;
				`//<development>`
				developmentSetter?.call @, val
				`//</development>`

				oldVal = @[internalName]
				if oldVal is val
					return

				@[internalName] = val
				implementation?.call @, val
				@[signalName] oldVal
				return

		# custom desc
		getter = if customGetter? then customGetter(propGetter) else propGetter
		setter = if customSetter? then customSetter(propSetter) else propSetter

		# override
		utils.defineProperty prototype, name, null, getter, setter

		prototype
