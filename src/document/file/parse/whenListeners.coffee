'use strict'

module.exports = (File) ->
    {WhenListener} = File

    (file) ->
        {whenListeners} = file

        nodes = file.node.queryAll 'n-when'

        for node in nodes
            whenListeners.push new WhenListener file, node

        return
