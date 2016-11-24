> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Transition**

# Transition

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

> [`Source`](/Neft-io/neft/blob/e63ab3eef69844e97feb0a01be6c69737bc4fbcd/src/renderer/types/extensions/transition.litcoffee)

## Table of contents
* [Transition](#transition)
* [**Class** Transition](#class-transition)
  * [New](#new)
  * [animation](#animation)
  * [onAnimationChange](#onanimationchange)
  * [property](#property)
  * [onPropertyChange](#onpropertychange)
* [Glossary](#glossary)

#**Class** Transition
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Transition : &#x2A;Renderer.Extension&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Extension-API#class-extension">Renderer.Extension</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/e63ab3eef69844e97feb0a01be6c69737bc4fbcd/src/renderer/types/extensions/transition.litcoffee#class-transition--rendererextension)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Transition&#x2A; Transition.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Transition-API#class-transition">Transition</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Transition-API#class-transition">Transition</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/e63ab3eef69844e97feb0a01be6c69737bc4fbcd/src/renderer/types/extensions/transition.litcoffee#transition-transitionnewcomponent-component-object-options)

##animation
<dl><dt>Syntax</dt><dd><code>&#x2A;Animation&#x2A; Transition::animation</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Transition-API#class-transition">Transition</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd></dl>
##onAnimationChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Transition::onAnimationChange(&#x2A;Animation&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Transition-API#class-transition">Transition</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/e63ab3eef69844e97feb0a01be6c69737bc4fbcd/src/renderer/types/extensions/transition.litcoffee#signal-transitiononanimationchangeanimation-oldvalue)

##property
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Transition::property</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Transition-API#class-transition">Transition</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
##onPropertyChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Transition::onPropertyChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Transition-API#class-transition">Transition</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/e63ab3eef69844e97feb0a01be6c69737bc4fbcd/src/renderer/types/extensions/transition.litcoffee#signal-transitiononpropertychangestring-oldvalue)

# Glossary

- [Transition](#class-transition)

