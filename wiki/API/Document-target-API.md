> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **target**

# target

Tag used in [component](/Neft-io/neft/wiki/Document-component-API#component) to define,
where [use](/Neft-io/neft/wiki/Document-use-API#use) body should be placed.

```xml
<component name="user">
  <name>${props.name}</name>
  <age>${props.age}</age>
  <target />
</component>

<user name="Max" age="19">
  <superPower>flying</superPower>
</user>
```

> [`Source`](/Neft-io/neft/blob/6dba72542d06cd2ab993b1c76488cf2c9e960c8e/src/document/file/parse/target.litcoffee)

## Table of contents
* [target](#target)
* [Glossary](#glossary)

# Glossary

- [target](#target)

