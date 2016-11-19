# ref

This attribute is used to save a attached tag into the local `refs` object.

Id must be unique in *component*.

Example:

```xml
<h1 ref="heading">Heading</h1>
<span>${refs.heading.stringify()}</span> <!-- <span>Heading</span> -->
```

    'use strict'

    utils = require 'src/utils'
    log = require 'src/log'

    log = log.scope 'Document'

    module.exports = (File) -> (file) ->
        {refs} = file

        forEachNodeRec = (node) ->
            for child in node.children
                unless child.children
                    continue

                forEachNodeRec child

                unless ref = child.props['ref']
                    continue

                if refs.hasOwnProperty(ref)
                    log.warn "Ref must be unique; '#{ref}' duplicated"
                    continue
                refs[ref] = child
            return

        forEachNodeRec file.node

# Glossary

- [ref](#ref)
