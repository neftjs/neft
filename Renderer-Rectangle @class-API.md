> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Rectangle
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

<dl><dt>Static method of</dt><dd><i>Rectangle</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Rectangle</i></dd></dl>
New
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#rectangle-rectanglenewcomponent-component-object-options)

<dl><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Rectangle</i></dd></dl>
Rectangle
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#rectangle-rectangle--rendereritem)

<dl><dt>Prototype property of</dt><dd><i>Rectangle</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'transparent'</code></dd></dl>
color
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#string-rectanglecolor--transparent-signal-rectangleoncolorchangestring-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Rectangle</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
radius
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#float-rectangleradius--0-signal-rectangleonradiuschangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Rectangle</i></dd><dt>Type</dt><dd><i>Border</i></dd></dl>
border
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#border-rectangleborder-signal-rectangleonborderchangestring-property-any-oldvalue)

## Table of contents
    * [Rectangle](#rectangle)
    * [New](#new)
    * [Rectangle](#rectangle)
    * [color](#color)
    * [radius](#radius)
    * [border](#border)
  * [*Float* Rectangle::border.width = 0](#float-rectangleborderwidth--0)
  * [*String* Rectangle::border.color = 'transparent'](#string-rectanglebordercolor--transparent)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Rectangle::border.width = 0
-----------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Rectangle::border.onWidthChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#float-rectangleborderwidth--0-signal-rectangleborderonwidthchangefloat-oldvalue)

*String* Rectangle::border.color = 'transparent'
------------------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Rectangle::border.onColorChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/shapes/rectangle.litcoffee#string-rectanglebordercolor--transparent-signal-rectangleborderoncolorchangestring-oldvalue)

