> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **ResourcesLoader**

# ResourcesLoader

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

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/loader/resources.litcoffee#resourcesloader)

## Table of contents
* [ResourcesLoader](#resourcesloader)
* [**Class** ResourcesLoader](#class-resourcesloader)
  * [New](#new)
  * [resources](#resources)
  * [*Float* ResourcesLoader::progress = `0`](#float-resourcesloaderprogress--0)
* [Glossary](#glossary)

# *[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* ResourcesLoader

Access it with:
```javascript
ResourcesLoader {}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/loader/resources.litcoffee#class-resourcesloader)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;ResourcesLoader&#x2A; ResourcesLoader.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-ResourcesLoader-API#class-resourcesloader">ResourcesLoader</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-ResourcesLoader-API#class-resourcesloader">ResourcesLoader</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/loader/resources.litcoffee#new)

##resources
<dl><dt>Syntax</dt><dd><code>&#x2A;Resources&#x2A; ResourcesLoader::resources</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-ResourcesLoader-API#class-resourcesloader">ResourcesLoader</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Resources-API#class-resources">Resources</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/loader/resources.litcoffee#resources)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) ResourcesLoader::progress = `0`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) ResourcesLoaded::onProgressChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/loader/resources.litcoffee#float-resourcesloaderprogress--0-signal-resourcesloadedonprogresschangefloat-oldvalue)

# Glossary

- [ResourcesLoader](#class-resourcesloader)

