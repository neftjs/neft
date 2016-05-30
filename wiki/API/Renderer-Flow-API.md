> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Flow**

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

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/flow.litcoffee#flow)

## Table of contents
* [Flow](#flow)
* [**Class** Float](#class-float)
  * [New](#new)
  * [padding](#padding)
  * [spacing](#spacing)
  * [alignment](#alignment)
  * [*Boolean* Flow::includeBorderMargins = `false`](#boolean-flowincludebordermargins--false)
  * [*Boolean* Flow::collapseMargins = `false`](#boolean-flowcollapsemargins--false)
* [Glossary](#glossary)

#*[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* Float
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Float : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/flow.litcoffee#class-float)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Flow&#x2A; Flow.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>Flow</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Flow</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/flow.litcoffee#new)

##padding
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Margin&#x2A; Flow::padding</code></dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Margin-API#class-margin">Item.Margin</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/flow.litcoffee#padding)

##spacing
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Spacing&#x2A; Flow::spacing</code></dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Spacing-API#class-spacing">Item.Spacing</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/flow.litcoffee#spacing)

##alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Alignment&#x2A; Flow::alignment</code></dd><dt>Prototype property of</dt><dd><i>Flow</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/flow.litcoffee#alignment)

## *Boolean* Flow::includeBorderMargins = `false`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Flow::onIncludeBorderMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/flow.litcoffee#boolean-flowincludebordermargins--false-signal-flowonincludebordermarginschangeboolean-oldvalue)

## *Boolean* Flow::collapseMargins = `false`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Flow::onCollapseMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/flow.litcoffee#boolean-flowcollapsemargins--false-signal-flowoncollapsemarginschangeboolean-oldvalue)

# Glossary

- [Flow](#class-flow)

