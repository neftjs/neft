# target

Tag used in *component* to define,
where *use* body should be placed.

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

    'use strict'

    module.exports = (File) -> (file) ->
        if file.targetNode = file.node.query('target')
            file.targetNode.name = 'blank'

# Glossary

- [target](#target)
