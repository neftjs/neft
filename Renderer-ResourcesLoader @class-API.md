> [Wiki](Home) ▸ [API Reference](API-Reference)

ResourcesLoader
<dl><dt>Syntax</dt><dd>ResourcesLoader @class</dd></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resourcesloader-class)

New
<dl><dt>Syntax</dt><dd>*ResourcesLoader* ResourcesLoader.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])</dd><dt>Static method of</dt><dd><i>ResourcesLoader</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>ResourcesLoader</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resourcesloader-resourcesloadernewcomponent-component-object-options)

ResourcesLoader
<dl><dt>Syntax</dt><dd>*ResourcesLoader* ResourcesLoader()</dd><dt>Returns</dt><dd><i>ResourcesLoader</i></dd></dl>
Access it with:
```nml
ResourcesLoader {}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resourcesloader-resourcesloader)

resources
<dl><dt>Syntax</dt><dd>*Resources* ResourcesLoader::resources</dd><dt>Prototype property of</dt><dd><i>ResourcesLoader</i></dd><dt>Type</dt><dd><i>Resources</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resources-resourcesloaderresources)

progress
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) ResourcesLoader::progress = 0</dd><dt>Prototype property of</dt><dd><i>ResourcesLoader</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#float-resourcesloaderprogress--0-signal-resourcesloadedonprogresschangefloat-oldvalue)

