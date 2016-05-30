> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **FontLoader**

# FontLoader

```javascript
Item {
    Text {
        font.family: 'myFont'
        text: 'Cool font!'
    }
}
FontLoader {
    name: 'myFont'
    source: 'rsc:/static/fonts/myFont'
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/loader/font.litcoffee#fontloader)

## Table of contents
* [FontLoader](#fontloader)
* [**Class** FontLoader](#class-fontloader)
  * [New](#new)
  * [name](#name)
  * [source](#source)
* [Glossary](#glossary)

# *[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* FontLoader

Class used to load custom fonts.

You can override default fonts (*sans-serif*, *sans* and *monospace*).

The font weight and the style (italic or normal) is extracted from the font source path.

Access it with:
```javascript
FontLoader {}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/loader/font.litcoffee#class-fontloader)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;FontLoader&#x2A; FontLoader.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-FontLoader-API#class-fontloader">FontLoader</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-FontLoader-API#class-fontloader">FontLoader</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/loader/font.litcoffee#new)

##name
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; FontLoader::name</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-FontLoader-API#class-fontloader">FontLoader</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/loader/font.litcoffee#name)

##source
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; FontLoader::source</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-FontLoader-API#class-fontloader">FontLoader</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
We recommend using **WOFF** format and **TTF/OTF** for the oldest Android browser.

Must contains one of:
 - hairline *(weight=0)*,
 - thin,
 - ultra.*light,
 - extra.*light,
 - light,
 - book,
 - normal|regular|roman|plain,
 - medium,
 - demi.*bold|semi.*bold,
 - bold,
 - extra.*bold|extra,
 - heavy,
 - black,
 - extra.*black,
 - ultra.*black|ultra *(weight=1)*.

Italic font filename must contains 'italic'.

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/loader/font.litcoffee#source)

# Glossary

- [FontLoader](#class-fontloader)

