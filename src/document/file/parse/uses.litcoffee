# <use />

This tag is used to place a *component*.

Example:

```xml
<component name="User">
  This is a user
</component>

<use component="User" /> <!-- This is a user -->
```

*component* attribute can be changed in runtime.

```xml
<component name="H1">
  <h1>H1 heading</h1>
</component>

<use component="H${data.level}" />
```

*use* attributes are available by `props` in a *component* scope.

```xml
<component name="Heading">
  <h1>H1: ${props.data}</h1>
</component>

<Heading data="Test heading" />
```

## n-async

Use this attribute to render the given component on a first free animation frame.

```xml
<Menu n-async />
```

    'use strict'

    utils = require 'src/utils'

    module.exports = (File) -> (file) ->
        uses = []

        forNode = (node) ->
            unless node instanceof File.Element.Tag
                return

            node.children.forEach forNode

            # change short syntax to long formula
            if file.components[node.name]
                component = node.name
                node.name = 'use'
                node.props['component'] = component

            # get uses
            if node.name is 'use'
                node.name = 'blank'
                uses.push new File.Use file, node

        forNode file.node

        unless utils.isEmpty(uses)
            file.uses = uses

# Glossary

- [<use />](#use)
