# ResourcesLoader

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **ResourcesLoader**

<!-- toc -->
Access it with:
```javascript
ResourcesLoader {}
```

Example:

```javascript
Item {
    ResourcesLoader {
        id: loader
        resources: app.resources
    }
    Text {
        text: 'Progress: ' + loader.progress * 100 + '%'
    }
}
```


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/loader/resources.litcoffee)


* * * 

### `ResourcesLoader.New()`

<dl><dt>Static method of</dt><dd><i>ResourcesLoader</i></dd><dt>Parameters</dt><dd><ul><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>ResourcesLoader</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/loader/resources.litcoffee#resourcesloader-resourcesloadernewobject-options)


* * * 

### `resources`

<dl><dt>Type</dt><dd><i>Resources</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/loader/resources.litcoffee#resources-resourcesloaderresources)


* * * 

### `progress`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>Read Only</dt></dl>


* * * 

### `onProgressChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/87bb31fdac5741b735a2e67422e1d7db01196e62/src/renderer/types/loader/resources.litcoffee#signal-resourcesloadedonprogresschangefloat-oldvalue)

