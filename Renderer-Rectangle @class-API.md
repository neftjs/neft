> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Rectangle @class**

Rectangle @class
================

```nml
`Rectangle {
`   width: 150
`   height: 100
`   color: 'blue'
`   border.color: 'black'
`   border.width: 5
`   radius: 10
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#rectangle-class)

## Table of contents
  * [Rectangle.New([component, options])](#rectangle-rectanglenewcomponent-component-object-options)
  * [Rectangle() : *Renderer.Item*](#rectangle-rectangle--rendereritem)
  * [color = 'transparent'](#string-rectanglecolor--transparent)
  * [radius = 0](#float-rectangleradius--0)
  * [border](#border-rectangleborder)
  * [border.width = 0](#float-rectangleborderwidth--0)
  * [border.color = 'transparent'](#string-rectanglebordercolor--transparent)

*Rectangle* Rectangle.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])
--------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#rectangle-rectanglenewcomponent-component-object-options)

*Rectangle* Rectangle() : *Renderer.Item*
-----------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#rectangle-rectangle--rendereritem)

*String* Rectangle::color = 'transparent'
-----------------------------------------
## *Signal* Rectangle::onColorChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#string-rectanglecolor--transparent-signal-rectangleoncolorchangestring-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Rectangle::radius = 0
-----------------------------
## *Signal* Rectangle::onRadiusChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#float-rectangleradius--0-signal-rectangleonradiuschangefloat-oldvalue)

*Border* Rectangle::border
--------------------------
## *Signal* Rectangle::onBorderChange(*String* property, *Any* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#border-rectangleborder-signal-rectangleonborderchangestring-property-any-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Rectangle::border.width = 0
-----------------------------------
## *Signal* Rectangle::border.onWidthChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#float-rectangleborderwidth--0-signal-rectangleborderonwidthchangefloat-oldvalue)

*String* Rectangle::border.color = 'transparent'
------------------------------------------------
## *Signal* Rectangle::border.onColorChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#string-rectanglebordercolor--transparent-signal-rectangleborderoncolorchangestring-oldvalue)

