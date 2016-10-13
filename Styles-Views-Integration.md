Neft uses his own language to describe how the elements looks like, therefore styles in Neft can be well organized and more dynamic, because the JavaScript support, views data-binding and more.

All style files must be placed in the `/styles` folder.

## NML syntax

NML *(Neft Marked Language)* is a simple but powerful language inspired by QML.

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

`id` is optional and it's used for data-binding.

## Main style

The main style must be returned as a first element from the `__view__.js` file.
It's a starting point of your application.

## Base item

All visible types in Neft extends the `Item` type.

It contains various properties (e.g. `x`, `y`, `scale`, `width`, `nextSibling`), `keys` and `pointer` support, `children` list and more. Check later the API Reference for the `Renderer` module.

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
`
var utils = Neft.utils;
`

Item {
    id: button
}

Rectangle {
    id: squareButton
}
```

## Data binding

Item properties can reference to the item object itself (`this`), other items (by their ids), defined JavaScript variables and call functions.

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

In style files you have access to the `app` object and to the `view` main style globally.

```javascript
Rectangle {
    width: view.width
    color: app.cookies.clientColor
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

To position children in an item, you can use few methods:
 - absolute positioning (`x` and `y` properties),
 - from left to right - `Flow` type,
 - on a grid - `Grid`, `Column`, `Row` types,
 - anchors.

### Flow

Flow element position items from left to right.

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

Grid positions its children in a grid formation.

Other elements similar to `Grid` are `Column` and `Row`.

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

You can stick an item line into another item line. For the performance reasons, you can anchor only to siblings or to the item parent.

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

By default, *background` is a `Rectangle` filling his parent.

```javascript
Item {
    background: Rectangle {
        color: 'red'
    }
    // .. or just
    background.color: 'red'
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

By default animators don't update the property during animation (it's much faster).
To change this behaviour, switch the `PropertyAnimation::updateProperty` boolean.

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

You can draw styles just putting them into the `__view__.js` top level item, but, for the better organization, we need to integrate our HTML documents with created styles.

`Item::document::query` will use an item on all elements found by the given query. `document::query` can't be changed in runtime.

```javascript
Text {
    document.query: 'span'
    // this item will be used for all 'span' elements from views
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

For more dynamic behaviors you can use the `for (query) {}` syntax.
It works like `if () {}` but uses a query and modifies all found HTML elements in runtime.

```javascript
for ('header.large'){
    width: parent.width * 0.8
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

### Text styling

All HTML texts are rendered by default as Renderer `Text` items. You can modify how the texts looks like using the `#text` query. In Neft, text styles are not inherited like in CSS.

```javascript
for ('span.large #text') {
    font.pixelSize: 30
}
```

### Inline styles

Attached style Item on the document element is available under the `style` property. You can use it to define inline styles in the HTML document.

```html
<span style:font:pixelSize="30">ABC</span>
```

Inline styles also supports signals.

```html
<span style:pointer:onClick="${this.onSpanClick}">ABC</span>
```

Next article: [[Networking - Tour]]
