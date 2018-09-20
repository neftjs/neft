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

    utils = require '../../../util'
    assert = require '../../../assert'
    signal = require '../../../signal'
    log = require '../../../log'

    log = log.scope 'Renderer', 'Transition'

    module.exports = (Renderer, Impl, itemUtils) -> class Transition extends Renderer.Extension
        @__name__ = 'Transition'

## *Transition* Transition.New([*Object* options])

        @New = (opts) ->
            item = new Transition
            itemUtils.Object.initialize item, opts
            item

## *Transition* Transition::constructor() : *Renderer.Extension*

        constructor: ->
            super()
            @_running = true
            @_ready = false
            @_animation = null
            @_property = ''
            @_animationClass = Renderer.Class.New
                priority: -2
                changes:
                    updateProperty: Renderer.PropertyAnimation.NEVER

        listener = (oldVal) ->
            {animation} = @
            to = @_target[@property]
            shouldRun = animation and @running and @_ready and not animation.updatePending
            shouldRun and= utils.isFloat(oldVal) and utils.isFloat(to)
            unless shouldRun
                return

            animation.stop()
            animation.from = oldVal
            animation.to = to
            animation.start()
            return

        onTargetReady = ->
            @_ready = true

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
                    animation.stop()
                    animation.target = val

                _super.call @, val

                if oldVal
                    utils.remove oldVal._extensions, @

                @_ready = false
                if val instanceof itemUtils.Object
                    item = val
                else if val instanceof itemUtils.MutableDeepObject
                    item = val._ref
                else
                    setImmediate onTargetReady.bind(@)

                if item
                    item._extensions.push @
                    @_ready = true

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

## *PropertyAnimation* Transition::animation

## *Signal* Transition::onAnimationChange(*PropertyAnimation* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'animation'
            defaultValue: null
            developmentSetter: (val) ->
                assert.instanceOf val, Renderer.PropertyAnimation if val?
            setter: (_super) -> (val) ->
                oldVal = @animation
                if oldVal is val
                    return

                _super.call @, val

                if oldVal
                    @_animationClass.disable()
                    oldVal.target = null
                    oldVal.stop()

                if val
                    @_animationClass.target = val
                    @_animationClass.running = true
                    val.target = @target
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
                    for chain, i in chains when i < n - 1
                        target = target[chain]
                        unless target
                            log.error "No object found for the '#{val}' property"
                            break
                    val = chains[n - 1]
                    @target = target

                if animation
                    animation.stop()
                    animation.property = val

                _super.call @, val

                if target
                    if oldVal
                        handlerName = itemUtils.getPropHandlerName oldVal
                        target[handlerName].disconnect listener, @

                    if val
                        handlerName = itemUtils.getPropHandlerName val
                        target[handlerName] listener, @
                return
