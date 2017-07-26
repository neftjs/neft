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

                # support 'name' as 'n-name'
                if child.props.name
                    child.props['n-name'] = child.props.name
                    delete child.props.name

                unless name = child.props['n-name']
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
