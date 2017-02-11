# Rectangle

```javascript
Rectangle {
    width: 150
    height: 100
    color: 'blue'
    border.color: 'black'
    border.width: 5
    radius: 10
}
```

    'use strict'

    assert = require 'src/assert'
    utils = require 'src/utils'

    module.exports = (Renderer, Impl, itemUtils) ->

        class Rectangle extends Renderer.Item
            @__name__ = 'Rectangle'
            @__path__ = 'Renderer.Rectangle'

## *Rectangle* Rectangle.New([*Component* component, *Object* options])

            @New = (component, opts) ->
                item = new Rectangle
                itemUtils.Object.initialize item, component, opts
                item

## *Rectangle* Rectangle::constructor() : *Item*

            constructor: ->
                super()
                @_color = 'transparent'
                @_radius = 0
                @_border = null

## *String* Rectangle::color = `'transparent'`

## *Signal* Rectangle::onColorChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'color'
                defaultValue: 'transparent'
                implementation: Impl.setRectangleColor
                implementationValue: do ->
                    RESOURCE_REQUEST =
                        property: 'color'
                    (val) ->
                        Renderer.resources?.resolve(val, RESOURCE_REQUEST) or val
                developmentSetter: (val) ->
                    assert.isString val, "Rectangle.color needs to be a string, but #{val} given"

## *Float* Rectangle::radius = `0`

## *Signal* Rectangle::onRadiusChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'radius'
                defaultValue: 0
                implementation: Impl.setRectangleRadius
                developmentSetter: (val) ->
                    assert.isFloat val, "Rectangle.radius needs to be a float, but #{val} given"

## *Object* Rectangle::border

## *Signal* Rectangle::onBorderChange(*String* property, *Any* oldValue)

        class Border extends itemUtils.DeepObject
            @__name__ = 'Border'

            itemUtils.defineProperty
                constructor: Rectangle
                name: 'border'
                valueConstructor: Border
                developmentSetter: (val) ->
                    assert.isObject val
                setter: (_super) -> (val) ->
                    {border} = @
                    border.width = val.width if val.width?
                    border.color = val.color if val.color?
                    _super.call @, val
                    return

            constructor: (ref) ->
                @_width = 0
                @_color = 'transparent'
                super ref

## *Float* Rectangle::border.width = `0`

## *Signal* Rectangle::border.onWidthChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'width'
                defaultValue: 0
                namespace: 'border'
                parentConstructor: Rectangle
                implementation: Impl.setRectangleBorderWidth
                developmentSetter: (val) ->
                    assert.isFloat val, """
                        Rectangle.border.width needs to be a float, but #{val} given
                    """

## *String* Rectangle::border.color = `'transparent'`

## *Signal* Rectangle::border.onColorChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'color'
                defaultValue: 'transparent'
                namespace: 'border'
                parentConstructor: Rectangle
                implementation: Impl.setRectangleBorderColor
                implementationValue: do ->
                    RESOURCE_REQUEST =
                        property: 'color'
                    (val) ->
                        Renderer.resources?.resolve(val, RESOURCE_REQUEST) or val
                developmentSetter: (val) ->
                    assert.isString val, """
                        Rectangle.border.color needs to be a string, but #{val} given
                    """

            toJSON: ->
                width: @width
                color: @color

        Rectangle
