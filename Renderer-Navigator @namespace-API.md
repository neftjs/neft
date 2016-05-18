> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Navigator @namespace**

Navigator @namespace
====================

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#navigator-namespace)

## Table of contents
  * [Navigator](#object-navigator)
  * [Navigator.language = 'en'](#boolean-navigatorlanguage--en)
  * [Navigator.browser = true](#boolean-navigatorbrowser--true)
  * [Navigator.native = false](#boolean-navigatornative--false)
  * [Navigator.online = true](#boolean-navigatoronline--true)

*Object* Navigator
------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#object-navigator)

*Boolean* Navigator.language = 'en'
-----------------------------------

```nml
`Text {
`   text: "Your language: " + Navigator.language
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorlanguage--en)

*Boolean* Navigator.browser = true
----------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorbrowser--true)

*Boolean* Navigator.native = false
----------------------------------

```style
`Text {
`   text: Navigator.native ? "Native" : "Browser"
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatornative--false)

*Boolean* Navigator.online = true
---------------------------------
## *Signal* Navigator.onOnlineChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatoronline--true-signal-navigatorononlinechangeboolean-oldvalue)

