# Dynamic Styling


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
