'use strict'

utils = require '../util'
assert = require '../assert'
log = require '../log'
signal = require '../signal'
eventLoop = require '../event-loop'
Binding = require '../binding'

assert = assert.scope 'View.Input'
log = log.scope 'View', 'Input'

class DocumentBinding extends Binding
    @New = (binding, input, target) ->
        target ?= new DocumentBinding binding, input
        Binding.New binding, input.target, target

    constructor: (binding, @input) ->
        super binding, @input.target

    getItemById: (item) ->
        if item is 'this'
            @ctx

    `//<development>`
    onError: (err) ->
        log.error "Failed `#{@input.text}` binding in file `#{@input.document.path}`: `#{err}`"
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

module.exports = class Input extends signal.Emitter
    initBindingConfig = (cfg) ->
        cfg.func ?= new Function cfg.body
        cfg.tree ?= [cfg.func, cfg.connections]
        return

    constructor: (@document, element, @interpolation, @text) ->
        super()

        @element = @document.element.getChildByAccessPath(element)
        @isRendered = false
        @target = @document.exported
        @binding = null

        initBindingConfig @interpolation

    registerBinding: ->
        assert.isNotDefined @binding
        @binding = DocumentBinding.New @interpolation.tree, @
        return

    render: ->
        @isRendered = true
        @binding?.update()
        return

    revert: ->
        @isRendered = false
        return
