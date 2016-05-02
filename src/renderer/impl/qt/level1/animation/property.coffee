'use strict'

module.exports = (impl) ->
    {Types, items} = impl

    DATA =
        progress: 0
        internalPropertyName: ''
        propertySetter: null
        isIntegerProperty: false
        easing: null
        easingType: 'Linear'

    exports =
    DATA: DATA

    createData: impl.utils.createDataCloner 'Animation', DATA

    create: (data) ->
        impl.Types.Animation.create.call @, data
        exports.setPropertyAnimationEasingType.call @, 'Linear'

    setPropertyAnimationTarget: (val) ->

    setPropertyAnimationProperty: do (_super = impl.setPropertyAnimationProperty) -> (val) ->
        _super.call @, val
        @_impl.dirty = true
        return

    setPropertyAnimationDuration: (val) ->

    setPropertyAnimationStartDelay: (val) ->

    setPropertyAnimationLoopDelay: (val) ->

    setPropertyAnimationFrom: (val) ->

    setPropertyAnimationTo: (val) ->

    setPropertyAnimationUpdateData: (val) ->

    setPropertyAnimationUpdateProperty: (val) ->
        @_impl.dirty = true

    setPropertyAnimationEasingType: do (_super = impl.setPropertyAnimationEasingType) -> (val) ->
        _super.call @, val
        @_impl.easingType = val
        @_impl.elem?.easing = val

    getPropertyAnimationProgress: ->
        @_impl.progress
