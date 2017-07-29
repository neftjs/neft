# Styles

Styles are used to:
- draw shapes and texts on a screen,
- support user actions like mouse clicks, taps, keyboard events,
- organize elements in a hierarchical structure,
- do animations.

Styles are connected and synchronized with [views](/views.html). You can style any *XHTML* [element](/api/document-element.html).

Styles in views needs to be placed inside `<style></style>` tag.

## NML

Neft uses his own language for styles. It's called NML - *Neft Marked Language*.

Neft styles compared to *CSS* are:
- type based (different types have different properties),
- object-oriented (e.g. [Animation](/styles/animations.html) is a child),
- independent (items don't have to be connected to a [view](/views.html) or [Virtual DOM](/views/virtual-dom.html)),
- fully dynamic (scripted in *JavaScript* with auto-binding).

## Syntax

Look at example below to understand the syntax:

```xhtml
<style>
Item {
    x: 50
    width: 100
    // comment
}
</style>
```

- `Item` - name of a type to use; [`Item`](/api/renderer-item.html) is a base class for all visual types,
- `x` - left position in pixels,
- `width` - width in pixels.

## Scripting

Properties can contains *JavaScript* code.

```xhtml
<style>
Item {
    x: 50
    width: this.x * 2
    // width is equal 50
    rotation: Math.PI / 4
}
</style>
```

`width` property is *auto-bounded* to the `x` property. It means, `width` value will be automatically updated on each `x` property change.

## Shapes

To draw a rectangle, use [`Rectangle`](/api/renderer-rectangle.html) item.

It extends [`Item`](/api/renderer-item.html).

```xhtml
<style>
Rectangle {
    width: 50
    height: 50
    color: 'red'
}
</style>
```

## Children

[`Item`](/api/renderer-item.html) can contains children.

Their position is relative to parent.

Parent element is available in properties as `this.parent` or just `parent`.

```xhtml
<style>
Rectangle {
    width: 50
    height: 50
    color: 'red'

    Rectangle {
        width: this.parent.width / 2
        // width is equal 25
        height: 10
        color: 'green'
    }
}
</style>
```

## ids

Each element can has a unique *id*.

It's used to reference this item from other places.

```xhtml
<style>
Item {
    Item {
        id: firstItem
        x: 10
    }

    Item {
        x: firstItem.x
        // x is equal 10
    }
}
</style>
```

## Signal handlers

[`Item`](/api/renderer-item.html) produces signals on properties change (e.g. `onWidthChange`) or user events (e.g. `pointer.onClick`).

You can create *JavaScript* function directly in *NML*.

```xhtml
<style>
Rectangle {
    query: 'button'
    pointer.onClick: function (event) {
        console.log(event.x);
    }
}
</style>
<button />
```

## Native Items

Neft has some built-in native elements.

You can access them using the [native-items](/extensions/native-items.html) extension.

*NML* allows to write *JavaScript* code before types. You need to wrap it in back-ticks like in *Markdown*.

```xhtml
<style>
`
const NativeItems = require('extensions/native-items');
`
NativeItems.Button {
    query: 'button'
}
</style>
<button>Click here</button>
```
