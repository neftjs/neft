> [Wiki](Home) ▸ [API Reference](API-Reference)

neft:fragment
<dl><dt>Syntax</dt><dd>neft:fragment @xml</dd></dl>
Tag used to create separated and repeatable parts of the document.
Each neft:fragment has to define a `neft:name` unique in the file where it's defined.
neft:fragment can be rendered by the [neft:use][document/neft:use@xml] tag.
```xml
<neft:fragment neft:name="product">
  <h2>${name}</h2>
  <span>Type: ${type}</span>
</neft:fragment>
<section>
  <neft:use neft:fragment="product" type="electronics" name="dryer" />
  <neft:use neft:fragment="product" type="painting" name="Lucretia, Paolo Veronese" />
</section>
```

> [`Source`](/Neft-io/neft/tree/master/src/document/file/parse/fragments.litcoffee#neftfragment-xml)

