'use strict'

childProcess = require 'child_process'
config = require '../cli/config'
processLogs = require '../cli/processLogs'
pathUtils = require 'path'
which = require 'which'

{utils, log} = Neft

PROCESS_OPTIONS =
    silent: true

getInitPath = (env) ->
    path = config.getPlatformOutFolder 'node'
    pathUtils.join path, 'build/app-node-develop.js'

exports.run = (env, callback) ->
    {version} = env
    log.info "running nvm with node version #{version}"
    logsReader = new processLogs.LogsReader
    mainErr = null
    path = getInitPath env
    command = ". $NVM_DIR/nvm.sh && nvm exec #{version} node #{path}"
    nvmProcess = childProcess.exec command, PROCESS_OPTIONS
    nvmProcess.stdout.on 'data', (data) ->
        logsReader.log data
        if logsReader.terminated
            nvmProcess.kill()
    nvmProcess.stderr.on 'data', (data) ->
        mainErr ?= String(data)
        log.error data
    nvmProcess.on 'exit', ->
        log.info 'nvm terminated'
        callback mainErr or logsReader.error
