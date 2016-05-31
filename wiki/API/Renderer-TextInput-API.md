> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **TextInput**

# TextInput

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#textinput)

## Table of contents
* [TextInput](#textinput)
* [**Class** TextInput](#class-textinput)
  * [New](#new)
  * [*Boolean* TextInput.keysFocusOnPointerPress = true](#boolean-textinputkeysfocusonpointerpress--true)
  * [width](#width)
  * [color](#color)
  * [lineHeight](#lineheight)
  * [multiLine](#multiline)
  * [echoMode](#echomode)
  * [onEchoModeChange](#onechomodechange)
  * [alignment](#alignment)
  * [font](#font)
* [Glossary](#glossary)

#**Class** TextInput
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; TextInput : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#class-textinput)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;TextInput&#x2A; TextInput.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#new)

## *Boolean* TextInput.keysFocusOnPointerPress = true

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#boolean-textinputkeysfocusonpointerpress--true)

##width
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; TextInput::width = `100`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>100</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#width)

##color
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; TextInput::color = `'black'`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'black'</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#color)

##lineHeight
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; TextInput::lineHeight = `1`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>1</code></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#lineheight)

##multiLine
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; TextInput::multiLine = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/textInput.litcoffee#multiline)

##echoMode
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; TextInput::echoMode = `'normal'`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-TextInput-API#class-textinput">TextInput</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'normal'</code></dd></dl>
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

