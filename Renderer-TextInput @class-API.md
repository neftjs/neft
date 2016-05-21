> [Wiki](Home) ▸ [API Reference](API-Reference)

TextInput
<dl><dt>Syntax</dt><dd>TextInput @class</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#textinput-class)

New
<dl><dt>Syntax</dt><dd>*TextInput* TextInput.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])</dd><dt>Static method of</dt><dd><i>TextInput</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>TextInput</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#textinput-textinputnewcomponent-component-object-options)

keysFocusOnPointerPress
<dl><dt>Syntax</dt><dd>*Boolean* TextInput.keysFocusOnPointerPress = true</dd><dt>Static property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#boolean-textinputkeysfocusonpointerpress--true)

TextInput
<dl><dt>Syntax</dt><dd>*TextInput* TextInput() : *Renderer.Item*</dd><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>TextInput</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#textinput-textinput--rendereritem)

width
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) TextInput::width = 100</dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>100</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#float-textinputwidth--100float-textinputheight--50string-textinputtext-signal-textinputontextchangestring-oldvalue)

color
<dl><dt>Syntax</dt><dd>*String* TextInput::color = 'black'</dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'black'</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#string-textinputcolor--black-signal-textinputoncolorchangestring-oldvalue)

lineHeight
<dl><dt>Syntax</dt><dd>Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) TextInput::lineHeight = 1</dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#hidden-float-textinputlineheight--1-hidden-signal-textinputonlineheightchangefloat-oldvalue)

multiLine
<dl><dt>Syntax</dt><dd>*Boolean* TextInput::multiLine = false</dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#boolean-textinputmultiline--false-signal-textinputonmultilinechangeboolean-oldvalue)

echoMode
<dl><dt>Syntax</dt><dd>*String* TextInput::echoMode = 'normal'</dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'normal'</code></dd></dl>
Accepts 'normal' and 'password'.

##onEchoModeChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) TextInput::onEchoModeChange(*String* oldValue)</dd><dt>Prototype method of</dt><dd><i>TextInput</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#signal-textinputonechomodechangestring-oldvalue)

alignment
<dl><dt>Syntax</dt><dd>Hidden *Alignment* TextInput::alignment</dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>Alignment</i></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#hidden-alignment-textinputalignment-hidden-signal-textinputonalignmentchangealignment-alignment)

font
<dl><dt>Syntax</dt><dd>*Font* TextInput::font</dd><dt>Prototype property of</dt><dd><i>TextInput</i></dd><dt>Type</dt><dd><i>Font</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/textInput.litcoffee#font-textinputfont-signal-textinputonfontchangestring-property-any-oldvalue)

