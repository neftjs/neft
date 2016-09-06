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
        utils.defineProperty @, 'root', propOpts, null
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

        @file.context = @createContext()

    createContext: ->
        ctx = new FileContext
        for name in @names
            func = Scripts.scripts[name]
            func.call ctx
        ctx

    createCloneContext: (file) ->
        {names} = @
        ctx = Object.create @file.context
        propOpts = utils.CONFIGURABLE | utils.WRITABLE

        utils.defineProperty ctx, 'node', propOpts, file.node
        utils.defineProperty ctx, 'props', propOpts, file.inputProps
        utils.defineProperty ctx, 'refs', propOpts, file.inputRefs
        utils.defineProperty ctx, 'root', utils.CONFIGURABLE, ->
            file.root
        , null
        utils.defineProperty ctx, 'state', propOpts, null

        emitSignal ctx, 'onCreate'

        ctx

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NAMES] = @names
        arr
