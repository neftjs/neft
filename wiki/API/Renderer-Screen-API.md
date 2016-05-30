> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Screen**

# Screen

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/screen.litcoffee#screen)

## Table of contents
* [Screen](#screen)
  * [ReadOnly *Boolean* Screen.touch = `false`](#readonly-boolean-screentouch--false)
  * [ReadOnly *Float* Screen.width = `1024`](#readonly-float-screenwidth--1024)
  * [ReadOnly *Float* Screen.height = `800`](#readonly-float-screenheight--800)
  * [ReadOnly *String* Screen.orientation = `'Portrait'`](#readonly-string-screenorientation--portrait)
  * [onOrientationChange](#onorientationchange)
* [Glossary](#glossary)

## ReadOnly *Boolean* Screen.touch = `false`

```javascript
Text {
    text: Screen.touch ? 'Touch' : 'Mouse'
    font.pixelSize: 30
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/screen.litcoffee#readonly-boolean-screentouch--false)

## ReadOnly [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Screen.width = `1024`

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/screen.litcoffee#readonly-float-screenwidth--1024)

## ReadOnly [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Screen.height = `800`

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/screen.litcoffee#readonly-float-screenheight--800)

## ReadOnly *String* Screen.orientation = `'Portrait'`

May contains: Portrait, Landscape, InvertedPortrait, InvertedLandscape.

##onOrientationChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Screen.onOrientationChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Screen-API#screen">Screen</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/screen.litcoffee#onorientationchange)

# Glossary

- [Screen](#screen)

