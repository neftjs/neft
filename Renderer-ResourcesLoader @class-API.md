> [Wiki](Home) ▸ [API Reference](API-Reference)

ResourcesLoader
<dl></dl>
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
<dl><dt>Static method of</dt><dd><i>ResourcesLoader</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>ResourcesLoader</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resourcesloader-resourcesloadernewcomponent-component-object-options)

ResourcesLoader
<dl><dt>Returns</dt><dd><i>ResourcesLoader</i></dd></dl>
Access it with:
```nml
ResourcesLoader {}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resourcesloader-resourcesloader)

resources
<dl><dt>Prototype property of</dt><dd><i>ResourcesLoader</i></dd><dt>Type</dt><dd><i>Resources</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resources-resourcesloaderresources)

progress
<dl><dt>Prototype property of</dt><dd><i>ResourcesLoader</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#float-resourcesloaderprogress--0-signal-resourcesloadedonprogresschangefloat-oldvalue)

