> [Wiki](Home) ▸ [API Reference](API-Reference)

ResourcesLoader
<dl><dt>Syntax</dt><dd><code>ResourcesLoader @class</code></dd></dl>
```nml
`Item {
`   ResourcesLoader {
`       id: loader
`       resources: app.resources
`   }
`
`   Text {
`       text: 'Progress: ' + loader.progress * 100 + '%'
`   }
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/resources.litcoffee#resourcesloader-class)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;ResourcesLoader&#x2A; ResourcesLoader.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>ResourcesLoader</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>ResourcesLoader</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/resources.litcoffee#resourcesloader-resourcesloadernewcomponent-component-object-options)

ResourcesLoader
<dl><dt>Syntax</dt><dd><code>&#x2A;ResourcesLoader&#x2A; ResourcesLoader()</code></dd><dt>Returns</dt><dd><i>ResourcesLoader</i></dd></dl>
Access it with:
```nml
ResourcesLoader {}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/resources.litcoffee#resourcesloader-resourcesloader)

resources
<dl><dt>Syntax</dt><dd><code>&#x2A;Resources&#x2A; ResourcesLoader::resources</code></dd><dt>Prototype property of</dt><dd><i>ResourcesLoader</i></dd><dt>Type</dt><dd><i>Resources</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/resources.litcoffee#resources-resourcesloaderresources)

progress
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; ResourcesLoader::progress = 0</code></dd><dt>Prototype property of</dt><dd><i>ResourcesLoader</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/resources.litcoffee#float-resourcesloaderprogress--0-signal-resourcesloadedonprogresschangefloat-oldvalue)

