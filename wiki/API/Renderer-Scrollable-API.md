> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Scrollable**

# Scrollable

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#scrollable)

## Table of contents
* [Scrollable](#scrollable)
* [**Class** Scrollable](#class-scrollable)
  * [New](#new)
  * [*Item* Scrollable::contentItem = `null`](#item-scrollablecontentitem--null)
  * [*Float* Scrollable::contentX = `0`](#float-scrollablecontentx--0)
  * [*Float* Scrollable::contentY = `0`](#float-scrollablecontenty--0)
  * [Hidden *Boolean* Scrollable::snap = `false`](#hidden-boolean-scrollablesnap--false)
  * [snapItem](#snapitem)
* [Glossary](#glossary)

#*[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* Scrollable
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Scrollable : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#class-scrollable)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Scrollable&#x2A; Scrollable.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#new)

## [Item](/Neft-io/neft/wiki/Renderer-Item-API#class-item) Scrollable::contentItem = `null`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Scrollable::onContentItemChange([Item](/Neft-io/neft/wiki/Renderer-Item-API#class-item) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#item-scrollablecontentitem--null-signal-scrollableoncontentitemchangeitem-oldvalue)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Scrollable::contentX = `0`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Scrollable::onContentXChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#float-scrollablecontentx--0-signal-scrollableoncontentxchangefloat-oldvalue)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Scrollable::contentY = `0`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Scrollable::onContentYChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#float-scrollablecontenty--0-signal-scrollableoncontentychangefloat-oldvalue)

## Hidden *Boolean* Scrollable::snap = `false`

## Hidden [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Scrollable::onSnapChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#hidden-boolean-scrollablesnap--false-hidden-signal-scrollableonsnapchangeboolean-oldvalue)

##snapItem
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Item&#x2A; Scrollable::snapItem</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Scrollable-API#class-scrollable">Scrollable</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/layout/scrollable.litcoffee#snapitem)

# Glossary

- [Scrollable](#class-scrollable)

