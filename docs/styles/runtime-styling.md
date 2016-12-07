# Runtime Styling

## NML Condition

*NML* supports conditions inside type declarations.

Use it to dynamically change properties or connect to signals.

Condition is automatically updating.

```xhtml
<style>
Rectangle {
    x: 50
    color: 'red'

    if (this.x < 70 && Device.mobile) {
        color: 'green'
    }
</style>
```
}

## NML Modifier

*NML* modifier is similar to standard *CSS* behavior. You specify a *CSS Selector* and stylize all matched elements.

```xhtml
<style>
Item {
    document.query: 'main'

    for ('div button.big'){
        width: 200
    }
}
</style>
<main>
    <div>
        <button class="big" />
    </div>
</main>
```

`for`s can be nested.

```xhtml
<style>
Item {
    for ('body.pageDocs'){
        for ('header'){
            background.color: 'green'
        }
    }
}
</style>
```

## Text styling

### Using modifiers

From [Virtual DOM](/views/virtual-dom.html#querying-elements) you can learn that all text elements are available as `#text` in *CSS Selectors*.

You can use it to stylize texts.

All *XHTML* texts are rendered by default.

Available text properties are available in [API Reference](/api/renderer-text.html).

```xhtml
<style>
Item {
    document.query: 'header'

    for ('p #text') {
        font.pixelSize: 30
    }
}
</style>
<header><p>abc</p></header>
```

### Using elements

Another option to stylize texts is match them by `document.query`.

```xhtml
<style>
Text {
    document.query: 'p'
    // this.text is equal 'abc'
}
</style>
<p>abc</p>
```

If you want to use another type rather than [`Text`](/api/renderer-text.html), provide `$.text` custom property.

```xhtml
<style>
Rectangle {
    document.query: 'p'
    property $.text: ''
    // this.$.text is equal 'abc'
}
</style>
<p>abc</p>
```
