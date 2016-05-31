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
  * [progress](#progress)
* [Glossary](#glossary)

# **Class** ResourcesLoader

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

##progress
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; ResourcesLoader::progress = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-ResourcesLoader-API#class-resourcesloader">ResourcesLoader</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/loader/resources.litcoffee#progress)

# Glossary

- [ResourcesLoader](#class-resourcesloader)

