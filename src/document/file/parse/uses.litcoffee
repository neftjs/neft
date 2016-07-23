# use

Tag used to place *fragment*.

```xml
<fragment name="user">
  This is a user
</fragment>

<use fragment="user" />
```

*fragment* attribute can be changed in runtime.

```xml
<fragment name="h1">
  <h1>H1 heading</h1>
</fragment>

<use fragment="h${data.level}" />
```

Short version of *use* is a tag prefixed by `use:`.

```xml
<fragment name="user">
  This is a user
</fragment>

<user />
```

*use* attributes are available in *fragment* scope.

```xml
<fragment name="heading">
  <h1>H1: ${props.data}</h1>
</fragment>

<heading data="Test heading" />
```

## n-async

Renders fragment on the first free animation frame.

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
            if file.fragments[node.name]
                fragment = node.name
                node.name = 'use'
                node.attrs['fragment'] = fragment

            # get uses
            if node.name is 'use'
                node.name = 'blank'
                uses.push new File.Use file, node

        forNode file.node

        unless utils.isEmpty(uses)
            file.uses = uses

# Glossary

- [use](#use)
