> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **neft:each**

# neft:each

Attribute used for repeating.

Tag children will be duplicated for each
element defined in the [neft:each](/Neft-io/neft/wiki/Document-neft:each-API#nefteach) attribute.

Supports arrays and [List](/Neft-io/neft/wiki/List-API#class-list) instances.

```xml
<ul neft:each="[1, 2]">
  <li>ping</li>
</ul>
```

In the tag children you have access to the three special variables:
- **each** - `neft:each` attribute,
- **item** - current element,
- **index** - current element index.

```xml
<ul neft:each="List(['New York', 'Paris', 'Warsaw'])">
  <li>Index: ${props.index}; Current: ${props.item}; Next: ${props.each[i+1]}</li>
</ul>
```

## Table of contents
* [neft:each](#nefteach)
  * [Runtime changes](#runtime-changes)
* [Glossary](#glossary)

## Runtime changes

Use [List](/Neft-io/neft/wiki/List-API#class-list) to bind changes made in the array.

> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/document/file/parse/iterators.litcoffee#runtime-changes)

# Glossary

- [neft:each](#nefteach)

