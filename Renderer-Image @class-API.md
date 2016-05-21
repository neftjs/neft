> [Wiki](Home) ▸ [API Reference](API-Reference)

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

New
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#image-imagenewcomponent-component-object-options)

Image
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#image-image--rendereritem)

pixelRatio
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imagepixelratio--1-signal-imageonpixelratiochangefloat-oldvalue)

width
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imagewidth--1)

height
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imageheight--1)

source
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
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonsourcechangestring-oldvalue)

resolution
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#readonly-float-imageresolution--1)

sourceWidth
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourcewidth--0-hidden-signal-imageonsourcewidthchangefloat-oldvalue)

sourceHeight
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourceheight--0-hidden-signal-imageonsourceheightchangefloat-oldvalue)

offsetX
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsetx--0-hidden-signal-imageonoffsetxchangefloat-oldvalue)

offsetY
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsety--0-hidden-signal-imageonoffsetychangefloat-oldvalue)

fillMode
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-integer-imagefillmode--stretch-hidden-signal-imageonfillmodechangeinteger-oldvalue)

loaded
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#readonly-boolean-imageloaded)

##onLoadedChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonloadedchangeboolean-oldvalue)

onLoad
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonload)

onError
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonerrorerror-error)

