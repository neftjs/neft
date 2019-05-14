'use strict'

assert = require '../../../../../../assert'
log = require '../../../../../../log'

log = log.scope 'Renderer', 'PropertyAnimation', 'Easing'

module.exports = (Renderer, Impl, itemUtils) -> class Easing extends itemUtils.DeepObject

    constructor: (ref) ->
        @_type = 'Linear'
        @_steps = 1
        super ref

    EASINGS = ['Linear', 'InQuad', 'OutQuad', 'InOutQuad', 'InCubic', 'OutCubic',
        'InOutCubic', 'InQuart', 'OutQuart', 'InOutQuart', 'InQuint', 'OutQuint',
        'InOutQuint', 'InSine', 'OutSine', 'InOutSine', 'InExpo', 'OutExpo',
        'InOutExpo', 'InCirc', 'OutCirc', 'InOutCirc', 'InElastic', 'OutElastic',
        'InOutElastic', 'InBack', 'OutBack', 'InOutBack', 'InBounce', 'OutBounce',
        'InOutBounce', 'Steps']

    EASING_ALIASES = Object.create(null)
    for easing in EASINGS
        EASING_ALIASES[easing] = easing
        EASING_ALIASES[easing.toLowerCase()] = easing

    itemUtils.defineProperty
        constructor: @
        name: 'type'
        defaultValue: 'Linear'
        namespace: 'easing'
        implementation: Impl.setPropertyAnimationEasingType
        developmentSetter: (val) ->
            if val
                assert.isString val
        setter: (_super) -> (val) ->
            unless val
                val = 'Linear'

            type = EASING_ALIASES[val]
            type ||= EASING_ALIASES[val.toLowerCase()]
            unless type
                log.warn "Easing type '#{val}' not recognized"
                type = 'Linear'
            _super.call @, type
            return

    itemUtils.defineProperty
        constructor: @
        name: 'steps'
        defaultValue: 1
        namespace: 'easing'
        implementation: Impl.setPropertyAnimationEasingSteps
        developmentSetter: (val) ->
            if val
                assert.isInteger val
                assert.operator val, '>', 0
