> [Wiki](Home) ▸ [API Reference](API-Reference)

Image
<dl><dt>Syntax</dt><dd><code>Image @class</code></dd></dl>
```nml
`Image {
`   source: 'http://lorempixel.com/200/140/'
`   onLoad: function(error){
`       if (error){
`           console.error("Can't load this image");
`       } else {
`           console.log("Image has been loaded");
`       }
`   }
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#image-class)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;Image&#x2A; Image.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Image</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#image-imagenewcomponent-component-object-options)

Image
<dl><dt>Syntax</dt><dd><code>&#x2A;Image&#x2A; Image() : &#x2A;Renderer.Item&#x2A;</code></dd><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Image</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#image-image--rendereritem)

pixelRatio
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Image.pixelRatio = 1</code></dd><dt>Static property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#float-imagepixelratio--1-signal-imageonpixelratiochangefloat-oldvalue)

width
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Image::width = -1</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#float-imagewidth--1)

height
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Image::height = -1</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#float-imageheight--1)

source
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Image::source</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
The image source URL or data URI.

##onSourceChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onSourceChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonsourcechangestring-oldvalue)

resolution
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Image::resolution = 1</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#readonly-float-imageresolution--1)

sourceWidth
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Image::sourceWidth = 0</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourcewidth--0-hidden-signal-imageonsourcewidthchangefloat-oldvalue)

sourceHeight
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Image::sourceHeight = 0</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourceheight--0-hidden-signal-imageonsourceheightchangefloat-oldvalue)

offsetX
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Image::offsetX = 0</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsetx--0-hidden-signal-imageonoffsetxchangefloat-oldvalue)

offsetY
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Image::offsetY = 0</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsety--0-hidden-signal-imageonoffsetychangefloat-oldvalue)

fillMode
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Integer&#x2A; Image::fillMode = 'Stretch'</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>'Stretch'</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#hidden-integer-imagefillmode--stretch-hidden-signal-imageonfillmodechangeinteger-oldvalue)

loaded
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; Image::loaded</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#readonly-boolean-imageloaded)

##onLoadedChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onLoadedChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonloadedchangeboolean-oldvalue)

onLoad
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onLoad()</code></dd><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonload)

onError
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onError(&#x2A;Error&#x2A; error)</code></dd><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>error — <i>Error</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonerrorerror-error)

