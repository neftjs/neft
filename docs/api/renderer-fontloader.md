# FontLoader

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **FontLoader**

<!-- toc -->
Class used to load custom fonts.

You can override default fonts (*sans-serif*, *sans* and *monospace*).

The font weight and the style (italic or normal) is extracted from the font source path.

Access it with:
```javascript
FontLoader {}
```

Example:

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


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/loader/font.litcoffee)


* * * 

### `FontLoader.New()`

<dl><dt>Static method of</dt><dd><i>FontLoader</i></dd><dt>Parameters</dt><dd><ul><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>FontLoader</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/loader/font.litcoffee#fontloader-fontloadernewobject-options)


* * * 

### `name`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/loader/font.litcoffee#string-fontloadername)


* * * 

### `source`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/loader/font.litcoffee#string-fontloadersource)


* * * 

### `loaded`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/loader/font.litcoffee#readonly-boolean-fontloaderloaded--false)


* * * 

### `onLoadedChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/loader/font.litcoffee#signal-fontloaderonloadedchangeboolean-oldvalue)


* * * 

### `onLoad()`

<dl><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/loader/font.litcoffee#signal-fontloaderonload)


* * * 

### `onError()`

<dl><dt>Parameters</dt><dd><ul><li>error — <i>Error</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/loader/font.litcoffee#signal-fontloaderonerrorerror-error)

