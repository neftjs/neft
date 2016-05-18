> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **TextInput @class**

TextInput @class
================

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#textinput-class)

## Table of contents
  * [TextInput.New([component, options])](#textinput-textinputnewcomponent-component-object-options)
  * [TextInput.keysFocusOnPointerPress = true](#boolean-textinputkeysfocusonpointerpress--true)
  * [TextInput() : *Renderer.Item*](#textinput-textinput--rendereritem)
  * [width = 100](#float-textinputwidth--100)
  * [color = 'black'](#string-textinputcolor--black)
  * [Hidden lineHeight = 1](#hidden-float-textinputlineheight--1)
  * [multiLine = false](#boolean-textinputmultiline--false)
  * [echoMode = 'normal'](#string-textinputechomode--normal)
  * [onEchoModeChange(oldValue)](#signal-textinputonechomodechangestring-oldvalue)
  * [Hidden alignment](#hidden-alignment-textinputalignment)
  * [font](#font-textinputfont)

*TextInput* TextInput.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])
--------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#textinput-textinputnewcomponent-component-object-options)

*Boolean* TextInput.keysFocusOnPointerPress = true
--------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#boolean-textinputkeysfocusonpointerpress--true)

*TextInput* TextInput() : *Renderer.Item*
-----------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#textinput-textinput--rendereritem)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) TextInput::width = 100
------------------------------
[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) TextInput::height = 50
------------------------------
*String* TextInput::text
------------------------
## *Signal* TextInput::onTextChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#float-textinputwidth--100float-textinputheight--50string-textinputtext-signal-textinputontextchangestring-oldvalue)

*String* TextInput::color = 'black'
-----------------------------------
## *Signal* TextInput::onColorChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#string-textinputcolor--black-signal-textinputoncolorchangestring-oldvalue)

Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) TextInput::lineHeight = 1
----------------------------------------
## Hidden *Signal* TextInput::onLineHeightChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#hidden-float-textinputlineheight--1-hidden-signal-textinputonlineheightchangefloat-oldvalue)

*Boolean* TextInput::multiLine = false
--------------------------------------
## *Signal* TextInput::onMultiLineChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#boolean-textinputmultiline--false-signal-textinputonmultilinechangeboolean-oldvalue)

*String* TextInput::echoMode = 'normal'
---------------------------------------

Accepts 'normal' and 'password'.

## *Signal* TextInput::onEchoModeChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#signal-textinputonechomodechangestring-oldvalue)

Hidden *Alignment* TextInput::alignment
---------------------------------------
## Hidden *Signal* TextInput::onAlignmentChange(*Alignment* alignment)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#hidden-alignment-textinputalignment-hidden-signal-textinputonalignmentchangealignment-alignment)

*Font* TextInput::font
----------------------
## *Signal* TextInput::onFontChange(*String* property, *Any* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#font-textinputfont-signal-textinputonfontchangestring-property-any-oldvalue)

