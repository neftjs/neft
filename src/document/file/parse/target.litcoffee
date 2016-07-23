# target

Tag used in *fragment* to define,
where *use* body should be placed.

```xml
<fragment name="user">
  <name>${props.name}</name>
  <age>${props.age}</age>
  <target />
</fragment>

<use:user name="Max" age="19">
  <superPower>flying</superPower>
</use>
```

    'use strict'

    module.exports = (File) -> (file) ->
        if file.targetNode = file.node.query('target')
            file.targetNode.name = 'blank'

# Glossary

- [target](#target)
