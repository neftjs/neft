# Flow

```javascript
Flow {
    width: 90
    spacing.column: 15
    spacing.row: 5
    Rectangle { color: 'blue'; width: 60; height: 50; }
    Rectangle { color: 'green'; width: 20; height: 70; }
    Rectangle { color: 'red'; width: 50; height: 30; }
    Rectangle { color: 'yellow'; width: 20; height: 20; }
}
```

    'use strict'

    assert = require 'src/assert'
    utils = require 'src/utils'

    module.exports = (Renderer, Impl, itemUtils) -> class Flow extends Renderer.Item
        @__name__ = 'Flow'
        @__path__ = 'Renderer.Flow'

## *Flow* Flow.New([*Component* component, *Object* options])

        @New = (component, opts) ->
            item = new Flow
            itemUtils.Object.initialize item, component, opts
            item.effectItem = item
            item

## *Flow* Flow::constructor() : *Item*

        constructor: ->
            super()
            @_padding = null
            @_spacing = null
            @_alignment = null
            @_includeBorderMargins = false
            @_collapseMargins = false
            @_effectItem = null

        utils.defineProperty @::, 'effectItem', null, ->
            @_effectItem
        , (val) ->
            if val?
                assert.instanceOf val, Renderer.Item
            oldVal = @_effectItem
            @_effectItem = val
            Impl.setFlowEffectItem.call @, val, oldVal

## *Item.Margin* Flow::padding

## *Signal* Flow::onPaddingChange(*Item.Margin* padding)

        Renderer.Item.createMargin @,
            propertyName: 'padding'

## *Item.Spacing* Flow::spacing

## *Signal* Flow::onSpacingChange(*Item.Spacing* oldValue)

        Renderer.Item.createSpacing @

## *Item.Alignment* Flow::alignment

## *Signal* Flow::onAlignmentChange(*Item.Alignment* oldValue)

        Renderer.Item.createAlignment @

## *Boolean* Flow::includeBorderMargins = `false`

## *Signal* Flow::onIncludeBorderMarginsChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'includeBorderMargins'
            defaultValue: false
            implementation: Impl.setFlowIncludeBorderMargins
            developmentSetter: (val) ->
                assert.isBoolean val


## *Boolean* Flow::collapseMargins = `false`

## *Signal* Flow::onCollapseMarginsChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'collapseMargins'
            defaultValue: false
            implementation: Impl.setFlowCollapseMargins
            developmentSetter: (val) ->
                assert.isBoolean val
