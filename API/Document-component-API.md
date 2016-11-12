> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **component**

# component

Tag used to create separated and repeatable parts of the document.

Each component has to define a `name` unique in the file where it's defined.

component can be rendered by the [use](/Neft-io/neft/wiki/Document-use-API#use) tag.

```xml
<component name="product">
  <h2>${props.name}</h2>
  <span>Type: ${props.type}</span>
</component>

<section>
  <product type="electronics" name="dryer" />
  <product type="painting" name="Lucretia, Paolo Veronese" />
</section>
```

> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/file/parse/components.litcoffee)

## Table of contents
* [component](#component)
* [Glossary](#glossary)

# Glossary

- [component](#component)

