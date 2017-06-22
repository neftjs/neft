'use strict'

log = require 'src/log'
utils = require 'src/utils'
assert = require 'src/assert'
signal = require 'src/signal'

{Emitter} = signal
{emitSignal} = Emitter
assert = assert.scope 'View.Scripts'

class FileContext extends Emitter
    PROP_OPTS = 0

    constructor: (file) ->
        super()
        utils.defineProperty @, '_signals', PROP_OPTS, @_signals
        utils.defineProperty @, 'node', PROP_OPTS, file.node
        utils.defineProperty @, 'props', PROP_OPTS, file.inputProps
        utils.defineProperty @, 'refs', PROP_OPTS, file.inputRefs
        utils.defineProperty @, 'context', PROP_OPTS, ->
            file.context
        , null
        utils.defineProperty @, 'state', PROP_OPTS, file.inputState

    utils.defineProperty @::, 'constructor', PROP_OPTS, @

    Emitter.createSignal @, 'onBeforeRender'
    Emitter.createSignal @, 'onRender'
    Emitter.createSignal @, 'onBeforeRevert'
    Emitter.createSignal @, 'onRevert'

module.exports = (File) -> class Scripts
    @__name__ = 'Scripts'
    @__path__ = 'File.Scripts'

    @scripts = {}

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Scripts) - 1

    i = 1
    JSON_NAMES = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            obj = new Scripts file, arr[JSON_NAMES]
        obj

    constructor: (@file, @names) ->
        assert.instanceOf @file, File
        assert.isArray @names

        `//<development>`
        if @constructor is Scripts
            Object.seal @
        `//</development>`

    createScope: (file) ->
        ctx = new FileContext file
        for name in @names
            Scripts.scripts[name].call ctx
        ctx

    createCloneScope: (file) ->
        @createScope file

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NAMES] = @names
        arr
