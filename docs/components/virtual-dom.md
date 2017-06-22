# Virtual DOM

Each *XHTML* tag in a component file is represented by an instance of [`Tag`](/api/document-tag.html).

Each text is represented by an instance of [`Text`](/api/document-text.html).

The base class for both types is [`Element`](/api/document-element.html).

## Getting elements

The main tag for a component file or [component](/components.html#component) can be accessed inside `<script />` as `this.node`.

Each tag with `ref` attribute is accessible by the `this.refs` object or using the `${refs}` [string interpolation](/components.html#string-interpolation) unless it puts a [component](/components.html#component).

In styles, connected node can be reached using the [`this.node`](/api/renderer-item.html#node) reference.

## Querying elements

All methods available in *Virtual DOM* are described in the [API Reference](/api.html).

One of the most interesting parts, are querying elements using *CSS Selector*.

Use [`query()`](/api/document-tag.html#query) to get the first matched element.

Use [`queryAll()`](/api/document-tag.html#queryall) to get all matched elements.

To find a text, specify `#text` in *CSS Selector*.

```xhtml
<p><span>big</span> yellow <span>dragon</span></p>

<script>
console.log(this.node.queryAll('p > span > #text'));
// [big, dragon]

console.log(this.node.queryAll('p #text'));
// [big, yellow, dragon]
</script>
```
