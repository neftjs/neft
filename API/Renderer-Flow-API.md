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

> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/renderer/types/layout/flow.litcoffee)

## Table of contents
* [Flow](#flow)
* [**Class** Flow](#class-flow)
  * [New](#new)
  * [padding](#padding)
  * [onPaddingChange](#onpaddingchange)
  * [spacing](#spacing)
  * [onSpacingChange](#onspacingchange)
  * [alignment](#alignment)
  * [onAlignmentChange](#onalignmentchange)
  * [includeBorderMargins](#includebordermargins)
  * [onIncludeBorderMarginsChange](#onincludebordermarginschange)
  * [collapseMargins](#collapsemargins)
  * [onCollapseMarginsChange](#oncollapsemarginschange)
* [Glossary](#glossary)

#**Class** Flow
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Flow : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/renderer/types/layout/flow.litcoffee#class-flow--item)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Flow&#x2A; Flow.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Flow-API#class-flow">Flow</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Flow-API#class-flow">Flow</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/renderer/types/layout/flow.litcoffee#flow-flownewcomponent-component-object-options)

##padding
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Margin&#x2A; Flow::padding</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Flow-API#class-flow">Flow</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Margin-API#class-margin">Item.Margin</a></dd></dl>
##onPaddingChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Flow::onPaddingChange(&#x2A;Item.Margin&#x2A; padding)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Flow-API#class-flow">Flow</a></dd><dt>Parameters</dt><dd><ul><li>padding — <a href="/Neft-io/neft/wiki/Renderer-Item.Margin-API#class-margin">Item.Margin</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/renderer/types/layout/flow.litcoffee#signal-flowonpaddingchangeitemmargin-padding)

##spacing
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Spacing&#x2A; Flow::spacing</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Flow-API#class-flow">Flow</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Spacing-API#class-spacing">Item.Spacing</a></dd></dl>
##onSpacingChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Flow::onSpacingChange(&#x2A;Item.Spacing&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Flow-API#class-flow">Flow</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Item.Spacing-API#class-spacing">Item.Spacing</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/renderer/types/layout/flow.litcoffee#signal-flowonspacingchangeitemspacing-oldvalue)

##alignment
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Alignment&#x2A; Flow::alignment</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Flow-API#class-flow">Flow</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></dd></dl>
##onAlignmentChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Flow::onAlignmentChange(&#x2A;Item.Alignment&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Flow-API#class-flow">Flow</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/renderer/types/layout/flow.litcoffee#signal-flowonalignmentchangeitemalignment-oldvalue)

##includeBorderMargins
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Flow::includeBorderMargins = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Flow-API#class-flow">Flow</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
##onIncludeBorderMarginsChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Flow::onIncludeBorderMarginsChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Flow-API#class-flow">Flow</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/renderer/types/layout/flow.litcoffee#signal-flowonincludebordermarginschangeboolean-oldvalue)

##collapseMargins
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Flow::collapseMargins = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Flow-API#class-flow">Flow</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
##onCollapseMarginsChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Flow::onCollapseMarginsChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Flow-API#class-flow">Flow</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/renderer/types/layout/flow.litcoffee#signal-flowoncollapsemarginschangeboolean-oldvalue)

# Glossary

- [Flow](#class-flow)

