'use strict'

log = require 'src/log'
utils = require 'src/utils'
assert = require 'src/assert'
signal = require 'src/signal'

{Emitter} = signal
{emitSignal} = Emitter
assert = assert.scope 'View.Scripts'

class FileContext extends Emitter
    propOpts = utils.CONFIGURABLE | utils.WRITABLE

    constructor: ->
        super()
        utils.defineProperty @, '_signals', propOpts, @_signals
        utils.defineProperty @, 'node', propOpts, null
        utils.defineProperty @, 'props', propOpts, null
        utils.defineProperty @, 'refs', propOpts, null
        utils.defineProperty @, 'context', propOpts, null
        utils.defineProperty @, 'state', propOpts, null

    utils.defineProperty @::, 'constructor', propOpts, @

    Emitter.createSignal @, 'onCreate'
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

        @file.scope = @createScope()

    createScope: ->
        ctx = new FileContext
        for name in @names
            func = Scripts.scripts[name]
            func.call ctx
        ctx

    createCloneScope: (file) ->
        {names} = @
        scope = Object.create @file.scope
        propOpts = utils.CONFIGURABLE | utils.WRITABLE

        utils.defineProperty scope, 'node', propOpts, file.node
        utils.defineProperty scope, 'props', propOpts, file.inputProps
        utils.defineProperty scope, 'refs', propOpts, file.inputRefs
        utils.defineProperty scope, 'context', utils.CONFIGURABLE, ->
            file.context
        , null
        utils.defineProperty scope, 'state', propOpts, file.inputState

        emitSignal scope, 'onCreate'

        scope

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NAMES] = @names
        arr
