'use strict'

childProcess = require 'child_process'
config = require '../cli/config'
pathUtils = require 'path'

{utils, log} = Neft

PROCESS_OPTIONS =
    silent: true
    env: utils.mergeAll {}, process.env,
        NODE_CP_EXEC_PREFIX: ''

getInitPath = (env) ->
    path = config.getPlatformOutFolder 'node'
    pathUtils.join path, 'build/app-node-develop.js'

exports.execFile = (path, logsReader, callback) ->
    mainErr = null
    nodeProcess = childProcess.fork path, PROCESS_OPTIONS
    nodeProcess.stdout.on 'data', (data) ->
        logsReader.log data
        if logsReader.terminated
            nodeProcess.kill()
    nodeProcess.stderr.on 'data', (data) ->
        mainErr ?= String(data)
        log.error data
    nodeProcess.on 'exit', ->
        callback mainErr or logsReader.error

exports.run = (env, logsReader, callback) ->
    log.info 'running node'
    exports.execFile getInitPath(env), logsReader, (err) ->
        log.info 'node terminated'
        callback err
