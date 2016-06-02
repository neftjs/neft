> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **neft:target**

# neft:target

Tag used in [neft:fragment](/Neft-io/neft/wiki/Document-neft:fragment-API#neftfragment) to define,
where [neft:use](/Neft-io/neft/wiki/Document-neft:use-API#neftuse) body should be placed.

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

> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/document/file/parse/target.litcoffee#nefttarget)

## Table of contents
* [neft:target](#nefttarget)
* [Glossary](#glossary)

# Glossary

- [neft:target](#nefttarget)

