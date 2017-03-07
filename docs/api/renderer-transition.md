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


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/transition.litcoffee)


* * * 

### `Transition.New()`

<dl><dt>Static method of</dt><dd><i>Transition</i></dd><dt>Parameters</dt><dd><ul><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Transition</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/transition.litcoffee#transition-transitionnewobject-options)


* * * 

### `constructor()`

<dl><dt>Extends</dt><dd><i>Renderer.Extension</i></dd><dt>Returns</dt><dd><i>Transition</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/transition.litcoffee#transition-transitionconstructor--rendererextension)


* * * 

### `animation`

<dl><dt>Type</dt><dd><i>Animation</i></dd></dl>


* * * 

### `onAnimationChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Animation</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/transition.litcoffee#signal-transitiononanimationchangeanimation-oldvalue)


* * * 

### `property`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>


* * * 

### `onPropertyChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/transition.litcoffee#signal-transitiononpropertychangestring-oldvalue)

