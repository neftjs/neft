# <target />

This tag is used in *component* to define where the given children should be placed.

Example:

```xml
<component name="User">
  <name>${props.name}</name>
  <age>${props.age}</age>
  <target /> <!-- <superPower>flying</superPower> -->
</component>

<User name="Max" age="19">
  <superPower>flying</superPower>
</User>
```

    'use strict'

    module.exports = (File) -> (file) ->
        if file.targetNode = file.node.query('target')
            file.targetNode.name = 'blank'

# Glossary

- [<target />](#target)
