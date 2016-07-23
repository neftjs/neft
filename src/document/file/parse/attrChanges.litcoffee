# attr

Tag used to dynamically change an attribute of the parent element.

```xml
<header id="header">
    <attr name="isActive" value="true" n-if="${root.isActive}" />
    <span>Active: ${ids.header.attrs.isActive}</span>
</header>
```

    'use strict'

    module.exports = (File) ->
        {AttrChange} = File

        (file) ->
            {attrChanges} = file

            nodes = file.node.queryAll 'attr'

            for node in nodes
                target = node.parent
                name = node.attrs.name

                unless target.attrs.has(name)
                    target.attrs.set name, ''

                attrChanges.push new AttrChange file, node, target, name

            return

# Glossary

- [attr](#attr)
