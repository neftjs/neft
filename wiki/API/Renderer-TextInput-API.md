> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **TextInput**

# TextInput

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#textinput)

## Table of contents
* [TextInput](#textinput)
* [**Class** TextInput](#class-textinput)
  * [New](#new)
  * [keysFocusOnPointerPress](#keysfocusonpointerpress)
  * [*Float* TextInput::width = `100`](#float-textinputwidth--100)
  * [*String* TextInput::color = `'black'`](#string-textinputcolor--black)
  * [Hidden *Float* TextInput::lineHeight = `1`](#hidden-float-textinputlineheight--1)
  * [*Boolean* TextInput::multiLine = `false`](#boolean-textinputmultiline--false)
  * [*String* TextInput::echoMode = `'normal'`](#string-textinputechomode--normal)
  * [onEchoModeChange](#onechomodechange)
  * [alignment](#alignment)
  * [font](#font)
* [Glossary](#glossary)

#*[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* TextInput
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; TextInput : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#class-textinput)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;TextInput&#x2A; TextInput.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#new)

##keysFocusOnPointerPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; TextInput.keysFocusOnPointerPress = true</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#keysfocusonpointerpress)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) TextInput::width = `100`

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) TextInput::height = `50`

## *String* TextInput::text

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) TextInput::onTextChange(*String* oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#float-textinputwidth--100-float-textinputheight--50-string-textinputtext-signal-textinputontextchangestring-oldvalue)

## *String* TextInput::color = `'black'`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) TextInput::onColorChange(*String* oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#string-textinputcolor--black-signal-textinputoncolorchangestring-oldvalue)

## Hidden [Float](/Neft-io/neft/wiki/Utils-API#isfloat) TextInput::lineHeight = `1`

## Hidden [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) TextInput::onLineHeightChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#hidden-float-textinputlineheight--1-hidden-signal-textinputonlineheightchangefloat-oldvalue)

## *Boolean* TextInput::multiLine = `false`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) TextInput::onMultiLineChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#boolean-textinputmultiline--false-signal-textinputonmultilinechangeboolean-oldvalue)

## *String* TextInput::echoMode = `'normal'`

Accepts 'normal' and 'password'.

##onEchoModeChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; TextInput::onEchoModeChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#onechomodechange)

##alignment
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Item.Alignment&#x2A; TextInput::alignment</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Alignment-API#class-alignment">Item.Alignment</a></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#alignment)

##font
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Text.Font&#x2A; TextInput::font</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Text.Font-API#class-font">Item.Text.Font</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#font)

# Glossary

- [TextInput](#class-textinput)

