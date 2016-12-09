# Image

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Image**

<!-- toc -->
```javascript
Image {
    source: 'http://lorempixel.com/200/140/'
    onLoad: function(error){
        if (error){
            console.error("Can't load this image");
        } else {
            console.log("Image has been loaded");
        }
    }
}
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee)


* * * 

### `Image.New()`

<dl><dt>Static method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Image</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#image-imagenewcomponent-component-object-options)


* * * 

### `constructor()`

<dl><dt>Extends</dt><dd><i>Item</i></dd><dt>Returns</dt><dd><i>Image</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#image-imageconstructor--item)


* * * 

### `Image.pixelRatio`

<dl><dt>Static property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>


* * * 

### `Image.onPixelRatioChange()`

<dl><dt>Static property of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#signal-imageonpixelratiochangefloat-oldvalue)


* * * 

### `width`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#float-imagewidth--1)


* * * 

### `height`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#float-imageheight--1)


* * * 

### `source`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>

The image source URL or data URI.


* * * 

### `onSourceChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#signal-imageonsourcechangestring-oldvalue)


* * * 

### `resolution`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#readonly-float-imageresolution--1)


* * * 

### `sourceWidth`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Read Only</dt></dl>


* * * 

### `onSourceWidthChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#signal-imageonsourcewidthchangefloat-oldvalue)


* * * 

### `sourceHeight`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Read Only</dt></dl>


* * * 

### `onSourceHeightChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#signal-imageonsourceheightchangefloat-oldvalue)


* * * 

### `loaded`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#readonly-boolean-imageloaded--false)


* * * 

### `onLoadedChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#signal-imageonloadedchangeboolean-oldvalue)


* * * 

### `onLoad()`

<dl><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#signal-imageonload)


* * * 

### `onError()`

<dl><dt>Parameters</dt><dd><ul><li>error — <i>Error</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/image.litcoffee#signal-imageonerrorerror-error)

