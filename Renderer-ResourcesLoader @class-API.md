> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **ResourcesLoader @class**

ResourcesLoader @class
======================

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

## Table of contents
  * [ResourcesLoader.New([component, options])](#resourcesloader-resourcesloadernewcomponent-component-object-options)
  * [ResourcesLoader()](#resourcesloader-resourcesloader)
  * [resources](#resources-resourcesloaderresources)
  * [progress = 0](#float-resourcesloaderprogress--0)

*ResourcesLoader* ResourcesLoader.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])
--------------------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resourcesloader-resourcesloadernewcomponent-component-object-options)

*ResourcesLoader* ResourcesLoader()
-----------------------------------

Access it with:
```nml
ResourcesLoader {}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resourcesloader-resourcesloader)

*Resources* ResourcesLoader::resources
--------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#resources-resourcesloaderresources)

[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) ResourcesLoader::progress = 0
-------------------------------------
## *Signal* ResourcesLoaded::onProgressChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/loader/resources.litcoffee#float-resourcesloaderprogress--0-signal-resourcesloadedonprogresschangefloat-oldvalue)

