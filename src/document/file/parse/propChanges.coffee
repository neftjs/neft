'use strict'

module.exports = (File) ->
    {PropChange} = File

    (file) ->
        {propChanges} = file

        nodes = file.node.queryAll 'prop'

        for node in nodes
            target = node.parent
            name = node.props.name

            unless target.props.has(name)
                target.props.set name, ''

            propChanges.push new PropChange file, node, target, name

        return
