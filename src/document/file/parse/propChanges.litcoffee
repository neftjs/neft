# prop

Tag used to dynamically change a prop of the parent element.

```xml
<header ref="header">
    <prop name="isActive" value="true" n-if="${context.isActive}" />
    <span>Active: ${refs.header.props.isActive}</span>
</header>
```

    'use strict'

    module.exports = (File) ->
        {PropChange} = File

        (file) ->
            {propChanges} = file

            nodes = file.node.queryAll 'prop'

            for node in nodes
                target = node.parent
                name = node.props.name

                unless target.props.has(name)
                    target.props.set name, ''

                propChanges.push new PropChange file, node, target, name

            return

# Glossary

- [prop](#prop)
