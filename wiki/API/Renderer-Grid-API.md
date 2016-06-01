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
  * [columns](#columns)
  * [rows](#rows)
  * [spacing](#spacing)
  * [alignment](#alignment)
  * [includeBorderMargins](#includebordermargins)
* [Glossary](#glossary)

#**Class** Grid
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Grid : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#class-grid)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Grid&#x2A; Grid.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#new)

##padding
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Margin&#x2A; Grid::padding</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Margin-API#class-margin">Item.Margin</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#padding)

##columns
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; Grid::columns = `2`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd><dt>Default</dt><dd><code>2</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#columns)

##rows
<dl><dt>Syntax</dt><dd><code>&#x2A;Number&#x2A; Grid::rows = `Infinity`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd><dt>Type</dt><dd><i>Number</i></dd><dt>Default</dt><dd><code>Infinity</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#rows)

##spacing
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Spacing&#x2A; Grid::spacing</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Spacing-API#class-spacing">Item.Spacing</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#spacing)

##alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Alignment&#x2A; Grid::alignment</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#alignment)

##includeBorderMargins
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Grid::includeBorderMargins = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Grid-API#class-grid">Grid</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/grid.litcoffee#includebordermargins)

# Glossary

- [Grid](#class-grid)

