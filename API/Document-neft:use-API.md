> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-Document-API]] ▸ **neft:use**

# neft:use

Tag used to place *neft:fragment*.

```xml
<neft:fragment neft:name="user">
  This is a user
</neft:fragment>

<neft:use neft:fragment="user" />
```

*neft:fragment* attribute can be changed in runtime.

```xml
<neft:fragment neft:name="h1">
  <h1>H1 heading</h1>
</neft:fragment>

<neft:use neft:fragment="h${data.level}" />
```

Short version of *neft:use* is a tag prefixed by `use:`.

```xml
<neft:fragment neft:name="user">
  This is a user
</neft:fragment>

<use:user />
```

*neft:use* attributes are available in *neft:fragment* scope.

```xml
<neft:fragment neft:name="h1">
  <h1>H1: ${props.data}</h1>
</neft:fragment>

<use:h1 data="Test heading" />
```

## Table of contents
* [neft:use](#neftuse)
  * [neft:async](#neftasync)
* [Glossary](#glossary)

## neft:async

Renders fragment on the first free animation frame.

Use this attribute to render less important elements.

```xml
<use:body neft:async />
```

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file/parse/uses.litcoffee#neftasync)

# Glossary

- [neft:use](#neft:use)

