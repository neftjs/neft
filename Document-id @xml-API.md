> [Wiki](Home) ▸ [API Reference](API-Reference)

id
[Tag][document/Tag] with the id attribute is saved in the local scope
(file, [neft:fragment][document/neft:fragment@xml], [neft:each][document/neft:each@xml] etc.)
and it's available in the string interpolation.
Id must be unique in the scope.
```xml
<h1 id="heading">Heading</h1>
<span>${heading.stringify()}</span>
```

> [`Source`](/Neft-io/neft/tree/master/src/document/file/parse/ids.litcoffee#id-xml)

