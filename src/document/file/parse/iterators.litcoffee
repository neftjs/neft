# n-each

Attribute used for repeating.

Tag children will be duplicated for each
element defined in the *n-each* attribute.

Supports arrays and *List* instances.

```xml
<ul n-each="[1, 2]">
  <li>ping</li>
</ul>
```

In the tag children you have access to the three special variables:
- **each** - `n-each` attribute,
- **item** - current element,
- **index** - current element index.

```xml
<ul n-each="List(['New York', 'Paris', 'Warsaw'])">
  <li>Index: ${props.index}; Current: ${props.item}; Next: ${props.each[i+1]}</li>
</ul>
```

## Runtime changes

Use *List* to bind changes made in the array.

    'use strict'

    utils = require 'src/utils'

    module.exports = (File) -> (file) ->
        {iterators} = file
        createdComponents = []

        forNode = (elem) ->
            unless propVal = elem.props['n-each']
                for child in elem.children
                    if child instanceof File.Element.Tag
                        forNode child
                return

            path = "#{file.path}#each[#{utils.uid()}]"

            # get component
            bodyNode = new File.Element.Tag
            while child = elem.children[0]
                child.parent = bodyNode
            component = new File path, bodyNode
            utils.merge component.components, file.components
            createdComponents.push component

            # get iterator
            iterator = new File.Iterator file, elem, path
            iterators.push iterator
            `//<development>`
            iterator.text = propVal
            `//</development>`

        forNode file.node

        # parse created components
        for component in createdComponents
            File.parse component

        return

# Glossary

- [n-each](#neach)
