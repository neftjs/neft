> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **prop**

# prop

Tag used to dynamically change a prop of the parent element.

```xml
<header ref="header">
    <prop name="isActive" value="true" n-if="${context.isActive}" />
    <span>Active: ${refs.header.props.isActive}</span>
</header>
```

> [`Source`](/Neft-io/neft/blob/2c087cdd2c61477a6c35b8e1fdc0fcfea8d41eca/src/document/file/parse/propChanges.litcoffee)

## Table of contents
* [prop](#prop)
* [Glossary](#glossary)

# Glossary

- [prop](#prop)

