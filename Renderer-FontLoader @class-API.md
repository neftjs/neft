> [Wiki](Home) ▸ [API Reference](API-Reference)

FontLoader
<dl></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/font.litcoffee#fontloader-class)

New
<dl><dt>Static method of</dt><dd><i>FontLoader</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>FontLoader</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/font.litcoffee#fontloader-fontloadernewcomponent-component-object-options)

FontLoader
<dl><dt>Returns</dt><dd><i>FontLoader</i></dd></dl>
Class used to load custom fonts.
You can override default fonts (*sans-serif*, *sans* and *monospace*).
The font weight and the style (italic or normal) is extracted from the font source path.
Access it with:
```nml
FontLoader {}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/font.litcoffee#fontloader-fontloader)

name
<dl><dt>Prototype property of</dt><dd><i>FontLoader</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/font.litcoffee#string-fontloadername)

source
<dl><dt>Prototype property of</dt><dd><i>FontLoader</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/font.litcoffee#string-fontloadersource)

