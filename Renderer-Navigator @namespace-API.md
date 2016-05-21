> [Wiki](Home) ▸ [API Reference](API-Reference)

Navigator
<dl></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#navigator-namespace)

Navigator
<dl><dt>Type</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#object-navigator)

language
<dl><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>'en'</code></dd></dl>
```nml
`Text {
`   text: "Your language: " + Navigator.language
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorlanguage--en)

browser
<dl><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorbrowser--true)

native
<dl><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
```style
`Text {
`   text: Navigator.native ? "Native" : "Browser"
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatornative--false)

online
<dl><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatoronline--true-signal-navigatorononlinechangeboolean-oldvalue)

