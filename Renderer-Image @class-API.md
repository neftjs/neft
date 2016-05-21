> [Wiki](Home) ▸ [API Reference](API-Reference)

Image
<dl><dt>Syntax</dt><dd>Image @class</dd></dl>
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
<dl><dt>Syntax</dt><dd>*Image* Image.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])</dd><dt>Static method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Image</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#image-imagenewcomponent-component-object-options)

Image
<dl><dt>Syntax</dt><dd>*Image* Image() : *Renderer.Item*</dd><dt>Extends</dt><dd><i>Renderer.Item</i></dd><dt>Returns</dt><dd><i>Image</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#image-image--rendereritem)

pixelRatio
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image.pixelRatio = 1</dd><dt>Static property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imagepixelratio--1-signal-imageonpixelratiochangefloat-oldvalue)

width
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::width = -1</dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imagewidth--1)

height
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::height = -1</dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#float-imageheight--1)

source
<dl><dt>Syntax</dt><dd>*String* Image::source</dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
The image source URL or data URI.

##onSourceChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Image::onSourceChange(*String* oldValue)</dd><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonsourcechangestring-oldvalue)

resolution
<dl><dt>Syntax</dt><dd>ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::resolution = 1</dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#readonly-float-imageresolution--1)

sourceWidth
<dl><dt>Syntax</dt><dd>Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::sourceWidth = 0</dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourcewidth--0-hidden-signal-imageonsourcewidthchangefloat-oldvalue)

sourceHeight
<dl><dt>Syntax</dt><dd>Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::sourceHeight = 0</dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourceheight--0-hidden-signal-imageonsourceheightchangefloat-oldvalue)

offsetX
<dl><dt>Syntax</dt><dd>Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::offsetX = 0</dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsetx--0-hidden-signal-imageonoffsetxchangefloat-oldvalue)

offsetY
<dl><dt>Syntax</dt><dd>Hidden [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Image::offsetY = 0</dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsety--0-hidden-signal-imageonoffsetychangefloat-oldvalue)

fillMode
<dl><dt>Syntax</dt><dd>Hidden [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Image::fillMode = 'Stretch'</dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>'Stretch'</code></dd><dt>Hidden</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#hidden-integer-imagefillmode--stretch-hidden-signal-imageonfillmodechangeinteger-oldvalue)

loaded
<dl><dt>Syntax</dt><dd>ReadOnly *Boolean* Image::loaded</dd><dt>Prototype property of</dt><dd><i>Image</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#readonly-boolean-imageloaded)

##onLoadedChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Image::onLoadedChange(*Boolean* oldValue)</dd><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonloadedchangeboolean-oldvalue)

onLoad
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Image::onLoad()</dd><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonload)

onError
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Image::onError(*Error* error)</dd><dt>Prototype method of</dt><dd><i>Image</i></dd><dt>Parameters</dt><dd><ul><li>error — <i>Error</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/types/image.litcoffee#signal-imageonerrorerror-error)

