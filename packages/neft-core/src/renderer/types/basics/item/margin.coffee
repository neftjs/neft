'use strict'

utils = require '../../../../util'
{SignalsEmitter} = require '../../../../signal'
assert = require '../../../../assert'

module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor, opts) -> class Margin extends itemUtils.DeepObject
    @__name__ = 'Margin'

    propertyName = opts?.propertyName or 'margin'

    itemUtils.defineProperty
        constructor: ctor
        name: propertyName
        defaultValue: 0
        valueConstructor: Margin
        setter: () -> null

    constructor: (ref) ->
        super ref
        @_left = 0
        @_top = 0
        @_right = 0
        @_bottom = 0

        Object.preventExtensions @

    createMarginProp = (type) ->
        setter = (_super) -> (val) ->
            _super.call @, Number(val) || 0

        itemUtils.defineProperty
            constructor: Margin
            name: type
            defaultValue: 0
            namespace: propertyName
            parentConstructor: ctor
            setter: setter

    createMarginProp 'left'
    createMarginProp 'top'
    createMarginProp 'right'
    createMarginProp 'bottom'

    valueOf: ->
        if @left is @top and @top is @right and @right is @bottom
            @left
        else
            throw new Error "margin values are different"

    toJSON: ->
        left: @left
        top: @top
        right: @right
        bottom: @bottom
