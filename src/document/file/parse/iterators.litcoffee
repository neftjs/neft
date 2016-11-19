# n-each

This attribute is used for repetitions.

Tag body will be cloned for each element defined by this attribute.

Example:

```xml
<ul n-each="[1, 2]">
  <li>ping</li> <!-- rendered twice -->
</ul>
```

You can *string interpolation* inside this attribute.

*List*s changes are automatically synchronized.

Example:

```xml
<ul n-each="${props.listOfItems}">
  <li>item</li>
</ul>
```

Cloned tag body has access to three special props:
- **each** - `n-each` attribute (e.g. an array or a *List*),
- **item** - current element from a list,
- **index** - current element index from a list.

Example:

```xml
<ul n-each="List(['New York', 'Paris', 'Warsaw'])">
  <li>Index: ${props.index}; Current: ${props.item}; Next: ${props.each[props.index+1]}</li>
</ul>
```

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
