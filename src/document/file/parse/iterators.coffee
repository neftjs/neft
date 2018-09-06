'use strict'

utils = require 'src/utils'

module.exports = (File) -> (file, options) ->
    {iterators} = file
    createdComponents = []
    uid = 0
    fileScopeProps = options?.scopeProps or []

    forNode = (elem) ->
        unless propVal = elem.props['n-for']
            for child in elem.children
                if child instanceof File.Element.Tag
                    forNode child
            return

        path = "#{file.path}#for[#{uid++}]"

        # get component
        bodyNode = new File.Element.Tag
        while child = elem.children[0]
            child.parent = bodyNode
        component = new File path, bodyNode
        utils.merge component.components, file.components

        unless utils.has(propVal, ' in ')
            throw new Error "Invalid syntax of `n-for=\"#{propVal}\"`"

        [left, binding] = propVal.split ' in '
        elem.props['n-for'] = binding
        if left[0] is '(' and left[left.length - 1] is ')'
            left = left.slice 1, -1

        # set binding scope
        scopeProps = left.split(',').map (part) -> part.trim()

        # get iterator
        iterator = new File.Iterator file, elem, path, scopeProps
        iterators.push iterator
        `//<development>`
        iterator.text = binding
        `//</development>`

        createdComponents.push
            component: component
            options:
                scopeProps: scopeProps.concat(fileScopeProps)

    forNode file.node

    # parse created components
    for component in createdComponents
        File.parse component.component, component.options

    return
