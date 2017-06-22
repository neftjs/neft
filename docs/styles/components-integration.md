# Components Integration

Items can be attached to *XHTML* elements.

To connect [`Item`](/api/renderer-item.html) with [components](/components.html), specify `query` as *CSS Selector*. All matched tags will be styled.

```xhtml
<style>
Rectangle {
    query: 'button.bigButton'
    width: 50
    height: 50
    color: 'red'
}
</style>
<button class="bigButton" />
<button class="bigButton" />
```

Matched [Virtual DOM](/components/virtual-dom.html) [Tag](/api/document-tag.html) is accessible in styles as `node`. You can use it in properties.

```xhtml
<style>
Item {
    query: 'enemy'
    width: this.node.props.health * 100
    // width is equal 80
}
</style>
<enemy health="0.8" />
```

`query` can be also attached to children.

Only the first matched child [Tag](/components/virtual-dom.html) can be styled.

Now you can create complex custom elements based on more than one HTML element.

```xhtml
<style>
Item {
    query: 'avatar'

    Text {
        query: '> nick'
    }
}
</style>
<avatar>
    <nick>User Nick</nick>
</avatar>
```

## Inline Styles

You can refer to [`Item`](/api/renderer-api.html) (styles) directly from [Virtual DOM](/components/virtual-dom.html) tag.

Each styled [Tag](/api/document-tag.html) has `style` prop pointing at created Item.

You can use it to define inline styles in *XHTML*.

```xhtml
<style>
Item {
    query: 'button'
}
</style>
<button style:width="200" />
```

Using *Inline Styles* you can attach also to signals.

```xhtml
<style>
Item {
    query: 'button'
}
</style>
<script>
this.onButtonClick = (event) => {};
</script>
<button style:pointer:onClick="${this.onButtonClick}" />
```
