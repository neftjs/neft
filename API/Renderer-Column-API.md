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

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee)

## Table of contents
* [Column](#column)
* [**Class** Column](#class-column)
  * [New](#new)
  * [padding](#padding)
  * [onPaddingChange](#onpaddingchange)
  * [spacing](#spacing)
  * [onSpacingChange](#onspacingchange)
  * [alignment](#alignment)
  * [onAlignmentChange](#onalignmentchange)
  * [includeBorderMargins](#includebordermargins)
  * [onIncludeBorderMarginsChange](#onincludebordermarginschange)
* [Glossary](#glossary)

#**Class** Column
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Column : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#class-column--item)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Column&#x2A; Column.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#column-columnnewcomponent-component-object-options)

##padding
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Margin&#x2A; Column::padding</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Margin-API#class-margin">Item.Margin</a></dd></dl>
##onPaddingChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Column::onPaddingChange(&#x2A;Item.Margin&#x2A; padding)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Parameters</dt><dd><ul><li>padding — <a href="/Neft-io/neft/wiki/Renderer-Item.Margin-API#class-margin">Item.Margin</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#signal-columnonpaddingchangeitemmargin-padding)

##spacing
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Column::spacing = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onSpacingChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Column::onSpacingChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#signal-columnonspacingchangefloat-oldvalue)

##alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Alignment&#x2A; Column::alignment</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></dd></dl>
##onAlignmentChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Column::onAlignmentChange(&#x2A;Item.Alignment&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#signal-columnonalignmentchangeitemalignment-oldvalue)

##includeBorderMargins
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Column::includeBorderMargins = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
##onIncludeBorderMarginsChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Column::onIncludeBorderMarginsChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Column-API#class-column">Column</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/column.litcoffee#signal-columnonincludebordermarginschangeboolean-oldvalue)

# Glossary

- [Column](#class-column)

