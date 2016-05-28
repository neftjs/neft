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
        utils.defineProperty @, 'attrs', propOpts, null
        utils.defineProperty @, 'ids', propOpts, null
        utils.defineProperty @, 'scope', propOpts, null
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

    @scriptFiles = {}

    getScriptFile = @getScriptFile = (path) ->
        Scripts.scriptFiles[path] or require(path)

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Scripts) - 1

    i = 1
    JSON_PATHS = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            obj = new Scripts file, arr[JSON_PATHS]
        obj

    constructor: (@file, @paths) ->
        assert.instanceOf @file, File
        assert.isArray @paths

        `//<development>`
        if @constructor is Scripts
            Object.seal @
        `//</development>`

        @file.context = @createContext()

    createContext: ->
        ctx = new FileContext
        for path in @paths
            func = getScriptFile path
            func.call ctx
        ctx

    createCloneContext: (file) ->
        {paths} = @
        ctx = Object.create @file.context
        propOpts = utils.CONFIGURABLE | utils.WRITABLE

        utils.defineProperty ctx, 'node', propOpts, file.node
        utils.defineProperty ctx, 'attrs', propOpts, file.inputAttrs
        utils.defineProperty ctx, 'ids', propOpts, file.inputIds
        utils.defineProperty ctx, 'scope', utils.CONFIGURABLE, ->
            file.scope
        , null
        utils.defineProperty ctx, 'state', propOpts, null

        emitSignal ctx, 'onCreate'

        ctx

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_PATHS] = @paths
        arr
