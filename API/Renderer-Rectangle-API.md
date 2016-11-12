> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Rectangle**

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

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee)

## Table of contents
* [Rectangle](#rectangle)
* [**Class** Rectangle](#class-rectangle)
  * [New](#new)
  * [color](#color)
  * [onColorChange](#oncolorchange)
  * [radius](#radius)
  * [onRadiusChange](#onradiuschange)
  * [border](#border)
  * [onBorderChange](#onborderchange)
  * [border.width](#borderwidth)
  * [border.onWidthChange](#borderonwidthchange)
  * [border.color](#bordercolor)
  * [border.onColorChange](#borderoncolorchange)
* [Glossary](#glossary)

#**Class** Rectangle
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Rectangle : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#class-rectangle--item)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Rectangle&#x2A; Rectangle.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#rectangle-rectanglenewcomponent-component-object-options)

##color
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Rectangle::color = `'transparent'`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'transparent'</code></dd></dl>
##onColorChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Rectangle::onColorChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#signal-rectangleoncolorchangestring-oldvalue)

##radius
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Rectangle::radius = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onRadiusChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Rectangle::onRadiusChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#signal-rectangleonradiuschangefloat-oldvalue)

##border
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Rectangle::border</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
##onBorderChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Rectangle::onBorderChange(&#x2A;String&#x2A; property, &#x2A;Any&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#signal-rectangleonborderchangestring-property-any-oldvalue)

##border.width
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Rectangle::border.width = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##border.onWidthChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Rectangle::border.onWidthChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#signal-rectangleborderonwidthchangefloat-oldvalue)

##border.color
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Rectangle::border.color = `'transparent'`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'transparent'</code></dd></dl>
##border.onColorChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Rectangle::border.onColorChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#signal-rectangleborderoncolorchangestring-oldvalue)

# Glossary

- [Rectangle](#class-rectangle)

