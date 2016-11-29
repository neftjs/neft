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
