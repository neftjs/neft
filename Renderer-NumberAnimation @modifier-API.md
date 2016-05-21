> [Wiki](Home) ▸ [API Reference](API-Reference)

NumberAnimation
<dl><dt>Syntax</dt><dd>NumberAnimation @modifier</dd></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property/types/number.litcoffee#numberanimation-modifier)

New
<dl><dt>Syntax</dt><dd>*NumberAnimation* NumberAnimation.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])</dd><dt>Static method of</dt><dd><i>NumberAnimation</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>NumberAnimation</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property/types/number.litcoffee#numberanimation-numberanimationnewcomponent-component-object-options)

NumberAnimation
<dl><dt>Syntax</dt><dd>*NumberAnimation* NumberAnimation() : *Renderer.PropertyAnimation*</dd><dt>Extends</dt><dd><i>Renderer.PropertyAnimation</i></dd><dt>Returns</dt><dd><i>NumberAnimation</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property/types/number.litcoffee#numberanimation-numberanimation--rendererpropertyanimation)

from
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) NumberAnimation::from</dd><dt>Prototype property of</dt><dd><i>NumberAnimation</i></dd><dt>Type</dt><dd><i>Float</i></dd></dl>
