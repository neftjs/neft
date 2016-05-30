> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-Document-API]] ▸ **neft:fragment**

# neft:fragment

Tag used to create separated and repeatable parts of the document.

Each neft:fragment has to define a `neft:name` unique in the file where it's defined.

neft:fragment can be rendered by the *neft:use* tag.

```xml
<neft:fragment neft:name="product">
  <h2>${props.name}</h2>
  <span>Type: ${props.type}</span>
</neft:fragment>

<section>
  <use:product type="electronics" name="dryer" />
  <use:product type="painting" name="Lucretia, Paolo Veronese" />
</section>
```

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file/parse/fragments.litcoffee#neftfragment)

## Nested APIs

* [[neft:require|Document-neft:require-API]]

## Table of contents
* [neft:fragment](#neftfragment)
* [Glossary](#glossary)

# Glossary

- [neft:fragment](#neft:fragment)

