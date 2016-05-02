'use strict'

cp = require 'child_process'

module.exports = (options) ->
    mode = if options.release then 'release' else 'develop'
    cp.fork "./build/app-node-#{mode}.js"
