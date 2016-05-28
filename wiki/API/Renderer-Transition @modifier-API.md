> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]]

Transition
<dl><dt>Syntax</dt><dd><code>Transition @modifier</code></dd></dl>
```nml
`Rectangle {
`   width: 100; height: 100;
`   color: 'red'
`   pointer.onClick: function(){
`       this.x = Math.random()*300;
`   }
`
`   Transition {
`       property: 'x'
`       animation: NumberAnimation {
`           duration: 1500
`       }
`   }
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/transition.litcoffee#transition)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;Transition&#x2A; Transition.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>Transition</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Transition</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/transition.litcoffee#new)

Transition
<dl><dt>Syntax</dt><dd><code>&#x2A;Transition&#x2A; Transition()</code></dd><dt>Returns</dt><dd><i>Transition</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/transition.litcoffee#transition)

when
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Transition::when</code></dd><dt>Prototype property of</dt><dd><i>Transition</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/transition.litcoffee#when)

animation
<dl><dt>Syntax</dt><dd><code>&#x2A;Renderer.Animation&#x2A; Transition::animation</code></dd><dt>Prototype property of</dt><dd><i>Transition</i></dd><dt>Type</dt><dd><i>Renderer.Animation</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/transition.litcoffee#animation)

property
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Transition::property</code></dd><dt>Prototype property of</dt><dd><i>Transition</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/transition.litcoffee#property)

