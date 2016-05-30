> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Grid**

# Grid

```javascript
Grid {
    spacing.column: 15
    spacing.row: 5
    columns: 2
    Rectangle { color: 'blue'; width: 60; height: 50; }
    Rectangle { color: 'green'; width: 20; height: 70; }
    Rectangle { color: 'red'; width: 50; height: 30; }
    Rectangle { color: 'yellow'; width: 20; height: 20; }
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#grid)

## Table of contents
* [Grid](#grid)
* [**Class** Grid](#class-grid)
  * [New](#new)
  * [padding](#padding)
  * [*Integer* Grid::columns = `2`](#integer-gridcolumns--2)
  * [*Number* Grid::rows = `Infinity`](#number-gridrows--infinity)
  * [spacing](#spacing)
  * [alignment](#alignment)
  * [*Boolean* Grid::includeBorderMargins = `false`](#boolean-gridincludebordermargins--false)
* [Glossary](#glossary)

#*[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* Grid
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Grid : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#class-grid)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Grid&#x2A; Grid.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#new)

##padding
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Margin&#x2A; Grid::padding</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Margin-API#class-margin">Item.Margin</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#padding)

## [Integer](/Neft-io/neft/wiki/Utils-API#isinteger) Grid::columns = `2`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Grid::onColumnsChange([Integer](/Neft-io/neft/wiki/Utils-API#isinteger) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#integer-gridcolumns--2-signal-gridoncolumnschangeinteger-oldvalue)

## *Number* Grid::rows = `Infinity`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Grid::onRowsChange(*Number* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#number-gridrows--infinity-signal-gridonrowschangenumber-oldvalue)

##spacing
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Spacing&#x2A; Grid::spacing</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Spacing-API#class-spacing">Item.Spacing</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#spacing)

##alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Alignment&#x2A; Grid::alignment</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#alignment)

## *Boolean* Grid::includeBorderMargins = `false`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Grid::onIncludeBorderMarginsChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#boolean-gridincludebordermargins--false-signal-gridonincludebordermarginschangeboolean-oldvalue)

# Glossary

- [Grid](#class-grid)

