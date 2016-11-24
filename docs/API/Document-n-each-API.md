> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **n-each**

# n-each

Attribute used for repeating.

Tag children will be duplicated for each
element defined in the [n-each](/Neft-io/neft/wiki/Document-n-each-API#neach) attribute.

Supports arrays and [List](/Neft-io/neft/wiki/List-API#class-list) instances.

```xml
<ul n-each="[1, 2]">
  <li>ping</li>
</ul>
```

In the tag children you have access to the three special variables:
- **each** - `n-each` attribute,
- **item** - current element,
- **index** - current element index.

```xml
<ul n-each="List(['New York', 'Paris', 'Warsaw'])">
  <li>Index: ${props.index}; Current: ${props.item}; Next: ${props.each[i+1]}</li>
</ul>
```

## Table of contents
* [n-each](#neach)
  * [Runtime changes](#runtime-changes)
* [Glossary](#glossary)

## Runtime changes

Use [List](/Neft-io/neft/wiki/List-API#class-list) to bind changes made in the array.

> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/file/parse/iterators.litcoffee)

# Glossary

- [n-each](#neach)

