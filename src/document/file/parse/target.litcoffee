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

    'use strict'

    module.exports = (File) -> (file) ->
        file.targetNode = file.node.query("neft:target")
        file.targetNode?.name = 'neft:blank'

# Glossary

- [neft:target](#nefttarget)
