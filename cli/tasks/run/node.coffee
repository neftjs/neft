'use strict'

cp = require 'child_process'
utils = require 'src/utils'
log = require 'src/log'

module.exports = (options) ->
    mode = if options.release then 'release' else 'develop'

    log.log '''
        \n**Node process logs below**
        **-----------------------**
    '''

    prefixLog = log.prefix 'node'
    onLog = (msg) ->
        prefixLog.log msg
    onBuffer = (buf) ->
        str = String(buf)
        return unless str.trim()
        if str.endsWith('\n')
            str = str.slice 0, -1
        str.split('\n').forEach onLog
        return

    env = utils.mergeAll {}, process.env, FORCE_COLOR: 1
    child = cp.fork "./build/app-node-#{mode}.js", env: env, silent: true

    child.stdout.on 'data', onBuffer
    child.stderr.on 'data', onBuffer

    process.on 'message', (msg) ->
        if msg is 'terminate'
            child.send 'terminate'

    child.on 'exit', ->
        process.exit()
