> [Wiki](Home) ▸ [[Tour]] ▸ **Styles**

Styles
===

Neft uses his own simply language to describe how the elements looks like, therefore styles in Neft can be well organized and more dynamic (JavaScript support, views data-binding etc.).

All style files must be placed in the `/styles` folder.

The main style is named `view.js`.

## NML syntax

```javascript
TypeName {
    id: optionalItemId
    property: 'value' // comment
    namespace.property: 'value'
    onEvent: function(){
    }

    // children
    TypeName {

    }
}
```

`TypeName` is a class name provided by Neft: an Item, Column, Rectangle, FontLoader and more. `TypeName` can be also a reference to your custom style.

`id` is optional and it's used for data-binding and to describe the top object.

## Base item

All visible types in Neft extends the `Item` type.

It contains various properties (e.g. `x`, `y`, `scale`, `width`, `nextSibling`), `keys` and `pointer` support, `children` array and more. Check later the API Reference for the `Renderer` module.

```javascript
Item {
    width: 100
    height: 100
    scale: Math.PI / 2
}
```

## Style file

Style file can contains custom JavaScript code and top level items (items with no parent).

```javascript
// styles/button.js
``
var utils = require('utils');
``

Item {
    id: button
}

Rectangle {
    id: squareButton
}
```

## Data binding

Style item properties can reference to the item object itself (`this`), other items (by their ids), defined JavaScript variables, call functions and more.

```javascript
Item {
    x: Math.random()
    y: this.x
    width: child.width * 2

    Rectangle {
        id: child
        width: 100
    }
}
```

`parent`, `previousSibling` and `nextSibling` don't have to be prefixed by `this`.

## Global access

In style files you have access to the `app` object and to the `view` - first top level item from the `view.js` file (in other words - window item).

```javascript
Rectangle {
    width: view.width
    color: app.cookies.clientColor // chm..
}
```

## Signals

Renderer emits signals in various places:
- on property value change (`onWidthChange(oldValue)`),
- on namespace property change (`onMarginChange(property, oldValue)`),
- on children change (`onChildrenChange(added, removed)`),
- on pointer click (`pointer.onClick(event)`),
- and more...

Items with defined ids are available in the signal listener.

```javascript
Item {
    width: 100
    height: 100
    pointer.onClick: function(event){
        this.x = event.x;
        rect.color = 'green';
    }

    Rectangle {
        id: rect
        width: 100
        height: 100
        color: 'red'
    }
}
```

## Conditions

```javascript
Rectangle {
    x: 50
    color: 'red'

    if (this.x < 70 && Device.mobile){
        color: 'green'
    }
}
```

## Custom properties

```javascript
Item {
    property $.health: 100
    signal $.onAttack
    signal $.onLowHealth
    $.onAttack: function(target){
        this.$.health -= target.$.attack;
        if (this.$.health < 40){
            this.$.onLowHealth.emit();
        }
    }
}
```

Custom properties and signals must be created in the `$` object.

Custom properties have their corresponding signals (e.g. `$.onHealthChange`).

## Type extending

Top level objects are available in the `exports` object under their ids.

```javascript
Item {
    id: button
}

exports.button {
    width: 100
}
```

This also works across files.

```javascript
// styles/button.js
Item {
    id: sampleButton
}

// styles/complexButton.js
``
var button = require('./button.js');
``
button.sampleButton {
}
```

## Layout

To position children in an item, you can use few methods.
The first one you already know - it's absolute positioning (`x` and `y`).

### Flow

Flow element position items from left to right.

`Item::layout` gives you a possibility to change how this item behaves in his layout parent.

```javascript
Flow {
    width: 400

    Rectangle {
        width: 100
        height: 100
        margin.bottom: 20
    }

    Rectangle {
        layout.fillWidth: true
    }
}
```

### Grid

Grid positions its children in grid formation.

Other elements similar to Grid are Column and Row.

```javascript
Grid {
    columns: 2
    spacing: 20

    Rectangle {
        width: 100
        height: 100
    }

    Rectangle {
        width: 100
        height: 100
    }
}
```

### Anchor

`Item::anchor` describes relation between two items.
Each item has few lines: top, verticalCenter, bottom, left, horizontalCenter and bottom.

You can stick item line into another item. For the performance reasons, you can anchor only to siblings or to the item parent.

```javascript
Item {
    Rectangle {
        id: rect1
    }

    Rectangle {
        anchors.left: rect1.right
        margin.left: 20
    }
}
```

## Background

`Item::background` gives a possibility to use any item as a background.

By default, background fills his parent.

```javascript
Item {
    background: Rectangle {}
}
```

## Number animation

Neft supports animating number properties.
Use `NumberAnimation` to achieve this goal.

By default animator animates item, in which it was created.

```javascript
Item {
    NumberAnimation {
        property: 'x'
        from: 0
        to: 1000
        loop: true
    }
}
```

By default animators don't update the property during animation (it's much faster). To change this behavior, switch the `PropertyAnimation::updateData` property.

## Transitions

Transition type automatically animate all updates on the given property.

```javascript
Item {
    width: 205

    if (this.pointer.hover){
        x: 100
    }

    Transition {
        when: this.target.width > 200
        property: 'x'
        animation: NumberAnimation {
            startDelay: 500
            easing: 'OutSine'
        }
    }
}
```

## Views integration

You can draw styles just putting them into the `view.js` top level item, but, for the better organization, we need to integrate our HTML documents with our styles.

`Item::document::query` will use an item on all elements found by the given query. `document::query` can't be changed in runtime.

```javascript
Text {
    document.query: 'span'
    // this item will be used for all 'span' elements
}
```

Because the `document::query` can be also attached to the item children, you can create complex custom elements based on more than one HTML elements

```javascript
Item {
    document.query: 'avatar'

    Text {
        document.query: '> nick'
    }
}
```

### Runtime changes

For more dynamic behaviors you can use the `for (query){}` syntax.
It works like *if (){}* but uses a query and modifies all HTML elements found by the given query.

```javascript
for ('span.large'){
    font.pixelSize: 30
}
```

`for` can be a top level definition or an `Item` children.

`for`s can be nested.

```javascript
for ('body[page=docs]'){
    for ('header'){
        background.color: 'green'
    }
}
```

### Inline styles

Attached style Item on the document element is available under the `style` property. You can use it to define styles in the HTML document.

```html
<span style:font:pixelSize="30">ABC</span>
```

Inline styles also supports signals. You can attach route method, or a `neft:function`.

```html
<span style:onTextChange="${route.spanTextChange}">ABC</span>
```

### Custom properties

Item custom properties are synchronized with the HTML element attributes.

```html
<!-- property $.health: 200 -->
<player health="100" />
```

Next article: [[Networking - Tour]]
