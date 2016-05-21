> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
neft:use
Tag used to place a [neft:fragment][document/neft:fragment@xml].
```xml
<neft:fragment neft:name="user">
  This is a user
</neft:fragment>
<neft:use neft:fragment="user" />
```
`neft:fragment` attribute can be changed in runtime.
```xml
<neft:fragment neft:name="h1">
  <h1>H1 heading</h1>
</neft:fragment>
<neft:use neft:fragment="h${data.level}" />
```
Short version of `neft:use` is a tag prefixed by `use:`.
```xml
<neft:fragment neft:name="user">
  This is a user
</neft:fragment>
<use:user />
```
`neft:use` attributes are available in the [neft:fragment][document/neft:fragment@xml] scope.
```xml
<neft:fragment neft:name="h1">
  <h1>H1: ${attrs.data}</h1>
</neft:fragment>
<use:h1 data="Test heading" />
```

## Table of contents
    * [neft:use](#neftuse)
  * [neft:async](#neftasync)

## neft:async

Renders fragment on the first free animation frame.
Use this attribute to render less important elements.
```xml
<use:body neft:async />
```

> [`Source`](/Neft-io/neft/tree/master/src/document/file/parse/uses.litcoffee#neftasync)

