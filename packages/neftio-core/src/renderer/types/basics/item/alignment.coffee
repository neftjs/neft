'use strict'

assert = require '../../../../assert'
utils = require '../../../../util'

module.exports = (Renderer, Impl, itemUtils) -> (ctor) -> class Alignment extends itemUtils.DeepObject
    @__name__ = 'Alignment'

    itemUtils.defineProperty
        constructor: ctor
        name: 'alignment'
        defaultValue: null
        valueConstructor: Alignment
        setter: () -> null

    constructor: (ref) ->
        super ref
        @_horizontal = 'left'
        @_vertical = 'top'

        Object.preventExtensions @

    itemUtils.defineProperty
        constructor: @
        name: 'horizontal'
        defaultValue: 'left'
        namespace: 'alignment'
        parentConstructor: ctor
        implementation: Impl["set#{ctor.name}AlignmentHorizontal"]
        developmentSetter: (val) ->
            assert.isString val
        setter: (_super) -> (val='left') ->
            _super.call @, val

    itemUtils.defineProperty
        constructor: @
        name: 'vertical'
        defaultValue: 'top'
        namespace: 'alignment'
        parentConstructor: ctor
        implementation: Impl["set#{ctor.name}AlignmentVertical"]
        developmentSetter: (val) ->
            assert.isString val
        setter: (_super) -> (val='top') ->
            _super.call @, val

    toJSON: ->
        horizontal: @horizontal
        vertical: @vertical
