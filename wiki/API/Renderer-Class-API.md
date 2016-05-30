> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Class**

# Class

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#class)

## Table of contents
* [Class](#class)
* [**Class** Class](#class-class)
  * [New](#new)
  * [name](#name)
  * [onNameChange](#onnamechange)
  * [target](#target)
  * [onTargetChange](#ontargetchange)
  * [changes](#changes)
  * [*Integer* Class::priority = `0`](#integer-classpriority--0)
  * [when](#when)
  * [onWhenChange](#onwhenchange)
  * [children](#children)
    * [*Integer* Class::children.length = `0`](#integer-classchildrenlength--0)
    * [children.append](#childrenappend)
    * [children.pop](#childrenpop)
  * [document](#document)
  * [onDocumentChange](#ondocumentchange)
  * [document.query](#documentquery)
  * [document.onNodeRemove](#documentonnoderemove)
  * [classes](#classes)
  * [onClassesChange](#onclasseschange)
* [Glossary](#glossary)

#*[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* Class
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Class : &#x2A;Renderer.Extension&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Extension-API#class-extension">Renderer.Extension</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#class-class)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Class&#x2A; Class.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#new)

##name
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Class::name</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
This property is used in the [Item](/Neft-io/neft/wiki/Renderer-Item-API#class-item)::classes list
to identify various classes.

##onNameChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Class::onNameChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#onnamechange)

##target
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Class::target</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
Reference to the [Item](/Neft-io/neft/wiki/Renderer-Item-API#class-item) on which this class has effects.

If state is created inside the [Item](/Neft-io/neft/wiki/Renderer-Item-API#class-item), this property is set automatically.

##onTargetChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Class::onTargetChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#ontargetchange)

##changes
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Class::changes</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
This objects contains all properties to change on the target item.

It accepts bindings and listeners as well.

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#changes)

## [Integer](/Neft-io/neft/wiki/Utils-API#isinteger) Class::priority = `0`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) Class::onPriorityChange([Integer](/Neft-io/neft/wiki/Utils-API#isinteger) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#integer-classpriority--0-signal-classonprioritychangeinteger-oldvalue)

##when
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Class::when</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
Indicates whether the class is active or not.

When it's `true`, this state is appended on the
end of the [Item](/Neft-io/neft/wiki/Renderer-Item-API#class-item)::classes list.

Mostly used with bindings.

```javascript
Grid {
    columns: 2
    // reduce to one column if the view width is lower than 500 pixels
    Class {
        when: view.width < 500
        changes: {
            columns: 1
        }
    }
}
```

##onWhenChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Class::onWhenChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#onwhenchange)

##children
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Class::children</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#children)

### [Integer](/Neft-io/neft/wiki/Utils-API#isinteger) Class::children.length = `0`

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#integer-classchildrenlength--0)

###children.append
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Class::children.append(&#x2A;Object&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Parameters</dt><dd><ul><li>value — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#childrenappend)

###children.pop
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Class::children.pop(&#x2A;Integer&#x2A; index)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Parameters</dt><dd><ul><li>index — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#childrenpop)

##document
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Class::document</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#document)

##onDocumentChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Class::onDocumentChange(&#x2A;Object&#x2A; document)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Parameters</dt><dd><ul><li>document — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#ondocumentchange)

##document.query
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Class::document.query</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#documentquery)

##document.onNodeRemove
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Class::document.onNodeRemove(&#x2A;Element&#x2A; node)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Class-API#class-class">Class</a></dd><dt>Parameters</dt><dd><ul><li>node — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#documentonnoderemove)

##classes
<dl><dt>Syntax</dt><dd><code>&#x2A;List&#x2A; Item::classes</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd></dl>
Classes at the end of the list have the highest priority.

This property has a setter, which accepts a string and an array of strings.

##onClassesChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onClassesChange(&#x2A;String&#x2A; added, &#x2A;String&#x2A; removed)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>added — <i>String</i></li><li>removed — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/class.litcoffee#onclasseschange)

# Glossary

- [Class](#class-class)

