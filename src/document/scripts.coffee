'use strict'

log = require 'src/log'
utils = require 'src/utils'
assert = require 'src/assert'
Struct = require 'src/struct'
signal = require 'src/signal'

{Emitter} = signal
{emitSignal} = Emitter
assert = assert.scope 'View.Scripts'

class ScriptExported extends Struct
    PROP_OPTS = 0

    constructor: (file, obj) ->
        utils.defineProperty @, 'node', PROP_OPTS, file.node
        utils.defineProperty @, 'refs', PROP_OPTS, file.inputRefs
        utils.defineProperty @, 'context', PROP_OPTS, (-> file.context), null

        obj = utils.merge {}, obj
        for key, val of obj
            if typeof val is 'function'
                obj[key] = val.bind @

        super obj

    utils.defineProperty @::, 'constructor', PROP_OPTS, @

    Emitter.createSignal @, 'onContextChange'

module.exports = (File) -> class Scripts
    @__name__ = 'Scripts'
    @__path__ = 'File.Scripts'

    _initialized = false
    _scripts = {}
    @initialize = (scripts) ->
        _initialized = true
        _scripts = scripts or {}
        Scripts.initialize = ->
            throw new Error "Document.Scripts has been already initialized"

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Scripts) - 1

    i = 1
    JSON_NAMES = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            obj = new Scripts file, arr[JSON_NAMES]
        obj

    constructor: (@file, @names, @object) ->
        assert.instanceOf @file, File
        assert.isArray @names

        @defaults = {}

        @object or= @combineObject()
        @exported = new ScriptExported @file, @object

        `//<development>`
        if @constructor is Scripts
            Object.seal @
        `//</development>`

    combineObject: ->
        return {} unless _initialized

        obj = null
        for name, index in @names
            exported = _scripts[name]?.default
            if utils.isObject(exported)
                if index is 0
                    obj = exported
                else
                    obj = utils.mergeAll {}, obj, exported

                for key, val of exported
                    if utils.isObject(val)
                        log.warn "Document script '#{name}' exports a structure under \
                        the `#{key}` key; it's dangerous because complex structures are \
                        shared; \ initialize this key in the `onRender()` method to fix \
                        this warning"
            else
                log.error "Document script '#{name}' doesn't export anything; \
                did you use 'export default'?"

        obj or= {}

        for prop in @file.props
            unless prop of obj
                obj[prop] = null

        obj

    provideDefaults: ->
        for key, val of @exported
            if typeof val isnt 'function'
                @defaults[key] = val

        return

    clear: (exported) ->
        utils.merge exported, @defaults

    clone: (original, file) ->
        new Scripts file, @names, @object

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NAMES] = @names
        arr
