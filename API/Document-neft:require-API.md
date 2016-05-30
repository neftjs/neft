> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-Document-API]] ▸ [[neft:fragment|Document-neft:fragment-API]] ▸ **neft:require**

# neft:require

Tag used to link *neft:fragment*s from a file and use them.

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

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file/parse/fragments/links.litcoffee#namespace)

# Glossary

- [neft:require](#neft:require)

