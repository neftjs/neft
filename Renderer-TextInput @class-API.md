> [Wiki](Home) ▸ [API Reference](API-Reference)

TextInput
<dl><dt>Syntax</dt><dd><code>TextInput @class</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/textInput.litcoffee#textinput-class)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;TextInput&#x2A; TextInput.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>TextInput</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>TextInput</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/textInput.litcoffee#textinput-textinputnewcomponent-component-object-options)

keysFocusOnPointerPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; TextInput.keysFocusOnPointerPress = true</code></dd><dt>Static property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/textInput.litcoffee#boolean-textinputkeysfocusonpointerpress--true)

TextInput
<dl><dt>Syntax</dt><dd><code>&#x2A;TextInput&#x2A; TextInput() : &#x2A;Renderer.Item&#x2A;</code></dd><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>TextInput</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/textInput.litcoffee#textinput-textinput--rendereritem)

width
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; TextInput::width = 100</code></dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>100</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/textInput.litcoffee#float-textinputwidth--100float-textinputheight--50string-textinputtext-signal-textinputontextchangestring-oldvalue)

color
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; TextInput::color = 'black'</code></dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'black'</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/textInput.litcoffee#string-textinputcolor--black-signal-textinputoncolorchangestring-oldvalue)

lineHeight
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; TextInput::lineHeight = 1</code></dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/textInput.litcoffee#hidden-float-textinputlineheight--1-hidden-signal-textinputonlineheightchangefloat-oldvalue)

multiLine
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; TextInput::multiLine = false</code></dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/textInput.litcoffee#boolean-textinputmultiline--false-signal-textinputonmultilinechangeboolean-oldvalue)

echoMode
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; TextInput::echoMode = 'normal'</code></dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'normal'</code></dd></dl>
Accepts 'normal' and 'password'.

##onEchoModeChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; TextInput::onEchoModeChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>TextInput</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/textInput.litcoffee#signal-textinputonechomodechangestring-oldvalue)

alignment
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Alignment&#x2A; TextInput::alignment</code></dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>Alignment</i></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/textInput.litcoffee#hidden-alignment-textinputalignment-hidden-signal-textinputonalignmentchangealignment-alignment)

font
<dl><dt>Syntax</dt><dd><code>&#x2A;Font&#x2A; TextInput::font</code></dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>Font</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/textInput.litcoffee#font-textinputfont-signal-textinputonfontchangestring-property-any-oldvalue)

