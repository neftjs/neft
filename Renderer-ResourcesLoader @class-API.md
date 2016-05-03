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

*ResourcesLoader* ResourcesLoader.New([*Component* component, *Object* options])
--------------------------------------------------------------------------------

*ResourcesLoader* ResourcesLoader()
-----------------------------------

Access it with:
```nml
ResourcesLoader {}
```

*Resources* ResourcesLoader::resources
--------------------------------------

*Float* ResourcesLoader::progress = 0
-------------------------------------

## *Signal* ResourcesLoaded::onProgressChange(*Float* oldValue)

