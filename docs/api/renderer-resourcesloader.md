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


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/loader/resources.litcoffee)


* * * 

### `ResourcesLoader.New()`

<dl><dt>Static method of</dt><dd><i>ResourcesLoader</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>ResourcesLoader</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/loader/resources.litcoffee#resourcesloader-resourcesloadernewcomponent-component-object-options)


* * * 

### `resources`

<dl><dt>Type</dt><dd><i>Resources</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/loader/resources.litcoffee#resources-resourcesloaderresources)


* * * 

### `progress`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onProgressChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/renderer/types/loader/resources.litcoffee#signal-resourcesloadedonprogresschangefloat-oldvalue)

