# use

Tag used to place *component*.

```xml
<component name="user">
  This is a user
</component>

<use component="user" />
```

*component* attribute can be changed in runtime.

```xml
<component name="h1">
  <h1>H1 heading</h1>
</component>

<use component="h${data.level}" />
```

Short version of *use* is a tag prefixed by `use:`.

```xml
<component name="user">
  This is a user
</component>

<user />
```

*use* attributes are available in *component* scope.

```xml
<component name="heading">
  <h1>H1: ${props.data}</h1>
</component>

<heading data="Test heading" />
```

## n-async

Renders component on the first free animation frame.

Use this attribute to render less important elements.

```xml
<body n-async />
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
                node.attrs['component'] = component

            # get uses
            if node.name is 'use'
                node.name = 'blank'
                uses.push new File.Use file, node

        forNode file.node

        unless utils.isEmpty(uses)
            file.uses = uses

# Glossary

- [use](#use)
