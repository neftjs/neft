> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **Image**

# Image

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

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#image)

## Table of contents
* [Image](#image)
* [**Class** Image](#class-image)
  * [New](#new)
  * [*Float* Image.pixelRatio = `1`](#float-imagepixelratio--1)
  * [*Float* Image::width = `-1`](#float-imagewidth--1)
  * [*Float* Image::height = `-1`](#float-imageheight--1)
  * [source](#source)
  * [onSourceChange](#onsourcechange)
  * [ReadOnly *Float* Image::resolution = `1`](#readonly-float-imageresolution--1)
  * [Hidden *Float* Image::sourceWidth = `0`](#hidden-float-imagesourcewidth--0)
  * [Hidden *Float* Image::sourceHeight = `0`](#hidden-float-imagesourceheight--0)
  * [Hidden *Float* Image::offsetX = `0`](#hidden-float-imageoffsetx--0)
  * [Hidden *Float* Image::offsetY = `0`](#hidden-float-imageoffsety--0)
  * [Hidden *Integer* Image::fillMode = `'Stretch'`](#hidden-integer-imagefillmode--stretch)
  * [ReadOnly *Boolean* Image::loaded = `false`](#readonly-boolean-imageloaded--false)
  * [onLoadedChange](#onloadedchange)
  * [onLoad](#onload)
  * [onError](#onerror)
* [Glossary](#glossary)

#**Class** Image
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Image : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#class-image)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Image&#x2A; Image.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#new)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Image.pixelRatio = `1`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Image.onPixelRatioChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#float-imagepixelratio--1-signal-imageonpixelratiochangefloat-oldvalue)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Image::width = `-1`

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#float-imagewidth--1)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Image::height = `-1`

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#float-imageheight--1)

##source
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Image::source</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
The image source URL or data URI.

##onSourceChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onSourceChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#onsourcechange)

## ReadOnly [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Image::resolution = `1`

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#readonly-float-imageresolution--1)

## Hidden [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Image::sourceWidth = `0`

## Hidden [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Image::onSourceWidthChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourcewidth--0-hidden-signal-imageonsourcewidthchangefloat-oldvalue)

## Hidden [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Image::sourceHeight = `0`

## Hidden [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Image::onSourceHeightChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imagesourceheight--0-hidden-signal-imageonsourceheightchangefloat-oldvalue)

## Hidden [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Image::offsetX = `0`

## Hidden [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Image::onOffsetXChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsetx--0-hidden-signal-imageonoffsetxchangefloat-oldvalue)

## Hidden [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Image::offsetY = `0`

## Hidden [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Image::onOffsetYChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#hidden-float-imageoffsety--0-hidden-signal-imageonoffsetychangefloat-oldvalue)

## Hidden [Integer](/Neft-io/neft/wiki/Utils-API#isinteger) Image::fillMode = `'Stretch'`

## Hidden [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Image::onFillModeChange([Integer](/Neft-io/neft/wiki/Utils-API#isinteger) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#hidden-integer-imagefillmode--stretch-hidden-signal-imageonfillmodechangeinteger-oldvalue)

## ReadOnly *Boolean* Image::loaded = `false`

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#readonly-boolean-imageloaded--false)

##onLoadedChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onLoadedChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#onloadedchange)

##onLoad
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onLoad()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#onload)

##onError
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onError(&#x2A;Error&#x2A; error)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Parameters</dt><dd><ul><li>error — <i>Error</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#onerror)

# Glossary

- [Image](#class-image)

