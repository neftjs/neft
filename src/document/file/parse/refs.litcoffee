# ref

*Element.Tag* with the ref attribute is saved in the local scope
(file, *component*, *n-each* etc.)
and it's available in the string interpolation.

Id must be unique in the scope.

```xml
<h1 ref="heading">Heading</h1>
<span>${refs.heading.stringify()}</span>
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

                unless ref = child.attrs['ref']
                    continue

                if refs.hasOwnProperty(ref)
                    log.warn "Ref must be unique; '#{ref}' duplicated"
                    continue
                refs[ref] = child
            return

        forEachNodeRec file.node

# Glossary

- [ref](#ref)
