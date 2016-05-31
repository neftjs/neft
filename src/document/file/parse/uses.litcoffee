# neft:use

Tag used to place *neft:fragment*.

```xml
<neft:fragment neft:name="user">
  This is a user
</neft:fragment>

<neft:use neft:fragment="user" />
```

*neft:fragment* attribute can be changed in runtime.

```xml
<neft:fragment neft:name="h1">
  <h1>H1 heading</h1>
</neft:fragment>

<neft:use neft:fragment="h${data.level}" />
```

Short version of *neft:use* is a tag prefixed by `use:`.

```xml
<neft:fragment neft:name="user">
  This is a user
</neft:fragment>

<use:user />
```

*neft:use* attributes are available in *neft:fragment* scope.

```xml
<neft:fragment neft:name="h1">
  <h1>H1: ${props.data}</h1>
</neft:fragment>

<use:h1 data="Test heading" />
```

## neft:async

Renders fragment on the first free animation frame.

Use this attribute to render less important elements.

```xml
<use:body neft:async />
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
            if /^use\:/.test(node.name)
                fragment = node.name.slice 'use:'.length
                node.name = 'neft:use'
                node.attrs['neft:fragment'] = fragment

            # get uses
            if node.name is 'neft:use'
                node.name = 'neft:blank'
                uses.push new File.Use file, node

        forNode file.node

        unless utils.isEmpty uses
            file.uses = uses

# Glossary

- [neft:use](#neftuse)
