'use strict'

assert = require 'assert'
utils = require 'utils'
signal = require 'signal'
log = require 'log'

log = log.scope 'Renderer'

{Emitter} = signal
{emitSignal} = Emitter

{isArray} = Array

module.exports = (Renderer, Impl) ->
	NOP = ->

	getObjAsString = (item) ->
		"(#{item.constructor.__name__})#{item._component?.fileName}:#{item.id}"

	getObjFile = (item) ->
		path = ''
		tmp = item
		while tmp
			if path = tmp.constructor.__file__
				break
			else
				tmp = tmp._parent

		path or ''

	class UtilsObject extends Emitter
		initObject = (component, opts) ->
			for prop, val of opts
				path = exports.splitAttribute prop
				prop = path[path.length - 1]
				obj = exports.getObjectByPath @, path
				if typeof val is 'function'
					`//<development>`
					if typeof obj[prop] isnt 'function'
						log.error "Object '#{obj}' has no function '#{prop}'"
						continue
					`//</development>`
					obj[prop] exports.bindSignalListener(@, val)
				else if Array.isArray(val) and val.length is 2 and typeof val[0] is 'function' and Array.isArray(val[1])
					continue
				else
					`//<development>`
					unless prop of obj
						log.error "Object '#{obj}' has no property '#{prop}'"
						continue
					`//</development>`
					obj[prop] = val

			for prop, val of opts
				path = exports.splitAttribute prop
				prop = path[path.length - 1]
				obj = exports.getObjectByPath @, path
				if Array.isArray(val) and val.length is 2 and typeof val[0] is 'function' and Array.isArray(val[1])
					obj.createBinding prop, val, component
			return

		setOpts = (component, opts) ->
			assert.instanceOf component, Renderer.Component

			if typeof opts.id is 'string'
				@id = opts.id
			if Array.isArray(opts.properties)
				for property in opts.properties
					createProperty @, property
			if Array.isArray(opts.signals)
				for signalName in opts.signals
					createSignal @, signalName
			if Array.isArray(opts.children)
				for child in opts.children
					if child instanceof Renderer.Item
						child.parent = @
					else if child instanceof Renderer.Extension and not child._bindings?.target
						child.target = @

			classElem = createClass component, opts
			classElem.target = @
			return

		CHANGES_OMIT_ATTRIBUTES =
			__proto__: null
			id: true
			properties: true
			signals: true
			children: true

		createClass = (component, opts) ->
			classElem = Renderer.Class.New component
			classElem._priority = -1

			{changes} = classElem
			for prop, val of opts
				if typeof val is 'function'
					changes.setFunction prop, val
				else if Array.isArray(val) and val.length is 2 and typeof val[0] is 'function' and Array.isArray(val[1])
					changes.setBinding prop, val
				else if not CHANGES_OMIT_ATTRIBUTES[prop]
					changes.setAttribute prop, val

			classElem

		@createProperty = createProperty = (object, name) ->
			assert.isString name
			assert.notLengthOf name, 0

			if name of object.$
				return

			exports.defineProperty
				object: object.$
				name: name
				namespace: '$'

			return

		createSignal = (object, name) ->
			assert.isString name
			assert.notLengthOf name, 0

			signal.Emitter.createSignalOnObject object.$, name

			return

		@setOpts = (object, component, opts) ->
			if opts.id?
				object.id = opts.id

			if object instanceof Renderer.Class or object instanceof FixedObject
				initObject.call object, component, opts
			else
				setOpts.call object, component, opts
			return

		@initialize = (object, component, opts) ->
			assert.instanceOf component, Renderer.Component
			Object.seal object
			object._component = component
			Impl.initializeObject object, object.constructor.__name__
			if opts
				UtilsObject.setOpts object, component, opts

		constructor: ->
			Emitter.call @

			@id = ''
			@_impl = null
			@_bindings = null
			@_component = null
			unless this instanceof Renderer.Class
				@_classExtensions = null
				@_classList = []
				@_classQueue = []
				@_extensions = []

			Impl.createObject @, @constructor.__name__

		createBinding: (prop, val, component, ctx=@) ->
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
				Impl.setItemBinding.call @, prop, val, component, ctx
			return

		clone: (component, opts) ->
			clone = @constructor.New component
			if @id
				clone.id = @id

			if @_$
				clone._$ = Object.create @_$
				MutableDeepObject.call clone._$, clone

			if opts
				setOpts.call clone, component, opts

			clone

		toString: ->
			getObjAsString @

	class FixedObject extends UtilsObject
		constructor: (component, opts) ->
			super component, opts

	class MutableDeepObject extends signal.Emitter
		constructor: (ref) ->
			assert.instanceOf ref, UtilsObject
			super()
			@_ref = ref
			@_impl = bindings: null
			@_component = ref._component
			@_bindings = null
			@_extensions = []

		createBinding: UtilsObject::createBinding

		toString: ->
			getObjAsString @_ref

	class DeepObject extends MutableDeepObject
		constructor: (ref) ->
			super ref

	class CustomObject extends MutableDeepObject
		constructor: (ref) ->
			super ref

	Impl.DeepObject = DeepObject

	exports =
	Object: UtilsObject
	FixedObject: FixedObject
	DeepObject: DeepObject
	MutableDeepObject: MutableDeepObject
	CustomObject: CustomObject

	getPropHandlerName: getPropHandlerName = do ->
		cache = Object.create null
		(prop) ->
			cache[prop] ||= "on#{utils.capitalize(prop)}Change"

	getPropInternalName: getPropInternalName = do ->
		cache = Object.create null
		(prop) ->
			cache[prop] ||= "_#{prop}"

	getInnerPropName: do ->
		cache = Object.create(null)
		cache[''] = ''
		(val) ->
			cache[val] ?= '_' + val

	splitAttribute: do ->
		cache = Object.create null
		(attr) ->
			cache[attr] ?= attr.split '.'

	getObjectByPath: (item, path) ->
		len = path.length - 1
		i = 0
		while i < len
			unless item = item[path[i]]
				return null
			i++
		item

	bindSignalListener: (object, func) ->
		(arg1, arg2) ->
			if comp = object._component
				arr = comp.objectsOrderSignalArr
				arr[arr.length - 2] = arg1
				arr[arr.length - 1] = arg2
				func.apply object, arr
			else
				func.call object, arg1, arg2

	defineProperty: (opts) ->
		assert.isPlainObject opts

		{name, namespace, valueConstructor, implementation, implementationValue} = opts

		`//<development>`
		{developmentSetter} = opts
		`//</development>`

		prototype = opts.object or opts.constructor::
		customGetter = opts.getter
		customSetter = opts.setter

		# signal
		signalName = getPropHandlerName name

		if opts.hasOwnProperty('constructor')
			signal.Emitter.createSignal opts.constructor, signalName, opts.signalInitializer
		else
			signal.Emitter.createSignalOnObject prototype, signalName, opts.signalInitializer

		# getter
		internalName = getPropInternalName name

		propGetter = basicGetter = Function "return this.#{internalName}"

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

			func = do ->
				funcStr = "return function(val){\n"
				`//<development>`
				if developmentSetter?
					funcStr += "debug.call(this, val);\n"
				`//</development>`
				funcStr += "var oldVal = this.#{internalName};\n"
				funcStr += "if (oldVal === val) return;\n"
				if implementation?
					if implementationValue?
						funcStr += "impl.call(this._ref, implValue.call(this._ref, val));\n"
					else
						funcStr += "impl.call(this._ref, val);\n"
				funcStr += "this.#{internalName} = val;\n"
				funcStr += "emitSignal(this, '#{signalName}', oldVal);\n"
				funcStr += "emitSignal(this._ref, '#{namespaceSignalName}', '#{name}', oldVal);\n"
				funcStr += "};"

				func = new Function 'impl', 'implValue', 'emitSignal', 'debug', funcStr
			propSetter = basicSetter = func implementation, implementationValue, emitSignal, developmentSetter
		else
			func = do ->
				funcStr = "return function(val){\n"
				`//<development>`
				if developmentSetter?
					funcStr += "debug.call(this, val);\n"
				`//</development>`
				funcStr += "var oldVal = this.#{internalName};\n"
				funcStr += "if (oldVal === val) return;\n"
				if implementation?
					if implementationValue?
						funcStr += "impl.call(this, implValue.call(this, val));\n"
					else
						funcStr += "impl.call(this, val);\n"
				funcStr += "this.#{internalName} = val;\n"
				funcStr += "emitSignal(this, '#{signalName}', oldVal);\n"
				funcStr += "};"

				func = new Function 'impl', 'implValue', 'emitSignal', 'debug', funcStr
			propSetter = basicSetter = func implementation, implementationValue, emitSignal, developmentSetter

		# custom desc
		getter = if customGetter? then customGetter(propGetter) else propGetter
		setter = if customSetter? then customSetter(propSetter) else propSetter

		# override
		prototype[internalName] = opts.defaultValue
		utils.defineProperty prototype, name, null, getter, setter

		prototype
