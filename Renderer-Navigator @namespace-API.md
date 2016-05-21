> [Wiki](Home) ▸ [API Reference](API-Reference)

Navigator
<dl><dt>Syntax</dt><dd><code>Navigator @namespace</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/navigator.litcoffee#navigator-namespace)

Navigator
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Navigator</code></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/navigator.litcoffee#object-navigator)

language
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Navigator.language = 'en'</code></dd><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>'en'</code></dd></dl>
```nml
`Text {
`   text: "Your language: " + Navigator.language
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorlanguage--en)

browser
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Navigator.browser = true</code></dd><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorbrowser--true)

native
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Navigator.native = false</code></dd><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
```style
`Text {
`   text: Navigator.native ? "Native" : "Browser"
`   font.pixelSize: 30
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatornative--false)

online
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Navigator.online = true</code></dd><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatoronline--true-signal-navigatorononlinechangeboolean-oldvalue)

