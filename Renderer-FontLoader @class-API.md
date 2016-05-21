> [Wiki](Home) ▸ [API Reference](API-Reference)

FontLoader
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
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/font.litcoffee#fontloader-fontloadernewcomponent-component-object-options)

FontLoader
Class used to load custom fonts.
You can override default fonts (*sans-serif*, *sans* and *monospace*).
The font weight and the style (italic or normal) is extracted from the font source path.
Access it with:
```nml
FontLoader {}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/font.litcoffee#fontloader-fontloader)

name
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/font.litcoffee#string-fontloadername)

source
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

