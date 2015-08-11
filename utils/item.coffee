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
		initObject = (opts) ->
			for prop, val of opts
				if typeof val is 'function'
					@[prop] val
				else if Array.isArray(val) and val.length is 2 and typeof val[0] is 'function' and Array.isArray(val[1])
					continue
				else
					@[prop] = val

			for prop, val of opts
				if Array.isArray(val) and val.length is 2 and typeof val[0] is 'function' and Array.isArray(val[1])
					@createBinding prop, val
			return

		setOpts = (opts) ->
			if typeof opts.id is 'string'
				@id = opts.id
			if Array.isArray(opts.properties)
				unless @$
					createCustomObject.call @
				for property in opts.properties
					createProperty.call @, property
			if Array.isArray(opts.signals)
				unless @$
					createCustomObject.call @
				for signalName in opts.signals
					createSignal.call @, signalName
			if Array.isArray(opts.children)
				for child in opts.children
					if child instanceof Renderer.Item
						child.parent = @
					else if child instanceof Renderer.Extension
						child.target = @

			classElem = createClass @_component, opts
			classElem.target = @
			return

		createCustomObject = ->
			@$ = Object.create(MutableDeepObject::)
			MutableDeepObject.call @$, @

		CHANGES_OMIT_ATTRIBUTES =
			__proto__: null
			id: true
			properties: true
			signals: true
			children: true

		createClass = (component, opts) ->
			classElem = new Renderer.Class component
			classElem.priority = -1

			{changes} = classElem
			for prop, val of opts
				if typeof val is 'function'
					changes.setFunction prop, val
				else if Array.isArray(val) and val.length is 2 and typeof val[0] is 'function' and Array.isArray(val[1])
					changes.setBinding prop, val
				else if not CHANGES_OMIT_ATTRIBUTES[prop]
					changes.setAttribute prop, val

			classElem

		createProperty = (name) ->
			assert.isString name
			assert.notLengthOf name, 0

			return if @$.hasOwnProperty(name)

			exports.defineProperty
				object: @$
				name: name

			return

		createSignal = (name) ->
			assert.isString name
			assert.notLengthOf name, 0

			signal.Emitter.createSignalOnObject @$, name

			return

		constructor: (component, opts) ->
			@id = ''
			@_impl = null
			@_component = component or null
			@_bindings = null
			@_classExtensions = null
			@_classList = []
			@_classQueue = []
			@_extensions = []
			super()
			Object.preventExtensions @

			Impl.createObject @, @constructor.__name__

			if opts
				if opts.id?
					@id = opts.id

				if @ instanceof Renderer.Class or @ instanceof FixedObject
					initObject.call @, opts
				else
					setOpts.call @, opts

		createBinding: (prop, val, component=@_component, ctx=@) ->
			assert.isString prop
			assert.isArray val if val?
			assert.instanceOf component, Renderer.Component

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
				if component.isClone
					if component.ready
						Impl.setItemBinding.call @, prop, val, component, ctx
					else
						component.objectsInitQueue.push Impl.setItemBinding, @, [prop, val, component, ctx]
			return

		clone: (component, opts) ->
			clone = new @constructor component
			if @id
				clone.id = @id

			if @$
				clone.$ = Object.create @$
				MutableDeepObject.call clone.$, clone

			for extension in @_extensions
				if extension.id
					if component.isDeepClone
						cloneExtension = extension.clone component
						component.saveClonedObject cloneExtension, extension
					else
						cloneExtension = component.objects[extension.id]
				else
					cloneExtension = extension.clone component
				cloneExtension.target = clone

			if opts
				setOpts.call clone, opts

			clone

		# toString: ->
		# 	"#{getObjAsString(@)} in '#{getObjFile(@)}'"
	
	class FixedObject extends UtilsObject
		constrcutor: (component, opts) ->
			super component, opts

	class MutableDeepObject extends signal.Emitter
		constructor: (ref) ->
			assert.instanceOf ref, UtilsObject
			@_ref = ref
			@_impl = bindings: null
			@_component = ref._component
			@_bindings = null
			@_classExtensions = null
			@_classList = []
			@_classQueue = []
			@_extensions = []
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
	FixedObject: FixedObject
	DeepObject: DeepObject
	MutableDeepObject: MutableDeepObject

	getInnerPropName: do ->
		cache =
			__proto__: null
			'': ''
		(val) ->
			cache[val] ?= '_' + val

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
