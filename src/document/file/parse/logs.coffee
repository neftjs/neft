'use strict'

module.exports = (File) -> (file) ->
    {logs} = file

    for node in file.node.queryAll('n-log')
        node.visible = false
        logs.push new File.Log file, node

    return
