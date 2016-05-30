> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-Document-API]] ▸ **neft:attr**

# neft:attr

Tag used to dynamically change an attribute of the parent element.

```xml
<header id="header">
    <neft:attr name="isActive" value="true" neft:if="${root.isActive}" />
    <span>Active: ${ids.header.attrs.isActive}</span>
</header>
```

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file/parse/attrChanges.litcoffee#neftattr)

## Table of contents
* [neft:attr](#neftattr)
* [Glossary](#glossary)

# Glossary

- [neft:attr](#neft:attr)

