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
  * [spacing](#spacing)
  * [alignment](#alignment)
  * [includeBorderMargins](#includebordermargins)
* [Glossary](#glossary)

#**Class** Column
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Column : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#class-column)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Column&#x2A; Column.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#new)

##padding
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Margin&#x2A; Column::padding</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Margin-API#class-margin">Item.Margin</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#padding)

##spacing
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Column::spacing = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#spacing)

##alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Alignment&#x2A; Column::alignment</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#alignment)

##includeBorderMargins
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Column::includeBorderMargins = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#includebordermargins)

# Glossary

- [Column](#class-column)

