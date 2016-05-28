> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Animation|Renderer-Animation @modifier-API]] ▸ [[PropertyAnimation|Renderer-PropertyAnimation @modifier-API]]

NumberAnimation
<dl><dt>Syntax</dt><dd><code>NumberAnimation @modifier</code></dd></dl>
```nml
`Rectangle {
`   width: 100; height: 100
`   color: 'red'
`   NumberAnimation {
`       running: true
`       property: 'x'
`       from: 0
`       to: 300
`       loop: true
`       duration: 1700
`   }
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property/types/number.litcoffee#numberanimation)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;NumberAnimation&#x2A; NumberAnimation.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>NumberAnimation</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/Utils-API.md#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>NumberAnimation</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property/types/number.litcoffee#new)

NumberAnimation
<dl><dt>Syntax</dt><dd><code>&#x2A;NumberAnimation&#x2A; NumberAnimation() : &#x2A;Renderer.PropertyAnimation&#x2A;</code></dd><dt>Extends</dt><dd><i>Renderer.PropertyAnimation</i></dd><dt>Returns</dt><dd><i>NumberAnimation</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property/types/number.litcoffee#numberanimation)

from
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; NumberAnimation::from</code></dd><dt>Prototype property of</dt><dd><i>NumberAnimation</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd></dl>
