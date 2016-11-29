'use strict'

module.exports = (File) -> (file) ->
    if file.targetNode = file.node.query('target')
        file.targetNode.name = 'blank'
