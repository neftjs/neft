# AmbientSound

```javascript
AmbientSound {
    running: true
    source: '/static/sounds/bg.mp3'
    loop: true
}
```

    'use strict'

    assert = require 'src/assert'
    utils = require 'src/utils'
    signal = require 'src/signal'
    List = require 'src/list'

    {isArray} = Array
    SignalsEmitter = signal.Emitter

    assert = assert.scope 'Renderer.AmbientSound'

# **Class** AmbientSound

    module.exports = (Renderer, Impl, itemUtils) -> class AmbientSound extends itemUtils.Object
        @__name__ = 'AmbientSound'
        @__path__ = 'Renderer.AmbientSound'

## *AmbientSound* AmbientSound.New([*Component* component, *Object* options])

        @New = (component, opts) ->
            item = new AmbientSound
            itemUtils.Object.initialize item, component, opts
            item

        constructor: ->
            super()
            @_when = false
            @_running = false
            @_source = ''
            @_loop = false

## *Signal* AmbientSound::onStart()

        signal.Emitter.createSignal @, 'onStart'

## *Signal* AmbientSound::onStop()

        signal.Emitter.createSignal @, 'onStop'

## *Boolean* AmbientSound::running

## *Signal* AmbientSound::onRunningChange(*Boolean* oldValue)

        setRunningOnReady = ->
            @running = @_when

        itemUtils.defineProperty
            constructor: @
            name: 'running'
            setter: (_super) -> (val) ->
                @_when = val
                unless @_isReady
                    @onReady setRunningOnReady
                    return

                oldVal = @_running
                if oldVal is val
                    return

                assert.isBoolean val
                _super.call @, val

                if val
                    Impl.startAmbientSound.call @
                    @onStart.emit()
                else
                    Impl.stopAmbientSound.call @
                    @onStop.emit()
                return

## *String* AmbientSound::source

## *Signal* AmbientSound::onSourceChange(*String* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'source'
            implementation: Impl.setAmbientSoundSource
            developmentSetter: (val) ->
                assert.isString val, '::source setter ...'

## *Boolean* AmbientSound::loop = false

## *Signal* AmbientSound::onLoopChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'loop'
            implementation: Impl.setAmbientSoundLoop
            developmentSetter: (val) ->
                assert.isBoolean val, '::loop setter ...'

## AmbientSound::start()

        start: ->
            @running = true
            @

## AmbientSound::stop()

        stop: ->
            @running = false
            @

# Glossary

- [AmbientSound](#class-ambientsound)
