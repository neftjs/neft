> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-Document-API]] ▸ **neft:attr**

# neft:attr

Tag used to dynamically change an attribute of the parent element.

```xml
<header id="header">
    <neft:attr name="isActive" value="true" neft:if="${root.isActive}" />
    <span>Active: ${ids.header.attrs.isActive}</span>
</header>
```

> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/document/file/parse/attrChanges.litcoffee#neftattr)

## Table of contents
* [neft:attr](#neftattr)
* [Glossary](#glossary)

# Glossary

- [neft:attr](#neftattr)

