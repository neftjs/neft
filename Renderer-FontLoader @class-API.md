FontLoader @class
=================

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

*FontLoader* FontLoader.New([*Component* component, *Object* options])
----------------------------------------------------------------------

*FontLoader* FontLoader()
-------------------------

Class used to load custom fonts.

You can override default fonts (*sans-serif*, *sans* and *monospace*).

The font weight and the style (italic or normal) is extracted from the font source path.

Access it with:
```nml
FontLoader {}
```

*String* FontLoader::name
-------------------------

*String* FontLoader::source
---------------------------

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

