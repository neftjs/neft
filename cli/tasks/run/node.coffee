'use strict'

cp = require 'child_process'

module.exports = (options) ->
    mode = if options.release then 'release' else 'develop'
    child = cp.fork "./build/app-node-#{mode}.js"

    process.on 'message', (msg) ->
        if msg is 'terminate'
            child.send 'terminate'
