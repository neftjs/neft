# Extension

    'use strict'

    utils = require 'src/utils'
    signal = require 'src/signal'

    module.exports = (Renderer, Impl, itemUtils) -> class Extension extends itemUtils.Object
        @__name__ = 'Extension'

        constructor: ->
            super()
            @_target = null
            @_running = false
            @_when = false
            @_whenHandler = null

        signalListener = ->
            unless @_when
                @_when = true
                @onWhenChange.emit false
                unless @_running
                    @enable()
            return

## *Boolean* Extension::when

## *Signal* Extension::onWhenChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'when'
            defaultValue: false
            setter: (_super) -> (val) ->
                if @_whenHandler
                    @_whenHandler.disconnect signalListener, @
                    @_whenHandler = null

                if typeof val is 'function' and val.connect?
                    val.connect signalListener, @
                    @_whenHandler = val
                else
                    _super.call @, !!val

                    if val and not @_running
                        @enable()
                    else if not val and @_running
                        @disable()
                return

## *Item* Extension::target

## *Signal* Extension::onTargetChange(*Item* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'target'
            defaultValue: null

## ReadOnly *Boolean* Extension::running

## *Signal* Extension::onRunningChange(*Boolean* oldValue)

        utils.defineProperty @::, 'running', utils.CONFIGURABLE, ->
            @_running
        , null

        signal.Emitter.createSignal @, 'onRunningChange'

## Extension::enable()

        enable: ->
            @_running = true
            @onRunningChange.emit false

## Extension::disable()

        disable: ->
            @_running = false
            @onRunningChange.emit true
