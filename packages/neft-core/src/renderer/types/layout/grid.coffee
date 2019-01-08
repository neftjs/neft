'use strict'

assert = require '../../../assert'
utils = require '../../../util'

module.exports = (Renderer, Impl, itemUtils) -> class Grid extends Renderer.Item
    @__name__ = 'Grid'
    @__path__ = 'Renderer.Grid'

    @New = (opts) ->
        item = new Grid
        itemUtils.Object.initialize item, opts
        item.effectItem = item
        item

    constructor: ->
        super()
        @_padding = null
        @_columns = 2
        @_rows = Infinity
        @_spacing = null
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
        Impl.setGridEffectItem.call @, val, oldVal

    Renderer.Item.createMargin @,
        propertyName: 'padding'

    itemUtils.defineProperty
        constructor: @
        name: 'columns'
        defaultValue: 2
        implementation: Impl.setGridColumns
        developmentSetter: (val) ->
            assert.operator val, '>=', 0
        setter: (_super) -> (val) ->
            if val <= 0
                val = 1
            _super.call @, val

    itemUtils.defineProperty
        constructor: @
        name: 'rows'
        defaultValue: Infinity
        implementation: Impl.setGridRows
        developmentSetter: (val) ->
            assert.operator val, '>=', 0
        setter: (_super) -> (val) ->
            if val <= 0
                val = 1
            _super.call @, val

    Renderer.Item.createSpacing @

    Renderer.Item.createAlignment @

    itemUtils.defineProperty
        constructor: @
        name: 'includeBorderMargins'
        defaultValue: false
        implementation: Impl.setGridIncludeBorderMargins
        developmentSetter: (val) ->
            assert.isBoolean val
