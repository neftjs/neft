> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]]

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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#image)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;Image&#x2A; Image.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Image</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#new)

Image
<dl><dt>Syntax</dt><dd><code>&#x2A;Image&#x2A; Image() : &#x2A;Renderer.Item&#x2A;</code></dd><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Image</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#image)

pixelRatio
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Image.pixelRatio = 1</code></dd><dt>Static property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>1</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#pixelratio)

width
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Image::width = -1</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#width)

height
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Image::height = -1</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#height)

source
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Image::source</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
The image source URL or data URI.

##onSourceChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onSourceChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#onsourcechange)

resolution
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Image::resolution = 1</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>1</code></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#resolution)

sourceWidth
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Image::sourceWidth = 0</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#sourcewidth)

sourceHeight
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Image::sourceHeight = 0</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#sourceheight)

offsetX
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Image::offsetX = 0</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#offsetx)

offsetY
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Image::offsetY = 0</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#offsety)

fillMode
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Integer&#x2A; Image::fillMode = 'Stretch'</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd><dt>Default</dt><dd><code>'Stretch'</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#fillmode)

loaded
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; Image::loaded</code></dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#loaded)

##onLoadedChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onLoadedChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#onloadedchange)

onLoad
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onLoad()</code></dd><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#onload)

onError
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onError(&#x2A;Error&#x2A; error)</code></dd><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>error — <i>Error</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/types/image.litcoffee#onerror)

