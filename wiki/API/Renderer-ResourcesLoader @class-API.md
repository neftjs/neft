> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]]

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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/resources.litcoffee#resourcesloader)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;ResourcesLoader&#x2A; ResourcesLoader.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>ResourcesLoader</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/Utils-API.md#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>ResourcesLoader</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/resources.litcoffee#new)

ResourcesLoader
<dl><dt>Syntax</dt><dd><code>&#x2A;ResourcesLoader&#x2A; ResourcesLoader()</code></dd><dt>Returns</dt><dd><i>ResourcesLoader</i></dd></dl>
Access it with:
```nml
ResourcesLoader {}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/resources.litcoffee#resourcesloader)

resources
<dl><dt>Syntax</dt><dd><code>&#x2A;Resources&#x2A; ResourcesLoader::resources</code></dd><dt>Prototype property of</dt><dd><i>ResourcesLoader</i></dd><dt>Type</dt><dd><i>Resources</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/resources.litcoffee#resources)

progress
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; ResourcesLoader::progress = 0</code></dd><dt>Prototype property of</dt><dd><i>ResourcesLoader</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/loader/resources.litcoffee#progress)

