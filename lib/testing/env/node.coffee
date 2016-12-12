'use strict'

childProcess = require 'child_process'
config = require '../cli/config'
processLogs = require '../cli/processLogs'
pathUtils = require 'path'

{log} = Neft

PROCESS_OPTIONS =
    silent: true

getInitPath = (env) ->
    path = config.getPlatformOutFolder 'node'
    pathUtils.join path, 'build/app-node-develop.js'

exports.run = (env, callback) ->
    log.info 'running node'
    logsReader = new processLogs.LogsReader
    mainErr = null
    path = getInitPath env
    nodeProcess = childProcess.fork path, PROCESS_OPTIONS
    nodeProcess.stdout.on 'data', (data) ->
        logsReader.log data
        if logsReader.terminated
            nodeProcess.kill()
    nodeProcess.stderr.on 'data', (data) ->
        mainErr ?= String(data)
        log.error data
    nodeProcess.on 'exit', ->
        log.info 'node terminated'
        callback mainErr or logsReader.error
