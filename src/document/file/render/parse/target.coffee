'use strict'

module.exports = (File) -> (file, source) ->
    {targetNode} = file
    if targetNode and source
        {node} = source
        while child = node.children[0]
            child.parent = targetNode

    return
