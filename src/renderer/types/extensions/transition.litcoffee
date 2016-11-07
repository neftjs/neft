# Transition

```javascript
Rectangle {
    width: 100; height: 100;
    color: 'red'
    pointer.onClick: function () {
        this.x = Math.random() * 300;
    }
    Transition {
        property: 'x'
        animation: NumberAnimation {
            duration: 1500
        }
    }
}
```

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    signal = require 'src/signal'
    log = require 'src/log'

    log = log.scope 'Renderer', 'Transition'

# **Class** Transition : *Renderer.Extension*

    module.exports = (Renderer, Impl, itemUtils) -> class Transition extends Renderer.Extension
        @__name__ = 'Transition'

## *Transition* Transition.New([*Component* component, *Object* options])

        @New = (component, opts) ->
            item = new Transition
            itemUtils.Object.initialize item, component, opts
            item

        constructor: ->
            super()
            @_animation = null
            @_property = ''
            @_to = 0

        listener = (oldVal) ->
            {animation} = @
            to = @_target[@property]
            if not animation or not @running or animation.updatePending or not utils.isFloat(oldVal) or not utils.isFloat(to)
                return

            @_to = to

            animation.stop()
            animation.from = oldVal
            animation.to = @_to

            animation.target ?= @target
            animation.start()
            return

        onTargetReady = ->
            @_running = true

        itemUtils.defineProperty
            constructor: @
            name: 'target'
            defaultValue: null
            setter: (_super) -> (val) ->
                oldVal = @target
                if oldVal is val
                    return

                {animation, property} = @

                if animation
                    animation.target = val
                    animation.stop()

                _super.call @, val

                if oldVal
                    utils.remove oldVal._extensions, @

                @_running = false
                if val instanceof itemUtils.Object
                    item = val
                else if val instanceof itemUtils.MutableDeepObject
                    item = val._ref
                else
                    setImmediate onTargetReady.bind(@)

                if item
                    item._extensions.push @
                    @_running = true
                    # else
                    #   item.onReady onTargetReady, @

                if property
                    handlerName = itemUtils.getPropHandlerName property
                    if oldVal
                        oldVal[handlerName]?.disconnect listener, @

                    if val
                        if handlerName of val
                            val[handlerName] listener, @
                        else
                            log.error "'#{property}' property signal not found"
                return

## *Animation* Transition::animation

## *Signal* Transition::onAnimationChange(*Animation* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'animation'
            defaultValue: null
            developmentSetter: (val) ->
                assert.instanceOf val, Renderer.Animation if val?
            setter: (_super) -> (val) ->
                oldVal = @animation
                if oldVal is val
                    return

                _super.call @, val

                if oldVal
                    oldVal.target = null
                    oldVal.stop()

                if val
                    val.target = null
                    val.property = @property
                return

## *String* Transition::property

## *Signal* Transition::onPropertyChange(*String* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'property'
            defaultValue: ''
            setter: (_super) -> (val) ->
                oldVal = @property
                if oldVal is val
                    return

                {animation, target} = @

                if target and val.indexOf('.') isnt -1
                    chains = val.split '.'
                    n = chains.length
                    for chain, i in chains when i < n-1
                        target = target[chain]
                        unless target
                            log.error "No object found for the '#{val}' property"
                            break
                    val = chains[n-1]
                    @target = target

                if animation
                    animation.stop()
                    animation.property = val

                _super.call @, val

                if target
                    if oldVal
                        handlerName = "on#{utils.capitalize(oldVal)}Change"
                        target[handlerName].disconnect listener, @

                    if val
                        handlerName = "on#{utils.capitalize(val)}Change"
                        target[handlerName] listener, @
                return

# Glossary

- [Transition](#class-transition)
