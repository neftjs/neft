> [Wiki](Home) ▸ [API Reference](API-Reference)

Image
<dl></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#image-class)

New
<dl><dt>Static method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Image</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#image-imagenewcomponent-component-object-options)

Image
<dl><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Image</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#image-image--rendereritem)

pixelRatio
<dl><dt>Static property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imagepixelratio--1-signal-imageonpixelratiochangefloat-oldvalue)

width
<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imagewidth--1)

height
<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imageheight--1)

source
<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
The image source URL or data URI.

## Table of contents
    * [Image](#image)
    * [New](#new)
    * [Image](#image)
    * [pixelRatio](#pixelratio)
    * [width](#width)
    * [height](#height)
    * [source](#source)
  * [onSourceChange](#onsourcechange)
    * [resolution](#resolution)
    * [sourceWidth](#sourcewidth)
    * [sourceHeight](#sourceheight)
    * [offsetX](#offsetx)
    * [offsetY](#offsety)
    * [fillMode](#fillmode)
    * [loaded](#loaded)
  * [onLoadedChange](#onloadedchange)
    * [onLoad](#onload)
    * [onError](#onerror)

##onSourceChange
<dl><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonsourcechangestring-oldvalue)

resolution
<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#readonly-float-imageresolution--1)

sourceWidth
<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourcewidth--0-hidden-signal-imageonsourcewidthchangefloat-oldvalue)

sourceHeight
<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourceheight--0-hidden-signal-imageonsourceheightchangefloat-oldvalue)

offsetX
<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsetx--0-hidden-signal-imageonoffsetxchangefloat-oldvalue)

offsetY
<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsety--0-hidden-signal-imageonoffsetychangefloat-oldvalue)

fillMode
<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>'Stretch'</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-integer-imagefillmode--stretch-hidden-signal-imageonfillmodechangeinteger-oldvalue)

loaded
<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#readonly-boolean-imageloaded)

##onLoadedChange
<dl><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonloadedchangeboolean-oldvalue)

onLoad
<dl><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonload)

onError
<dl><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>error — <i>Error</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonerrorerror-error)

