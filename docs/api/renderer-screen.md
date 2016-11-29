# Screen

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Screen**

<!-- toc -->

> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/namespace/screen.litcoffee)


* * * 

### `Screen.touch`

<dl><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Read Only</dt></dl>

```javascript
Text {
    text: Screen.touch ? 'Touch' : 'Mouse'
    font.pixelSize: 30
}
```


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/namespace/screen.litcoffee#readonly-boolean-screentouch--false)


* * * 

### `Screen.width`

<dl><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1024</code></dd><dt>Read Only</dt></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/namespace/screen.litcoffee#readonly-float-screenwidth--1024)


* * * 

### `Screen.height`

<dl><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>800</code></dd><dt>Read Only</dt></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/namespace/screen.litcoffee#readonly-float-screenheight--800)


* * * 

### `Screen.orientation`

<dl><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>&#39;Portrait&#39;</code></dd><dt>Read Only</dt></dl>

May contains: Portrait, Landscape, InvertedPortrait, InvertedLandscape.


* * * 

### `Screen.onOrientationChange()`

<dl><dt>Static property of</dt><dd><i>Screen</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/namespace/screen.litcoffee#signal-screenonorientationchangestring-oldvalue)

