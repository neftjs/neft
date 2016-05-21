> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Navigator
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#navigator-namespace)

<dl><dt>Type</dt><dd><i>Object</i></dd></dl>
Navigator
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#object-navigator)

<dl><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>'en'</code></dd></dl>
language
```nml
`Text {
`   text: "Your language: " + Navigator.language
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorlanguage--en)

<dl><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
browser
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorbrowser--true)

<dl><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
native
```style
`Text {
`   text: Navigator.native ? "Native" : "Browser"
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatornative--false)

## Table of contents
    * [Navigator](#navigator)
    * [Navigator](#navigator)
    * [language](#language)
    * [browser](#browser)
    * [native](#native)
  * [*Boolean* Navigator.online = true](#boolean-navigatoronline--true)

*Boolean* Navigator.online = true
---------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Navigator.onOnlineChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatoronline--true-signal-navigatorononlinechangeboolean-oldvalue)

