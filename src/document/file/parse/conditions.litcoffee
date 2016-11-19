# n-if

This attribute is used to hide or show the tag depends on the given condition.

If the given *string interpolation* evalues to *falsy* result,
the whole tag is being hidden.

`n-else` attribute may be specified in the next sibling.

Example:

```xml
<span n-if="${props.user.isLogged}">Hi ${props.user.name}!</span>
<span n-else>You need to log in</span>
```

    'use strict'

    module.exports = (File) ->
        {Condition} = File

        (file) ->
            {conditions} = file

            forEachNodeRec = (node) ->
                for child in node.children
                    unless child instanceof File.Element.Tag
                        continue

                    forEachNodeRec child

                    if child.props.has('n-if')
                        elseNode = null
                        if child.nextSibling?.props?.has?('n-else')
                            elseNode = child.nextSibling

                        conditions.push new File.Condition file, child, elseNode
                return

            forEachNodeRec file.node

# Glossary

- [n-if](#nif)
