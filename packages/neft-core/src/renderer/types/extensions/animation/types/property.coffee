'use strict'

utils = require '../../../../../util'
assert = require '../../../../../assert'
log = require '../../../../../log'

log = log.scope 'Renderer', 'PropertyAnimation'

module.exports = (Renderer, Impl, itemUtils) -> class PropertyAnimation extends Renderer.Animation
    @__name__ = 'PropertyAnimation'

    do (i = 0) =>
        @NEVER = 0
        @ON_START = 1 << i++
        @ON_STOP = 1 << i++
        @ON_PENDING = 1 << i++
        @ALWAYS = (1 << i) - 1
        @ON_END = -1 # often mistaken as ON_STOP

    constructor: ->
        super()
        @_property = ''
        @_autoFrom = true
        @_duration = 250
        @_startDelay = 0
        @_loopDelay = 0
        @_updateProperty = PropertyAnimation.ON_START | PropertyAnimation.ON_STOP
        @_easing = null
        @_updatePending = false

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

    itemUtils.defineProperty
        constructor: @
        name: 'property'
        defaultValue: ''
        implementation: Impl.setPropertyAnimationProperty
        developmentSetter: (val) ->
            assert.isString val

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

    itemUtils.defineProperty
        constructor: @
        name: 'startDelay'
        defaultValue: 0
        implementation: Impl.setPropertyAnimationStartDelay
        developmentSetter: (val) ->
            assert.isFloat val

    itemUtils.defineProperty
        constructor: @
        name: 'loopDelay'
        defaultValue: 0
        implementation: Impl.setPropertyAnimationLoopDelay
        developmentSetter: (val) ->
            assert.isFloat val

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

    itemUtils.defineProperty
        constructor: @
        name: 'updateProperty'
        defaultValue: PropertyAnimation.ON_START | PropertyAnimation.ON_STOP
        implementation: Impl.setPropertyAnimationUpdateProperty
        developmentSetter: (val) ->
            msg = """
                PropertyAnimation::updateProperty needs to be a bitmask of \
                PropertyAnimation.ON_START, PropertyAnimation.ON_STOP, \
                PropertyAnimation.ON_PENDING or PropertyAnimation.NEVER, \
                PropertyAnimation.ALWAYS
            """
            assert.isInteger val, msg
            assert.operator val, '>=', PropertyAnimation.NEVER, msg
            assert.operator val, '<=', PropertyAnimation.ALWAYS, msg

    itemUtils.defineProperty
        constructor: @
        name: 'from'
        implementation: Impl.setPropertyAnimationFrom
        setter: (_super) -> (val) ->
            @_autoFrom = false
            _super.call @, val
            return

    itemUtils.defineProperty
        constructor: @
        name: 'to'
        implementation: Impl.setPropertyAnimationTo

    utils.defineProperty @::, 'progress', null, ->
        Impl.getPropertyAnimationProgress.call @
    , null

    utils.defineProperty @::, 'updatePending', null, ->
        @_updatePending
    , null

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
