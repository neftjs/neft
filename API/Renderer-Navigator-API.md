> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Navigator**

# Navigator

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/navigator.litcoffee#navigator)

## Table of contents
* [Navigator](#navigator)
  * [*Boolean* Navigator.language = `'en'`](#boolean-navigatorlanguage--en)
  * [*Boolean* Navigator.browser = `true`](#boolean-navigatorbrowser--true)
  * [*Boolean* Navigator.native = `false`](#boolean-navigatornative--false)
  * [*Boolean* Navigator.online = `true`](#boolean-navigatoronline--true)
* [Glossary](#glossary)

## *Boolean* Navigator.language = `'en'`

```javascript
Text {
    text: 'Your language: ' + Navigator.language
    font.pixelSize: 30
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorlanguage--en)

## *Boolean* Navigator.browser = `true`

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatorbrowser--true)

## *Boolean* Navigator.native = `false`

```javascript
Text {
    text: Navigator.native ? 'Native' : 'Browser'
    font.pixelSize: 30
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatornative--false)

## *Boolean* Navigator.online = `true`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Navigator.onOnlineChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/navigator.litcoffee#boolean-navigatoronline--true-signal-navigatorononlinechangeboolean-oldvalue)

# Glossary

- [Navigator](#navigator)

