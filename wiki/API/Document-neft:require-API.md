> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ [[neft:fragment|Document-neft:fragment-API]] ▸ **neft:require**

# neft:require

Tag used to link [neft:fragment](/Neft-io/neft/wiki/Document-neft:fragment-API#neftfragment)s from a file and use them.

```xml
<neft:require href="./user_utils.html" />

<use:avatar />
```

## Table of contents
* [neft:require](#neftrequire)
  * [Namespace](#namespace)
* [Glossary](#glossary)

## Namespace

Optional argument `as` will link all fragments into the specified namespace.

```xml
<neft:require href="./user_utils.html" as="user" />

<use:user:avatar />
```

> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/document/file/parse/fragments/links.litcoffee#namespace)

# Glossary

- [neft:require](#neftrequire)

