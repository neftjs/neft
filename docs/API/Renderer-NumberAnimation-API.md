> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Animation|Renderer-Animation-API]] ▸ [[PropertyAnimation|Renderer-PropertyAnimation-API]] ▸ **NumberAnimation**

# NumberAnimation

```javascript
Rectangle {
    width: 100; height: 100
    color: 'red'
    NumberAnimation {
        running: true
        property: 'x'
        from: 0
        to: 300
        loop: true
        duration: 1700
    }
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property/types/number.litcoffee)

## Table of contents
* [NumberAnimation](#numberanimation)
* [**Class** NumberAnimation](#class-numberanimation)
  * [New](#new)
  * [from](#from)
  * [to](#to)
* [Glossary](#glossary)

#**Class** NumberAnimation
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; NumberAnimation : &#x2A;PropertyAnimation&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property/types/number.litcoffee#class-numberanimation--propertyanimation)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;NumberAnimation&#x2A; NumberAnimation.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-NumberAnimation-API#class-numberanimation">NumberAnimation</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-NumberAnimation-API#class-numberanimation">NumberAnimation</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property/types/number.litcoffee#numberanimation-numberanimationnewcomponent-component-object-options)

##from
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; NumberAnimation::from</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-NumberAnimation-API#class-numberanimation">NumberAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd></dl>
##to
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; NumberAnimation::to</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-NumberAnimation-API#class-numberanimation">NumberAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd></dl>
# Glossary

- [NumberAnimation](#class-numberanimation)
