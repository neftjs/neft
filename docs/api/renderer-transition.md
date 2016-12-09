# Transition

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Transition**

<!-- toc -->
```javascript
Rectangle {
    width: 100; height: 100;
    color: 'red'
    pointer.onClick: function () {
        this.x = Math.random() * 300;
    }
    Transition {
        property: 'x'
        animation: NumberAnimation {
            duration: 1500
        }
    }
}
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/extensions/transition.litcoffee)


* * * 

### `Transition.New()`

<dl><dt>Static method of</dt><dd><i>Transition</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Transition</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/extensions/transition.litcoffee#transition-transitionnewcomponent-component-object-options)


* * * 

### `constructor()`

<dl><dt>Extends</dt><dd><i>Renderer.Extension</i></dd><dt>Returns</dt><dd><i>Transition</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/extensions/transition.litcoffee#transition-transitionconstructor--rendererextension)


* * * 

### `animation`

<dl><dt>Type</dt><dd><i>Animation</i></dd></dl>


* * * 

### `onAnimationChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Animation</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/extensions/transition.litcoffee#signal-transitiononanimationchangeanimation-oldvalue)


* * * 

### `property`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>


* * * 

### `onPropertyChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/extensions/transition.litcoffee#signal-transitiononpropertychangestring-oldvalue)

