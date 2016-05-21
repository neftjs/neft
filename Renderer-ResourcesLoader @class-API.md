> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
ResourcesLoader
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

<dl><dt>Static method of</dt><dd><i>ResourcesLoader</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>ResourcesLoader</i></dd></dl>
New
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resourcesloader-resourcesloadernewcomponent-component-object-options)

<dl><dt>Returns</dt><dd><i>ResourcesLoader</i></dd></dl>
ResourcesLoader
Access it with:
```nml
ResourcesLoader {}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resourcesloader-resourcesloader)

<dl><dt>Prototype property of</dt><dd><i>ResourcesLoader</i></dd><dt>Type</dt><dd><i>Resources</i></dd></dl>
resources
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resources-resourcesloaderresources)

## Table of contents
    * [ResourcesLoader](#resourcesloader)
    * [New](#new)
    * [ResourcesLoader](#resourcesloader)
    * [resources](#resources)
  * [*Float* ResourcesLoader::progress = 0](#float-resourcesloaderprogress--0)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) ResourcesLoader::progress = 0
-------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) ResourcesLoaded::onProgressChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#float-resourcesloaderprogress--0-signal-resourcesloadedonprogresschangefloat-oldvalue)

