> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-Document-API]] ▸ **neft:each**

# neft:each

Attribute used for repeating.

Tag children will be duplicated for each
element defined in the *neft:each* attribute.

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

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file/parse/iterators.litcoffee#runtime-changes)

# Glossary

- [neft:each](#neft:each)
