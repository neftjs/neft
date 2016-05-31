> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Screen**

# Screen

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/screen.litcoffee#screen)

## Table of contents
* [Screen](#screen)
  * [touch](#touch)
  * [width](#width)
  * [height](#height)
  * [orientation](#orientation)
  * [onOrientationChange](#onorientationchange)
* [Glossary](#glossary)

##touch
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; Screen.touch = `false`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Screen-API#screen">Screen</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd><dt>Read Only</dt></dl>
```javascript
Text {
    text: Screen.touch ? 'Touch' : 'Mouse'
    font.pixelSize: 30
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/screen.litcoffee#touch)

##width
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Screen.width = `1024`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Screen-API#screen">Screen</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>1024</code></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/screen.litcoffee#width)

##height
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; Screen.height = `800`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Screen-API#screen">Screen</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>800</code></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/screen.litcoffee#height)

##orientation
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Screen.orientation = `'Portrait'`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Screen-API#screen">Screen</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'Portrait'</code></dd><dt>Read Only</dt></dl>
May contains: Portrait, Landscape, InvertedPortrait, InvertedLandscape.

##onOrientationChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Screen.onOrientationChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Screen-API#screen">Screen</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/screen.litcoffee#onorientationchange)

# Glossary

- [Screen](#screen)

