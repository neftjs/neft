'use strict'

utils = require 'src/utils'
assert = require 'src/assert'
log = require 'src/log'
signal = require 'src/signal'
eventLoop = require 'src/eventLoop'
Dict = require 'src/dict'
List = require 'src/list'
Binding = require 'src/binding'

assert = assert.scope 'View.Input'
log = log.scope 'View', 'Input'

class DocumentBinding extends Binding
    @New = (binding, input, target) ->
        target ?= new DocumentBinding binding, input
        Binding.New binding, input.target, target

    constructor: (binding, @input) ->
        super binding, @input.target
        @args = [@input.file.scope]

    getItemById: (item) ->
        if item is 'this'
            @ctx

    `//<development>`
    onError: (err) ->
        log.error "Failed `#{@input.text}` binding in file `#{@input.file.path}`: `#{err}`"
        return
    `//</development>`

    update: ->
        # disable updates for reverted files
        if not @input.isRendered
            return
        eventLoop.lock()
        super()
        eventLoop.release()
        return

    getValue: ->
        @input.getValue()

    setValue: (val) ->
        @input.setValue val

module.exports = (File) -> class Input extends signal.Emitter
    {Element} = File
    {Tag} = Element

    @__name__ = 'Input'
    @__path__ = 'File.Input'

    JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Input) - 1

    i = 1
    JSON_NODE = @JSON_NODE = i++
    JSON_TEXT = @JSON_TEXT = i++
    JSON_BINDING = @JSON_BINDING = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @_fromJSON = (file, arr, obj) ->
        unless obj
            node = file.node.getChildByAccessPath arr[JSON_NODE]
            obj = new Input file, node, arr[JSON_TEXT], arr[JSON_BINDING]
        obj

    RE = @RE = new RegExp '([^$]*)\\${([^}]*)}([^$]*)', 'gm'

    @test = (str) ->
        RE.lastIndex = 0
        RE.test str

    if process.env.NEFT_PLATFORM is 'node'
        @parse = require('./input/parser').parse

    initBindingConfig = (cfg) ->
        cfg.func ?= new Function 'scope', cfg.body
        cfg.tree ?= [cfg.func, cfg.connections]
        return

    constructor: (@file, @node, @text, @bindingConfig) ->
        assert.instanceOf @file, File
        assert.instanceOf @node, File.Element
        assert.isString @text
        assert.isObject @bindingConfig

        super()

        @isRendered = false
        @target = @file.exported
        @binding = null

        initBindingConfig @bindingConfig

        `//<development>`
        if @constructor is Input
            Object.seal @
        `//</development>`

    registerBinding: ->
        assert.isNotDefined @binding
        @binding = DocumentBinding.New @bindingConfig.tree, @
        return

    render: ->
        @isRendered = true
        @binding?.update()
        return

    revert: ->
        @isRendered = false
        return

    clone: (original, file) ->
        node = original.node.getCopiedElement @node, file.node

        new Input file, node, @text, @bindingConfig

    toJSON: (key, arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        arr[JSON_NODE] = @node.getAccessPath @file.node
        arr[JSON_TEXT] = @text
        arr[JSON_BINDING] =
            body: @bindingConfig.body
            connections: @bindingConfig.connections
        arr

    @Text = require('./input/text.coffee') File, @
    @Prop = require('./input/prop.coffee') File, @
