> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **ref**

# ref

[Element.Tag](/Neft-io/neft/wiki/Document-Element.Tag-API#class-tag) with the ref attribute is saved in the local scope
(file, [component](/Neft-io/neft/wiki/Document-component-API#component), [n-each](/Neft-io/neft/wiki/Document-n-each-API#neach) etc.)
and it's available in the string interpolation.

Id must be unique in the scope.

```xml
<h1 ref="heading">Heading</h1>
<span>${refs.heading.stringify()}</span>
```

> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/file/parse/refs.litcoffee)

## Table of contents
* [ref](#ref)
* [Glossary](#glossary)

# Glossary

- [ref](#ref)

