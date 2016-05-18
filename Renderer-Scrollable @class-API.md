> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Scrollable @class**

Scrollable @class
==========

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/scrollable.litcoffee#scrollable-class)

## Table of contents
  * [Scrollable.New([component, options])](#scrollable-scrollablenewcomponent-component-object-options)
  * [Scrollable() : *Renderer.Item*](#scrollable-scrollable--rendereritem)
  * [clip = true](#boolean-scrollableclip--true)
  * [contentX = 0](#float-scrollablecontentx--0)
  * [contentY = 0](#float-scrollablecontenty--0)
  * [Hidden snap = false](#hidden-boolean-scrollablesnap--false)
  * [Hidden *Renderer.Item* snapItem](#hidden-rendereritem-scrollablesnapitem)

*Scrollable* Scrollable.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])
----------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/scrollable.litcoffee#scrollable-scrollablenewcomponent-component-object-options)

*Scrollable* Scrollable() : *Renderer.Item*
-------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/scrollable.litcoffee#scrollable-scrollable--rendereritem)

*Boolean* Scrollable::clip = true
---------------------------------
*Renderer.Item* Scrollable::contentItem = null
----------------------------------------------
## *Signal* Scrollable::onContentItemChange([*Renderer.Item* oldValue])

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/scrollable.litcoffee#boolean-scrollableclip--truerendereritem-scrollablecontentitem--null-signal-scrollableoncontentitemchangerendereritem-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Scrollable::contentX = 0
--------------------------------
## *Signal* Scrollable::onContentXChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/scrollable.litcoffee#float-scrollablecontentx--0-signal-scrollableoncontentxchangefloat-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Scrollable::contentY = 0
--------------------------------
## *Signal* Scrollable::onContentYChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/scrollable.litcoffee#float-scrollablecontenty--0-signal-scrollableoncontentychangefloat-oldvalue)

Hidden *Boolean* Scrollable::snap = false
-----------------------------------------
## Hidden *Signal* Scrollable::onSnapChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/scrollable.litcoffee#hidden-boolean-scrollablesnap--false-hidden-signal-scrollableonsnapchangeboolean-oldvalue)

Hidden *Renderer.Item* Scrollable::snapItem
-------------------------------------------
## Hidden *Signal* Scrollable::onSnapItemChange(*Renderer.Item* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/layout/scrollable.litcoffee#hidden-rendereritem-scrollablesnapitem-hidden-signal-scrollableonsnapitemchangerendereritem-oldvalue)

