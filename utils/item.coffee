'use strict'

assert = require 'neft-assert'
expect = require 'expect'
utils = require 'utils'
signal = require 'signal'
log = require 'log'

log = log.scope 'Renderer'

SignalsEmitter = signal.Emitter

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

		createBinding: (prop, val) ->
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
				Impl.setItemBinding.call @, prop, val
			return

		signal.Emitter.createSignal @, 'ready'

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
		signalName = "#{name}Changed"

		if opts.hasOwnProperty('constructor')
			SignalsEmitter.createSignal opts.constructor, signalName, opts.signalInitializer
		else
			assert.isNotDefined namespace
			signal.create prototype, signalName

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
			namespaceSignalName = "#{namespace}Changed"
			uniquePropName = namespace + utils.capitalize(name)
			# propSetter = basicSetter = (val) ->
			# 	null;
			# 	`//<development>`
			# 	developmentSetter?.call @, val
			# 	`//</development>`

			# 	ref = @_ref

			# 	oldVal = ref[internalName]
			# 	if oldVal is val
			# 		return

			# 	ref[internalName] = val
			# 	implementation?.call ref, val
			# 	@[signalName] oldVal
			# 	ref[namespaceSignalName] @
			# 	return

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
				funcStr += "this.#{signalName}(oldVal);\n"
				funcStr += "this._ref.#{namespaceSignalName}(this);\n"
				funcStr += "};"

				func = new Function 'impl', 'debug', funcStr
			propSetter = basicSetter = func implementation, developmentSetter
		else
			# propSetter = basicSetter = (val) ->
			# 	null;
			# 	`//<development>`
			# 	developmentSetter?.call @, val
			# 	`//</development>`

			# 	oldVal = @[internalName]
			# 	if oldVal is val
			# 		return

			# 	@[internalName] = val
			# 	implementation?.call @, val
			# 	@[signalName] oldVal
			# 	return
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
				funcStr += "this.#{signalName}(oldVal);\n"
				funcStr += "};"

				func = new Function 'impl', 'debug', funcStr
			propSetter = basicSetter = func implementation, developmentSetter

		# custom desc
		getter = if customGetter? then customGetter(propGetter) else propGetter
		setter = if customSetter? then customSetter(propSetter) else propSetter

		# override
		prototype['_' + name] = opts.defaultValue
		utils.defineProperty prototype, name, null, getter, setter

		prototype
