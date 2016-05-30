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

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#rectangle)

## Table of contents
* [Rectangle](#rectangle)
* [**Class** Rectangle](#class-rectangle)
  * [New](#new)
  * [*String* Rectangle::color = `'transparent'`](#string-rectanglecolor--transparent)
  * [*Float* Rectangle::radius = `0`](#float-rectangleradius--0)
  * [border](#border)
  * [*Float* Rectangle::border.width = `0`](#float-rectangleborderwidth--0)
  * [*String* Rectangle::border.color = `'transparent'`](#string-rectanglebordercolor--transparent)
* [Glossary](#glossary)

#*[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* Rectangle
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Rectangle : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#class-rectangle)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Rectangle&#x2A; Rectangle.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#new)

## *String* Rectangle::color = `'transparent'`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Rectangle::onColorChange(*String* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#string-rectanglecolor--transparent-signal-rectangleoncolorchangestring-oldvalue)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Rectangle::radius = `0`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Rectangle::onRadiusChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#float-rectangleradius--0-signal-rectangleonradiuschangefloat-oldvalue)

##border
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Rectangle::border</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Rectangle-API#class-rectangle">Rectangle</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#border)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Rectangle::border.width = `0`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Rectangle::border.onWidthChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#float-rectangleborderwidth--0-signal-rectangleborderonwidthchangefloat-oldvalue)

## *String* Rectangle::border.color = `'transparent'`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Rectangle::border.onColorChange(*String* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/shapes/rectangle.litcoffee#string-rectanglebordercolor--transparent-signal-rectangleborderoncolorchangestring-oldvalue)

# Glossary

- [Rectangle](#class-rectangle)

