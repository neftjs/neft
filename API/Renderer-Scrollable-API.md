> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Scrollable**

# Scrollable

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee)

## Table of contents
* [Scrollable](#scrollable)
* [**Class** Scrollable](#class-scrollable)
  * [New](#new)
  * [contentItem](#contentitem)
  * [onContentItemChange](#oncontentitemchange)
  * [contentX](#contentx)
  * [onContentXChange](#oncontentxchange)
  * [contentY](#contenty)
  * [onContentYChange](#oncontentychange)
  * [snap](#snap)
  * [onSnapChange](#onsnapchange)
  * [snapItem](#snapitem)
  * [onSnapItemChange](#onsnapitemchange)
* [Glossary](#glossary)

#**Class** Scrollable
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Scrollable : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#class-scrollable--item)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Scrollable&#x2A; Scrollable.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#scrollable-scrollablenewcomponent-component-object-options)

##contentItem
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Scrollable::contentItem = `null`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Default</dt><dd><code>null</code></dd></dl>
##onContentItemChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Scrollable::onContentItemChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#signal-scrollableoncontentitemchangeitem-oldvalue)

##contentX
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Scrollable::contentX = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onContentXChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Scrollable::onContentXChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#signal-scrollableoncontentxchangefloat-oldvalue)

##contentY
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Scrollable::contentY = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onContentYChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Scrollable::onContentYChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#signal-scrollableoncontentychangefloat-oldvalue)

##snap
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Boolean&#x2A; Scrollable::snap = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Not Implemented</dt></dl>
##onSnapChange
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Signal&#x2A; Scrollable::onSnapChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#hidden-signal-scrollableonsnapchangeboolean-oldvalue)

##snapItem
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Item&#x2A; Scrollable::snapItem</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Not Implemented</dt></dl>
##onSnapItemChange
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Signal&#x2A; Scrollable::onSnapItemChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#hidden-signal-scrollableonsnapitemchangeitem-oldvalue)

# Glossary

- [Scrollable](#class-scrollable)

