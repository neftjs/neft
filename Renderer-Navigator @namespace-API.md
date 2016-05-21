> [Wiki](Home) ▸ [API Reference](API-Reference)

Navigator
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#navigator-namespace)

Navigator
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#object-navigator)

language
```nml
`Text {
`   text: "Your language: " + Navigator.language
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorlanguage--en)

browser
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorbrowser--true)

native
```style
`Text {
`   text: Navigator.native ? "Native" : "Browser"
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatornative--false)

online
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatoronline--true-signal-navigatorononlinechangeboolean-oldvalue)

