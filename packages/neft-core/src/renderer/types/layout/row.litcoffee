# Row

```javascript
Row {
    spacing: 5
    Rectangle { color: 'blue'; width: 50; height: 50; }
    Rectangle { color: 'green'; width: 20; height: 50; }
    Rectangle { color: 'red'; width: 50; height: 20; }
}
```

    'use strict'

    assert = require '../../../assert'
    utils = require '../../../util'

    module.exports = (Renderer, Impl, itemUtils) -> class Row extends Renderer.Item
        @__name__ = 'Row'
        @__path__ = 'Renderer.Row'

## *Row* Row.New([*Object* options])

        @New = (opts) ->
            item = new Row
            itemUtils.Object.initialize item, opts
            item.effectItem = item
            item

## *Row* Row::constructor() : *Item*

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

## *Item.Margin* Row::padding

## *Signal* Row::onPaddingChange(*Item.Margin* padding)

        Renderer.Item.createMargin @,
            propertyName: 'padding'

## *Float* Row::spacing = `0`

## *Signal* Row::onSpacingChange(*Float* oldValue)

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

## *Item.Alignment* Row::alignment

## *Signal* Row::onAlignmentChange(*Item.Alignment* oldValue)

        Renderer.Item.createAlignment @

## *Boolean* Row::includeBorderMargins = `false`

## *Signal* Row::onIncludeBorderMarginsChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'includeBorderMargins'
            defaultValue: false
            implementation: Impl.setRowIncludeBorderMargins
            developmentSetter: (val) ->
                assert.isBoolean val
