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
* [Glossary](#glossary)

#**Class** Image
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Image : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#class-image)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Image&#x2A; Image.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#new)

##pixelRatio
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Image.pixelRatio = `1`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>1</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#pixelratio)

##width
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Image::width = `-1`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#width)

##height
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Image::height = `-1`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>-1</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#height)

##source
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Image::source</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
The image source URL or data URI.

##onSourceChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Image::onSourceChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#onsourcechange)

##resolution
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Image::resolution = `1`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>1</code></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#resolution)

##sourceWidth
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Image::sourceWidth = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#sourcewidth)

##sourceHeight
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Image::sourceHeight = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#sourceheight)

##offsetX
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Image::offsetX = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#offsetx)

##offsetY
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Float&#x2A; Image::offsetY = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#offsety)

##fillMode
<dl><dt>Syntax</dt><dd><code>Hidden &#x2A;Integer&#x2A; Image::fillMode = `'Stretch'`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd><dt>Default</dt><dd><code>'Stretch'</code></dd><dt>Not Implemented</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#fillmode)

##loaded
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; Image::loaded = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Image-API#class-image">Image</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/types/image.litcoffee#loaded)

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

