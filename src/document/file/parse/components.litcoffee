# <component />

This tag is used to create separated and repeatable parts of a document.

Each component has to define a unique `name`.

*Component* can be created using the *<use />* tag,
or by creating a tag with the needed name.

It's recommended to start component names with a big letter.

Each component creates different script scope (`this`).

Example:

```xml
<component name="Product">
  <h2>${props.name}</h2>
  <span>Type: ${props.type}</span>
</component>

<section>
  <Product type="electronics" name="dryer" />
  <Product type="painting" name="Lucretia, Paolo Veronese" />
</section>
```

    'use strict'

    utils = require 'src/utils'

    module.exports = (File) ->
        parseLinks = require('./links') File

        (file) ->
            {components} = file
            createdComponents = []

            # merge components from files
            links = parseLinks file
            for link in links
                namespace = if link.namespace then "#{link.namespace}:" else ''
                linkView = File.factory link.path

                # link required file
                if link.namespace
                    components[link.namespace] = linkView.path

                # link required file components
                for name, component of linkView.components
                    components[namespace + name] = component

                linkView.destroy()

            # find components in file
            forEachNodeRec = (node) ->
                unless children = node.children
                    return
                i = -1; n = children.length
                while ++i < n
                    child = children[i]

                    if child.name isnt 'component'
                        forEachNodeRec child
                        continue

                    unless name = child.props['name']
                        continue

                    # remove node from file
                    child.name = 'blank'
                    child.parent = null
                    i--; n--

                    # get component
                    path = "#{file.path}##{name}"
                    component = new File path, child
                    components[name] = path
                    createdComponents.push component

            forEachNodeRec file.node

            # link components
            for createdComponent in createdComponents
                for componentName, componentId of components
                    createdComponent.components[componentName] ?= componentId

            # parse components
            for createdComponent in createdComponents
                File.parse createdComponent

            return

# Glossary

- [component](#component)
- [<component />](#component)
