> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Image
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

<dl><dt>Static method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Image</i></dd></dl>
New
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#image-imagenewcomponent-component-object-options)

<dl><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Image</i></dd></dl>
Image
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#image-image--rendereritem)

<dl><dt>Static property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>
pixelRatio
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imagepixelratio--1-signal-imageonpixelratiochangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
width
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imagewidth--1)

<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
height
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imageheight--1)

<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
source
The image source URL or data URI.

<dl><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
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
  * [Hidden *Float* Image::offsetY = 0](#hidden-float-imageoffsety--0)
  * [Hidden *Integer* Image::fillMode = 'Stretch'](#hidden-integer-imagefillmode--stretch)
  * [ReadOnly *Boolean* Image::loaded](#readonly-boolean-imageloaded)
  * [*Signal* Image::onLoadedChange(*Boolean* oldValue)](#signal-imageonloadedchangeboolean-oldvalue)
  * [*Signal* Image::onLoad()](#signal-imageonload)
  * [*Signal* Image::onError(*Error* error)](#signal-imageonerrorerror-error)

##onSourceChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonsourcechangestring-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd><dt>read only</dt></dl>
resolution
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#readonly-float-imageresolution--1)

<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>hidden</dt></dl>
sourceWidth
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourcewidth--0-hidden-signal-imageonsourcewidthchangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>hidden</dt></dl>
sourceHeight
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourceheight--0-hidden-signal-imageonsourceheightchangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>hidden</dt></dl>
offsetX
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsetx--0-hidden-signal-imageonoffsetxchangefloat-oldvalue)

Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::offsetY = 0
---------------------------------
## Hidden [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Image::onOffsetYChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsety--0-hidden-signal-imageonoffsetychangefloat-oldvalue)

Hidden [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Image::fillMode = 'Stretch'
--------------------------------------------
## Hidden [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Image::onFillModeChange([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-integer-imagefillmode--stretch-hidden-signal-imageonfillmodechangeinteger-oldvalue)

ReadOnly *Boolean* Image::loaded
--------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#readonly-boolean-imageloaded)

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Image::onLoadedChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonloadedchangeboolean-oldvalue)

[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Image::onLoad()
------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonload)

[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Image::onError(*Error* error)
--------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonerrorerror-error)

