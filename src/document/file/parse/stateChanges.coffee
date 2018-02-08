'use strict'

module.exports = (File) ->
    {StateChange} = File

    (file) ->
        {stateChanges} = file

        nodes = file.node.queryAll 'n-state'

        for node in nodes
            name = node.props.name
            stateChanges.push new StateChange file, node, name

        return
