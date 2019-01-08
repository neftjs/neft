'use strict'

assert = require '../../../assert'
utils = require '../../../util'

module.exports = (Renderer, Impl, itemUtils) -> class Row extends Renderer.Item
    @__name__ = 'Row'
    @__path__ = 'Renderer.Row'

    @New = (opts) ->
        item = new Row
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
        Impl.setRowEffectItem.call @, val, oldVal

    Renderer.Item.createMargin @,
        propertyName: 'padding'

    itemUtils.defineProperty
        constructor: @
        name: 'spacing'
        defaultValue: 0
        implementation: Impl.setRowSpacing
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
        implementation: Impl.setRowIncludeBorderMargins
        developmentSetter: (val) ->
            assert.isBoolean val
