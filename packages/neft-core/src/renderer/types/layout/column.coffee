'use strict'

assert = require '../../../assert'
utils = require '../../../util'

module.exports = (Renderer, Impl, itemUtils) -> class Column extends Renderer.Item
    @__name__ = 'Column'
    @__path__ = 'Renderer.Column'

    @New = (opts) ->
        item = new Column
        itemUtils.Object.initialize item, opts
        item.effectItem = item
        item

    constructor: ->
        super()
        @_padding = null
        @_spacing = 0
        @_alignment = null
        @_includeBorderMargins = false
        @_effectItem = null

    utils.defineProperty @::, 'effectItem', null, ->
        @_effectItem
    , (val) ->
        if val?
            assert.instanceOf val, Renderer.Item
        oldVal = @_effectItem
        @_effectItem = val
        Impl.setColumnEffectItem.call @, val, oldVal

    Renderer.Item.createMargin @,
        propertyName: 'padding'

    itemUtils.defineProperty
        constructor: @
        name: 'spacing'
        defaultValue: 0
        implementation: Impl.setColumnSpacing
        setter: (_super) -> (val) ->
            # state doesn't distinguish column and grid
            if utils.isObject val
                val = 0
            assert.isFloat val
            _super.call @, val

    Renderer.Item.createAlignment @

    itemUtils.defineProperty
        constructor: @
        name: 'includeBorderMargins'
        defaultValue: false
        implementation: Impl.setColumnIncludeBorderMargins
        developmentSetter: (val) ->
            assert.isBoolean val
