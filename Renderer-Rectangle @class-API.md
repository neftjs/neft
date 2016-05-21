> [Wiki](Home) ▸ [API Reference](API-Reference)

Rectangle
<dl><dt>Syntax</dt><dd><code>Rectangle @class</code></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/shapes/rectangle.litcoffee#rectangle-class)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;Rectangle&#x2A; Rectangle.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>Rectangle</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Rectangle</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/shapes/rectangle.litcoffee#rectangle-rectanglenewcomponent-component-object-options)

Rectangle
<dl><dt>Syntax</dt><dd><code>&#x2A;Rectangle&#x2A; Rectangle() : &#x2A;Renderer.Item&#x2A;</code></dd><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Rectangle</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/shapes/rectangle.litcoffee#rectangle-rectangle--rendereritem)

color
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Rectangle::color = 'transparent'</code></dd><dt>Prototype property of</dt><dd><i>Rectangle</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'transparent'</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/shapes/rectangle.litcoffee#string-rectanglecolor--transparent-signal-rectangleoncolorchangestring-oldvalue)

radius
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Rectangle::radius = 0</code></dd><dt>Prototype property of</dt><dd><i>Rectangle</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/shapes/rectangle.litcoffee#float-rectangleradius--0-signal-rectangleonradiuschangefloat-oldvalue)

border
<dl><dt>Syntax</dt><dd><code>&#x2A;Border&#x2A; Rectangle::border</code></dd><dt>Prototype property of</dt><dd><i>Rectangle</i></dd><dt>Type</dt><dd><i>Border</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/shapes/rectangle.litcoffee#border-rectangleborder-signal-rectangleonborderchangestring-property-any-oldvalue)

border.width
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Rectangle::border.width = 0</code></dd><dt>Prototype property of</dt><dd><i>Rectangle</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/shapes/rectangle.litcoffee#float-rectangleborderwidth--0-signal-rectangleborderonwidthchangefloat-oldvalue)

border.color
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Rectangle::border.color = 'transparent'</code></dd><dt>Prototype property of</dt><dd><i>Rectangle</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'transparent'</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/shapes/rectangle.litcoffee#string-rectanglebordercolor--transparent-signal-rectangleborderoncolorchangestring-oldvalue)

