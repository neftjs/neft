# PropertyAnimation

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    log = require 'src/log'

    log = log.scope 'Renderer', 'PropertyAnimation'

    module.exports = (Renderer, Impl, itemUtils) -> class PropertyAnimation extends Renderer.Animation
        @__name__ = 'PropertyAnimation'

## *PropertyAnimation* PropertyAnimation::constructor() : *Animation*

        constructor: ->
            super()
            @_property = ''
            @_autoFrom = true
            @_duration = 250
            @_startDelay = 0
            @_loopDelay = 0
            @_updateData = false
            @_updateProperty = false
            @_easing = null

        getter = utils.lookupGetter @::, 'running'
        setter = utils.lookupSetter @::, 'running'
        utils.defineProperty @::, 'running', null, getter, do (_super = setter) -> (val) ->
            if val and @_autoFrom and @_target
                @from = @_target[@_property]
                @_autoFrom = true
            _super.call @, val
            return

        itemUtils.defineProperty
            constructor: @
            name: 'target'
            defaultValue: null
            implementation: Impl.setPropertyAnimationTarget
            setter: (_super) -> (val) ->
                oldVal = @_target

                if oldVal
                    utils.remove oldVal._extensions, @

                if val
                    val._extensions.push @

                _super.call @, val
                return

## *String* PropertyAnimation::property

## *Signal* PropertyAnimation::onPropertyChange(*String* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'property'
            defaultValue: ''
            implementation: Impl.setPropertyAnimationProperty
            developmentSetter: (val) ->
                assert.isString val

## *Float* PropertyAnimation::duration = `250`

## *Signal* PropertyAnimation::onDurationChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'duration'
            defaultValue: 250
            implementation: Impl.setPropertyAnimationDuration
            developmentSetter: (val) ->
                assert.isFloat val
            setter: (_super) -> (val) ->
                if val < 0
                    _super.call @, 0
                else
                    _super.call @, val
                return

## *Float* PropertyAnimation::startDelay = `0`

## *Signal* PropertyAnimation::onStartDelayChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'startDelay'
            defaultValue: 0
            implementation: Impl.setPropertyAnimationStartDelay
            developmentSetter: (val) ->
                assert.isFloat val

## *Float* PropertyAnimation::loopDelay = `0`

## *Signal* PropertyAnimation::onLoopDelayChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'loopDelay'
            defaultValue: 0
            implementation: Impl.setPropertyAnimationLoopDelay
            developmentSetter: (val) ->
                assert.isFloat val

## *Float* PropertyAnimation::delay = `0`

## *Signal* PropertyAnimation::onDelayChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'delay'
            defaultValue: 0
            developmentSetter: (val) ->
                assert.isFloat val
            getter: (_super) -> (val) ->
                if @_startDelay is @_loopDelay
                    @_startDelay
                else
                    throw new Error "startDelay and loopDelay are different"
            setter: (_super) -> (val) ->
                @startDelay = val
                @loopDelay = val
                _super.call @, val
                return

## *Boolean* PropertyAnimation::updateData = `false`

## *Signal* PropertyAnimation::onUpdateDataChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'updateData'
            defaultValue: false
            implementation: Impl.setPropertyAnimationUpdateData
            developmentSetter: (val) ->
                assert.isBoolean val
            setter: (_super) -> (val) ->
                unless val
                    @updateProperty = false
                _super.call @, val
                return

## *Boolean* PropertyAnimation::updateProperty = `false`

## *Signal* PropertyAnimation::onUpdatePropertyChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'updateProperty'
            defaultValue: false
            implementation: Impl.setPropertyAnimationUpdateProperty
            developmentSetter: (val) ->
                assert.isBoolean val
            setter: (_super) -> (val) ->
                @updateData = true
                _super.call @, val
                return

## *Any* PropertyAnimation::from

## *Signal* PropertyAnimation::onFromChange(*Any* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'from'
            implementation: Impl.setPropertyAnimationFrom
            setter: (_super) -> (val) ->
                @_autoFrom = false
                _super.call @, val
                return

## *Any* PropertyAnimation::to

## *Signal* PropertyAnimation::onToChange(*Any* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'to'
            implementation: Impl.setPropertyAnimationTo

## ReadOnly *Float* PropertyAnimation::progress = `0`

        utils.defineProperty @::, 'progress', null, ->
            Impl.getPropertyAnimationProgress.call @
        , null

## *Easing* PropertyAnimation::easing

## *Signal* PropertyAnimation::onEasingChange(*Easing* value)

        Easing = require('./property/easing') Renderer, Impl, itemUtils

        utils.defineProperty @::, 'easing', null, ->
            @_easing ||= new Easing(@)
        , (val) ->
            if typeof val is 'string'
                @easing.type = val
            else if utils.isObject(val)
                utils.merge @easing, val
            else if not val
                @easing.type = 'Linear'
