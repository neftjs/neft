> [Wiki](Home) ▸ [[API Reference|API-Reference]]

neft:function
<dl><dt>Syntax</dt><dd><code>neft:function @xml</code></dd></dl>
Tag used to create functions in the view.

```xml
<neft:function name="multiply" arguments="a, b">
  return a * b;
</neft:function>

<neft:function name="boost">
  item.text = view.funcs.multiply(item.text, item.text);
</neft:function>

<button neft:style:pointer:onClick="${boost}">1</button>
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file/parse/funcs.litcoffee#neftfunction)

