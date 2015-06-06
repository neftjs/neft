'use strict'

assert = require 'neft-assert'
expect = require 'expect'
utils = require 'utils'
signal = require 'signal'
log = require 'log'

log = log.scope 'Renderer'

{emitSignal} = signal.Emitter

{isArray} = Array

module.exports = (Renderer, Impl) ->

	NOP = ->

	getObjAsString = (item) ->
		name = item.constructor.__name__
		name ?= Object.getPrototypeOf(item).constructor.__name__

		"#{name}##{item._id}"

	getObjFile = (item) ->
		path = ''
		tmp = item
		while tmp
			if path = tmp.constructor.__file__
				break
			else
				tmp = tmp._parent

		path or ''

	class UtilsObject extends signal.Emitter
		constructor: ->
			@_id = ''
			@_bindings = null
			@_isReady = false
			super()
			Object.preventExtensions @

		createBinding: (prop, val, ctx=@) ->
			assert.isString prop
			assert.isArray val if val?

			`//<development>`
			unless prop of @
				log.warn "Binding on the '#{prop}' property can't be created, because this object (#{@toString()}) doesn't have such property"
				return
			`//</development>`

			if not val and (not @_bindings or not @_bindings.hasOwnProperty(prop))
				return

			bindings = @_bindings ?= {}
			if bindings[prop] isnt val
				bindings[prop] = val
				Impl.setItemBinding.call @, prop, val, ctx
			return

		signal.Emitter.createSignal @, 'onReady'

		toString: ->
			"#{getObjAsString(@)} in '#{getObjFile(@)}'"

	class MutableDeepObject extends signal.Emitter
		constructor: (ref) ->
			assert.instanceOf ref, Renderer.Item
			@_ref = ref
			@_bindings = null
			@_impl = bindings: null
			super()

		createBinding: UtilsObject::createBinding

		toString: ->
			"#{getObjAsString(@_ref)}.#{@constructor.__name__} in '#{getObjFile(@_ref)}'"

	class DeepObject extends MutableDeepObject
		constructor: (ref) ->
			super ref
			Object.preventExtensions @

	Impl.DeepObject = DeepObject

	funcCache = Object.create null

	exports =
	Object: UtilsObject
	DeepObject: DeepObject
	MutableDeepObject: MutableDeepObject

	defineProperty: (opts) ->
		assert.isPlainObject opts

		{name, namespace, valueConstructor, implementation} = opts

		`//<development>`
		{developmentSetter} = opts
		`//</development>`

		prototype = opts.object or opts.constructor::
		customGetter = opts.getter
		customSetter = opts.setter

		# signal
		signalName = "on#{utils.capitalize(name)}Change"

		if opts.hasOwnProperty('constructor')
			signal.Emitter.createSignal opts.constructor, signalName, opts.signalInitializer
		else
			assert.isNotDefined namespace
			signal.Emitter.createSignalOnObject prototype, signalName, opts.signalInitializer

		# getter
		internalName = "_#{name}"

		propGetter = basicGetter =
		funcCache["get-#{internalName}"] ?= Function "return this.#{internalName}"

		if valueConstructor
			propGetter = ->
				@[internalName] ?= new valueConstructor @

		# setter
		if valueConstructor
			if developmentSetter
				`//<development>`
				propSetter = basicSetter = developmentSetter
				`//</development>`
			else
				propSetter = basicSetter = NOP
		else if namespace?
			namespaceSignalName = "on#{utils.capitalize(namespace)}Change"
			uniquePropName = namespace + utils.capitalize(name)

			func = funcCache["set-deep-#{namespace}-#{internalName}-#{developmentSetter?}-#{implementation?}"] ?= do ->
				funcStr = "return function(val){\n"
				`//<development>`
				if developmentSetter?
					funcStr += "debug.call(this, val);\n"
				`//</development>`
				funcStr += "var oldVal = this.#{internalName};\n"
				funcStr += "if (oldVal === val) return;\n"
				funcStr += "this.#{internalName} = val;\n"
				if implementation?
					funcStr += "impl.call(this._ref, val);\n"
				funcStr += "emitSignal(this, '#{signalName}', oldVal);\n"
				funcStr += "emitSignal(this._ref, '#{namespaceSignalName}', this);\n"
				funcStr += "};"

				func = new Function 'impl', 'emitSignal', 'debug', funcStr
			propSetter = basicSetter = func implementation, emitSignal, developmentSetter
		else
			func = funcCache["set-#{internalName}-#{developmentSetter?}-#{implementation?}"] ?= do ->
				funcStr = "return function(val){\n"
				`//<development>`
				if developmentSetter?
					funcStr += "debug.call(this, val);\n"
				`//</development>`
				funcStr += "var oldVal = this.#{internalName};\n"
				funcStr += "if (oldVal === val) return;\n"
				funcStr += "this.#{internalName} = val;\n"
				if implementation?
					funcStr += "impl.call(this, val);\n"
				funcStr += "emitSignal(this, '#{signalName}', oldVal);\n"
				funcStr += "};"

				func = new Function 'impl', 'emitSignal', 'debug', funcStr
			propSetter = basicSetter = func implementation, emitSignal, developmentSetter

		# custom desc
		getter = if customGetter? then customGetter(propGetter) else propGetter
		setter = if customSetter? then customSetter(propSetter) else propSetter

		# override
		prototype['_' + name] = opts.defaultValue
		utils.defineProperty prototype, name, null, getter, setter

		prototype
