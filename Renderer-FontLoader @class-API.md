> [Wiki](Home) ▸ [API Reference](API-Reference)

FontLoader
<dl><dt>Syntax</dt><dd><code>FontLoader @class</code></dd></dl>
```nml
`Item {
`   Text {
`       font.family: 'myFont'
`       text: 'Cool font!'
`   }
`}
`
`FontLoader {
`   name: 'myFont'
`   source: 'rsc:/static/fonts/myFont'
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/font.litcoffee#fontloader-class)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;FontLoader&#x2A; FontLoader.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>FontLoader</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>FontLoader</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/font.litcoffee#fontloader-fontloadernewcomponent-component-object-options)

FontLoader
<dl><dt>Syntax</dt><dd><code>&#x2A;FontLoader&#x2A; FontLoader()</code></dd><dt>Returns</dt><dd><i>FontLoader</i></dd></dl>
Class used to load custom fonts.
You can override default fonts (*sans-serif*, *sans* and *monospace*).
The font weight and the style (italic or normal) is extracted from the font source path.
Access it with:
```nml
FontLoader {}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/font.litcoffee#fontloader-fontloader)

name
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; FontLoader::name</code></dd><dt>Prototype property of</dt><dd><i>FontLoader</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/font.litcoffee#string-fontloadername)

source
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; FontLoader::source</code></dd><dt>Prototype property of</dt><dd><i>FontLoader</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
We recommend usng **WOFF** format and **TTF/OTF** for the oldest Android browser.
Must contains one of:
 - hairline (weight=0),
 - thin,
 - ultra.*light,
 - extra.*light,
 - light,
 - book,
 - normal|regular|roman|plain,
 - medium,
 - demi.*bold|semi.*bold,
 - bold,
 - extra.*bold|extra,
 - heavy,
 - black,
 - extra.*black,
 - ultra.*black|ultra (weight=1).
Italic font filename must contains 'italic'.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/font.litcoffee#string-fontloadersource)

