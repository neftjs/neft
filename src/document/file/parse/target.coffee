'use strict'

module.exports = (File) -> (file) ->
    if file.targetNode = file.node.query('n-target')
        file.targetNode.name = 'blank'
