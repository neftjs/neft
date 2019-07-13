'use strict'

assert = require '../../assert'
utils = require '../../util'
{SignalsEmitter} = require '../../signal'
log = require '../../log'

log = log.scope 'Renderer'

{isArray} = Array

module.exports = (Renderer, Impl) ->
    NOP = ->

    getObjAsString = (item) ->
        ctorName = item.constructor.__name__
        attrs = []
        if item.id
            attrs.push "id=#{item.id}"
        if item._path
            attrs.push "file=#{item._path}"
        "#{ctorName}(#{attrs.join(', ')})"

    getObjFile = (item) ->
        path = ''
        tmp = item
        while tmp
            if path = tmp.constructor.__file__
                break
            else
                tmp = tmp._parent

        path or ''

    class UtilsObject extends SignalsEmitter
        initObject = (opts) ->
            for prop, val of opts
                path = exports.splitAttribute prop
                prop = path[path.length - 1]
                obj = exports.getObjectByPath @, path
                if typeof val is 'function' and typeof obj[prop] is 'function'
                    obj[prop] exports.bindSignalListener(@, val)
                else if Array.isArray(val) and val.length is 2 and typeof val[0] is 'function' and Array.isArray(val[1])
                    continue
                else if prop of obj
                    obj[prop] = val
                else
                    log.error "Object '#{obj}' has no property '#{prop}'"

            for prop, val of opts
                path = exports.splitAttribute prop
                prop = path[path.length - 1]
                obj = exports.getObjectByPath @, path
                if Array.isArray(val) and val.length is 2 and typeof val[0] is 'function' and Array.isArray(val[1])
                    obj.createBinding prop, val
            return

        setOpts = (opts) ->
            if typeof opts.id is 'string'
                @id = opts.id
            if Array.isArray(opts.children)
                for child in opts.children
                    if child instanceof Renderer.Item
                        child.parent = @
                    else if @ instanceof Renderer.Extension and @_children
                        @_children = opts.children
                    else if child instanceof Renderer.Extension and not child._bindings?.target
                        child.target = @

            classElem = createClass opts
            classElem.target = @
            classElem.running = true
            return



        createClass = (opts) ->
            classElem = Renderer.Class.New()
            classElem._priority = -1
            classElem.changes = opts

            classElem

        @createProperty = (object, name) ->
            assert.isString name, "Property must be a string, but '#{name}' given"
            assert.notLengthOf name, 0, "Property cannot be an empty string"
            assert.notOk name of object, "#{object} already has a property '#{name}'"

            exports.defineProperty
                object: object
                name: name

            return

        @createSignal = (object, name) ->
            assert.isString name
            assert.notLengthOf name, 0
            assert.notOk name of object, "#{object} already has a signal '#{name}'"

            SignalsEmitter.createSignal object, name

            return

        @setOpts = (object, opts) ->
            if opts.id?
                object.id = opts.id

            if object instanceof Renderer.Class or object instanceof FixedObject
                initObject.call object, opts
            else
                setOpts.call object, opts
            object

        @initialize = (object, opts) ->
            Impl.initializeObject object, object.constructor.__name__
            if opts
                UtilsObject.setOpts object, opts
            return

        constructor: ->
            SignalsEmitter.call @

            @id = ''
            if process.env.NODE_ENV isnt 'production'
                @_path = ''
            @_impl = null
            @_bindings = null
            unless @ instanceof Renderer.Class
                @_classList = []
                @_classQueue = []
                @_extensions = []

            Impl.createObject @, @constructor.__name__

        createBinding: (prop, val, ctx = @) ->
            assert.isString prop
            assert.isArray val if val?

            if process.env.NODE_ENV isnt 'production'
                unless prop of @
                    log.warn """
                        Binding on the '#{prop}' property can't be created, \
                        because this object (#{@toString()}) doesn't have such property
                    """
                    return

            if not val and (not @_bindings or not @_bindings.hasOwnProperty(prop))
                return

            bindings = @_bindings ?= {}
            if bindings[prop] isnt val
                bindings[prop] = val
                Impl.setItemBinding.call @, prop, val, ctx
            return

        toString: ->
            getObjAsString @

    class FixedObject extends UtilsObject
        constructor: (opts) ->
            super opts

    class MutableDeepObject extends SignalsEmitter
        constructor: (ref) ->
            assert.instanceOf ref, UtilsObject
            super()
            @_ref = ref
            @_impl = bindings: null
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
            func.call object, arg1, arg2

    defineProperty: (opts) ->
        assert.isPlainObject opts

        {name, namespace, valueConstructor, implementation, implementationValue} = opts

        if process.env.NODE_ENV isnt 'production'
            {developmentSetter} = opts

        prototype = opts.object or opts.constructor::
        customGetter = opts.getter
        customSetter = opts.setter

        # signal
        signalName = getPropHandlerName name

        if opts.hasOwnProperty('constructor')
            SignalsEmitter.createSignal opts.constructor, signalName, opts.signalInitializer
        else
            SignalsEmitter.createSignal prototype, signalName, opts.signalInitializer

        # getter
        internalName = getPropInternalName name

        propGetter = basicGetter = Function "return this.#{internalName}"

        if valueConstructor
            propGetter = ->
                @[internalName] ?= new valueConstructor @

        # setter
        if valueConstructor
            if process.env.NODE_ENV isnt 'production' and developmentSetter
                propSetter = basicSetter = developmentSetter
            else
                propSetter = basicSetter = NOP
        else if namespace?
            namespaceSignalName = "on#{utils.capitalize(namespace)}Change"
            uniquePropName = namespace + utils.capitalize(name)

            func = do ->
                funcStr = "return function(val){\n"
                if process.env.NODE_ENV isnt 'production' and developmentSetter?
                    funcStr += "debug.call(this, val);\n"
                funcStr += "var oldVal = this.#{internalName};\n"
                funcStr += "if (oldVal === val) return;\n"
                if implementation?
                    if implementationValue?
                        funcStr += "impl.call(this._ref, implValue.call(this._ref, val));\n"
                    else
                        funcStr += "impl.call(this._ref, val);\n"
                funcStr += "this.#{internalName} = val;\n"
                funcStr += "this.emit('#{signalName}', oldVal);\n"
                funcStr += "this._ref.emit('#{namespaceSignalName}', '#{name}', oldVal);\n"
                funcStr += "};"

                func = new Function 'impl', 'implValue', 'debug', funcStr
            propSetter = basicSetter = func implementation, implementationValue, developmentSetter
        else
            func = do ->
                funcStr = "return function(val){\n"
                if process.env.NODE_ENV isnt 'production' and developmentSetter?
                    funcStr += "debug.call(this, val);\n"
                funcStr += "var oldVal = this.#{internalName};\n"
                funcStr += "if (oldVal === val) return;\n"
                if implementation?
                    if implementationValue?
                        funcStr += "impl.call(this, implValue.call(this, val));\n"
                    else
                        funcStr += "impl.call(this, val);\n"
                funcStr += "this.#{internalName} = val;\n"
                funcStr += "this.emit('#{signalName}', oldVal);\n"
                funcStr += "};"

                func = new Function 'impl', 'implValue', 'debug', funcStr
            propSetter = basicSetter = func implementation, implementationValue, developmentSetter

        # custom desc
        getter = if customGetter? then customGetter(propGetter) else propGetter
        setter = if customSetter? then customSetter(propSetter) else propSetter

        # override
        prototype[internalName] = opts.defaultValue
        utils.defineProperty prototype, name, null, getter, setter

        prototype

    setPropertyValue: (item, prop, val) ->
        assert.instanceOf item, Renderer.Item
        assert.isString prop

        internalName = getPropInternalName prop
        signalName = getPropHandlerName prop

        oldVal = item[internalName]
        if val isnt oldVal
            item[internalName] = val
            item.emit signalName, oldVal
        return
