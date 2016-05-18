> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **neft:function @xml**

neft:function @xml
==================

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

> [`Source`](/Neft-io/neft/tree/master/src/document/file/parse/funcs.litcoffee#neftfunction-xml)

