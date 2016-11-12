> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **import**

# import

Tag used to link [component](/Neft-io/neft/wiki/Document-component-API#component)s from a file and use them.

```xml
<import href="./user_utils.html" />
<avatar />
```

## Table of contents
* [import](#import)
  * [Namespace](#namespace)
* [Glossary](#glossary)

## Namespace

Optional argument `as` will link all components into the specified namespace.

```xml
<import href="./user_utils.html" as="user" />
<user:avatar />
```

> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/file/parse/links.litcoffee)

# Glossary

- [import](#import)

