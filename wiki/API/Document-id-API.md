> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **id**

# id

[Element.Tag](/Neft-io/neft/wiki/Document-Element.Tag-API#class-tag) with the id attribute is saved in the local scope
(file, [neft:fragment](/Neft-io/neft/wiki/Document-neft:fragment-API#neftfragment), [neft:each](/Neft-io/neft/wiki/Document-neft:each-API#nefteach) etc.)
and it's available in the string interpolation.

Id must be unique in the scope.

```xml
<h1 id="heading">Heading</h1>
<span>${ids.heading.stringify()}</span>
```

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file/parse/ids.litcoffee#id)

## Table of contents
* [id](#id)
* [Glossary](#glossary)

# Glossary

- [id](#id)

