# Navigator

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Navigator**

<!-- toc -->

> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/namespace/navigator.litcoffee)


* * * 

### `Navigator.language`

<dl><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>&#39;en&#39;</code></dd></dl>

```javascript
Text {
    text: 'Your language: ' + Navigator.language
    font.pixelSize: 30
}
```


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorlanguage--39en39)


* * * 

### `Navigator.browser`

<dl><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorbrowser--true)


* * * 

### `Navigator.native`

<dl><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>

```javascript
Text {
    text: Navigator.native ? 'Native' : 'Browser'
    font.pixelSize: 30
}
```


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatornative--false)


* * * 

### `Navigator.online`

<dl><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>


* * * 

### `Navigator.onOnlineChange()`

<dl><dt>Static property of</dt><dd><i>Navigator</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/namespace/navigator.litcoffee#signal-navigatorononlinechangeboolean-oldvalue)

