> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Row**

# Row

```javascript
Row {
    spacing: 5
    Rectangle { color: 'blue'; width: 50; height: 50; }
    Rectangle { color: 'green'; width: 20; height: 50; }
    Rectangle { color: 'red'; width: 50; height: 20; }
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/row.litcoffee#row)

## Table of contents
* [Row](#row)
* [**Class** Row](#class-row)
  * [New](#new)
  * [padding](#padding)
  * [*Float* Row::spacing = `0`](#float-rowspacing--0)
  * [alignment](#alignment)
  * [*Boolean* Row::includeBorderMargins = `false`](#boolean-rowincludebordermargins--false)
* [Glossary](#glossary)

#*[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* Row
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Row : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/row.litcoffee#class-row)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Row&#x2A; Row.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Row-API#class-row">Row</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Row-API#class-row">Row</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/row.litcoffee#new)

##padding
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Margin&#x2A; Row::padding</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Row-API#class-row">Row</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Margin-API#class-margin">Item.Margin</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/row.litcoffee#padding)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Row::spacing = `0`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Row::onSpacingChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/row.litcoffee#float-rowspacing--0-signal-rowonspacingchangefloat-oldvalue)

##alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Alignment&#x2A; Row::alignment</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Row-API#class-row">Row</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/row.litcoffee#alignment)

## *Boolean* Row::includeBorderMargins = `false`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Row::onIncludeBorderMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/row.litcoffee#boolean-rowincludebordermargins--false-signal-rowonincludebordermarginschangeboolean-oldvalue)

# Glossary

- [Row](#class-row)

