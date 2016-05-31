> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Navigator**

# Navigator

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/navigator.litcoffee#navigator)

## Table of contents
* [Navigator](#navigator)
  * [language](#language)
  * [browser](#browser)
  * [native](#native)
  * [online](#online)
* [Glossary](#glossary)

##language
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Navigator.language = `'en'`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Navigator-API#navigator">Navigator</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>'en'</code></dd></dl>
```javascript
Text {
    text: 'Your language: ' + Navigator.language
    font.pixelSize: 30
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/navigator.litcoffee#language)

##browser
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Navigator.browser = `true`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Navigator-API#navigator">Navigator</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/navigator.litcoffee#browser)

##native
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Navigator.native = `false`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Navigator-API#navigator">Navigator</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
```javascript
Text {
    text: Navigator.native ? 'Native' : 'Browser'
    font.pixelSize: 30
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/navigator.litcoffee#native)

##online
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Navigator.online = `true`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Navigator-API#navigator">Navigator</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/navigator.litcoffee#online)

# Glossary

- [Navigator](#navigator)

