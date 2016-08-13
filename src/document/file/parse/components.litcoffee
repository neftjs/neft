# component

Tag used to create separated and repeatable parts of the document.

Each component has to define a `name` unique in the file where it's defined.

component can be rendered by the *use* tag.

```xml
<component name="product">
  <h2>${props.name}</h2>
  <span>Type: ${props.type}</span>
</component>

<section>
  <product type="electronics" name="dryer" />
  <product type="painting" name="Lucretia, Paolo Veronese" />
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
                    components[link.namespace] = linkView

                # link required file components
                for name, component of linkView.components
                    components[namespace + name] = component

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

                    unless name = child.attrs['name']
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
