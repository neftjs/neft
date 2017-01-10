'use strict'

module.exports = (File) -> (file) ->
    {logs} = file

    for node in file.node.queryAll('log')
        node.visible = false
        logs.push new File.Log file, node

    return
