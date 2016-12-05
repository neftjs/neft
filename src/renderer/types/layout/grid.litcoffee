# Grid

```javascript
Grid {
    spacing.column: 15
    spacing.row: 5
    columns: 2
    Rectangle { color: 'blue'; width: 60; height: 50; }
    Rectangle { color: 'green'; width: 20; height: 70; }
    Rectangle { color: 'red'; width: 50; height: 30; }
    Rectangle { color: 'yellow'; width: 20; height: 20; }
}
```

    'use strict'

    assert = require 'src/assert'
    utils = require 'src/utils'

    module.exports = (Renderer, Impl, itemUtils) -> class Grid extends Renderer.Item
        @__name__ = 'Grid'
        @__path__ = 'Renderer.Grid'

## *Grid* Grid.New([*Component* component, *Object* options])

        @New = (component, opts) ->
            item = new Grid
            itemUtils.Object.initialize item, component, opts
            item.effectItem = item
            item

## *Grid* Grid::constructor() : *Item*

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

## *Item.Margin* Grid::padding

## *Signal* Grid::onPaddingChange(*Item.Margin* padding)

        Renderer.Item.createMargin @,
            propertyName: 'padding'

## *Integer* Grid::columns = `2`

## *Signal* Grid::onColumnsChange(*Integer* oldValue)

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

## *Number* Grid::rows = `Infinity`

## *Signal* Grid::onRowsChange(*Number* oldValue)

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

## *Item.Spacing* Grid::spacing

## *Signal* Grid::onSpacingChange(*Item.Spacing* oldValue)

        Renderer.Item.createSpacing @

## *Item.Alignment* Grid::alignment

## *Signal* Grid::onAlignmentChange(*Item.Alignment* oldValue)

        Renderer.Item.createAlignment @

## *Boolean* Grid::includeBorderMargins = `false`

## *Signal* Grid::onIncludeBorderMarginsChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'includeBorderMargins'
            defaultValue: false
            implementation: Impl.setGridIncludeBorderMargins
            developmentSetter: (val) ->
                assert.isBoolean val
