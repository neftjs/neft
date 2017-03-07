# Class

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Class**

<!-- toc -->

> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee)


* * * 

### `Class.New()`

<dl><dt>Static method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Renderer.Class</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#rendererclass-classnewobject-options)


* * * 

### `constructor()`

<dl><dt>Extends</dt><dd><i>Renderer.Extension</i></dd><dt>Returns</dt><dd><i>Class</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#class-classconstructor--rendererextension)


* * * 

### `name`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>

This property is used in the *Item*::classes list
to identify various classes.


* * * 

### `onNameChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#signal-classonnamechangestring-oldvalue)


* * * 

### `target`

<dl><dt>Type</dt><dd><i>Item</i></dd></dl>

Reference to the *Item* on which this class has effects.

If state is created inside the *Item*, this property is set automatically.


* * * 

### `onTargetChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#signal-classontargetchangeitem-oldvalue)


* * * 

### `changes`

<dl><dt>Type</dt><dd><i>Object</i></dd></dl>

This objects contains all properties to change on the target item.

It accepts bindings and listeners as well.


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#object-classchanges)


* * * 

### `priority`

<dl><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onPriorityChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Integer</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#signal-classonprioritychangeinteger-oldvalue)


* * * 

### `when`

<dl><dt>Type</dt><dd><i>Boolean</i></dd></dl>

Indicates whether the class is active or not.

When it's `true`, this state is appended on the
end of the *Item*::classes list.

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


* * * 

### `onWhenChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#signal-classonwhenchangeboolean-oldvalue)


* * * 

### `children`

<dl><dt>Type</dt><dd><i>Object</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#object-classchildren)


* * * 

### `children.length`

<dl><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#integer-classchildrenlength--0)


* * * 

### `children.append()`

<dl><dt>Parameters</dt><dd><ul><li>value — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#object-classchildrenappendobject-value)


* * * 

### `children.pop()`

<dl><dt>Parameters</dt><dd><ul><li>index — <i>Integer</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#object-classchildrenpopinteger-index)


* * * 

### `document`

<dl><dt>Type</dt><dd><i>Object</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#object-classdocument)


* * * 

### `onDocumentChange()`

<dl><dt>Parameters</dt><dd><ul><li>document — <i>Object</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#signal-classondocumentchangeobject-document)


* * * 

### `document.onNodeAdd()`

<dl><dt>Parameters</dt><dd><ul><li>node — <i>Element</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#signal-classdocumentonnodeaddelement-node)


* * * 

### `document.onNodeRemove()`

<dl><dt>Parameters</dt><dd><ul><li>node — <i>Element</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#signal-classdocumentonnoderemoveelement-node)


* * * 

### `document.query`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>


* * * 

### `document.onQueryChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#signal-classdocumentonquerychangestring-oldvalue)


* * * 

### `classes`

<dl><dt>Type</dt><dd><i>List</i></dd></dl>

Classes at the end of the list have the highest priority.

This property has a setter, which accepts a string and an array of strings.


* * * 

### `onClassesChange()`

<dl><dt>Parameters</dt><dd><ul><li>added — <i>String</i></li><li>removed — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/extensions/class.litcoffee#signal-itemonclasseschangestring-added-string-removed)

