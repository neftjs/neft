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
            node.props['n-component'] = component

        # get uses
        if node.name is 'use'
            # support 'n-component' as 'component'
            if node.props.component
                node.props['n-component'] = node.props.component
                delete node.props.component

            # mark tag as internal
            node.name = 'blank'

            # add into component
            uses.push new File.Use file, node

    forNode file.node

    unless utils.isEmpty(uses)
        file.uses = uses
