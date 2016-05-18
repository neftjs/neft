> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Image @class**

Image @class
============

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

## Table of contents
  * [Image.New([component, options])](#image-imagenewcomponent-component-object-options)
  * [Image() : *Renderer.Item*](#image-image--rendereritem)
  * [Image.pixelRatio = 1](#float-imagepixelratio--1)
  * [width = -1](#float-imagewidth--1)
  * [height = -1](#float-imageheight--1)
  * [source](#string-imagesource)
  * [onSourceChange(oldValue)](#signal-imageonsourcechangestring-oldvalue)
  * [resolution = 1](#readonly-float-imageresolution--1)
  * [Hidden sourceWidth = 0](#hidden-float-imagesourcewidth--0)
  * [Hidden sourceHeight = 0](#hidden-float-imagesourceheight--0)
  * [Hidden offsetX = 0](#hidden-float-imageoffsetx--0)
  * [Hidden offsetY = 0](#hidden-float-imageoffsety--0)
  * [Hidden fillMode = 'Stretch'](#hidden-integer-imagefillmode--stretch)
  * [loaded](#readonly-boolean-imageloaded)
  * [onLoadedChange(oldValue)](#signal-imageonloadedchangeboolean-oldvalue)
  * [onLoad()](#signal-imageonload)
  * [onError(error)](#signal-imageonerrorerror-error)

*Image* Image.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])
------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#image-imagenewcomponent-component-object-options)

*Image* Image() : *Renderer.Item*
---------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#image-image--rendereritem)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image.pixelRatio = 1
----------------------------
## *Signal* Image.onPixelRatioChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imagepixelratio--1-signal-imageonpixelratiochangefloat-oldvalue)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::width = -1
-------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imagewidth--1)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::height = -1
--------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imageheight--1)

*String* Image::source
----------------------

The image source URL or data URI.

## *Signal* Image::onSourceChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonsourcechangestring-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::resolution = 1
--------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#readonly-float-imageresolution--1)

Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::sourceWidth = 0
-------------------------------------
## Hidden *Signal* Image::onSourceWidthChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourcewidth--0-hidden-signal-imageonsourcewidthchangefloat-oldvalue)

Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::sourceHeight = 0
--------------------------------------
## Hidden *Signal* Image::onSourceHeightChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourceheight--0-hidden-signal-imageonsourceheightchangefloat-oldvalue)

Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::offsetX = 0
---------------------------------
## Hidden *Signal* Image::onOffsetXChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsetx--0-hidden-signal-imageonoffsetxchangefloat-oldvalue)

Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::offsetY = 0
---------------------------------
## Hidden *Signal* Image::onOffsetYChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsety--0-hidden-signal-imageonoffsetychangefloat-oldvalue)

Hidden [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Image::fillMode = 'Stretch'
--------------------------------------------
## Hidden *Signal* Image::onFillModeChange([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-integer-imagefillmode--stretch-hidden-signal-imageonfillmodechangeinteger-oldvalue)

ReadOnly *Boolean* Image::loaded
--------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#readonly-boolean-imageloaded)

## *Signal* Image::onLoadedChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonloadedchangeboolean-oldvalue)

*Signal* Image::onLoad()
------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonload)

*Signal* Image::onError(*Error* error)
--------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonerrorerror-error)

