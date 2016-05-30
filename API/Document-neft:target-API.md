> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-Document-API]] ▸ **neft:target**

# neft:target

Tag used in *neft:fragment* to define,
where *neft:use* body should be placed.

```xml
<neft:fragment neft:name="user">
  <name>${props.name}</name>
  <age>${props.age}</age>
  <neft:target />
</neft:fragment>

<use:user name="Max" age="19">
  <superPower>flying</superPower>
</neft:use>
```

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file/parse/target.litcoffee#nefttarget)

## Table of contents
* [neft:target](#nefttarget)
* [Glossary](#glossary)

# Glossary

- [neft:target](#neft:target)

