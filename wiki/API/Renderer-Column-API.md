> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Column**

# Column

```javascript
Column {
    spacing: 5
    Rectangle { color: 'blue'; width: 50; height: 50; }
    Rectangle { color: 'green'; width: 20; height: 50; }
    Rectangle { color: 'red'; width: 50; height: 20; }
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#column)

## Table of contents
* [Column](#column)
* [**Class** Column](#class-column)
  * [New](#new)
  * [padding](#padding)
  * [*Float* Column::spacing = `0`](#float-columnspacing--0)
  * [alignment](#alignment)
  * [*Boolean* Column::includeBorderMargins = `false`](#boolean-columnincludebordermargins--false)
* [Glossary](#glossary)

#*[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* Column
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Column : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#class-column)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Column&#x2A; Column.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#new)

##padding
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Margin&#x2A; Column::padding</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Margin-API#class-margin">Item.Margin</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#padding)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Column::spacing = `0`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Column::onSpacingChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#float-columnspacing--0-signal-columnonspacingchangefloat-oldvalue)

##alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Alignment&#x2A; Column::alignment</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#alignment)

## *Boolean* Column::includeBorderMargins = `false`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Column::onIncludeBorderMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#boolean-columnincludebordermargins--false-signal-columnonincludebordermarginschangeboolean-oldvalue)

# Glossary

- [Column](#class-column)

