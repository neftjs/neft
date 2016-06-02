> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **neft:fragment**

# neft:fragment

Tag used to create separated and repeatable parts of the document.

Each neft:fragment has to define a `neft:name` unique in the file where it's defined.

neft:fragment can be rendered by the [neft:use](/Neft-io/neft/wiki/Document-neft:use-API#neftuse) tag.

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

> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/document/file/parse/fragments.litcoffee#neftfragment)

## Nested APIs

* [[neft:require|Document-neft:require-API]]

## Table of contents
* [neft:fragment](#neftfragment)
* [Glossary](#glossary)

# Glossary

- [neft:fragment](#neftfragment)

