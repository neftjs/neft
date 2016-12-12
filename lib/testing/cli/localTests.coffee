'use strict'

testsFile = require './testsFile'
processLogs = require './processLogs'
config = require './config'
childProcess = require 'child_process'
pathUtils = require 'path'

{log} = Neft

TARGET = 'local'

PROCESS_OPTIONS =
    silent: true

getInitPath = ->
    pathUtils.join __dirname, './localTestsInitFile.js'

runTestsInProcess = (callback) ->
    log.info 'running local tests'
    logsReader = new processLogs.LogsReader
    mainErr = null
    path = getInitPath()
    nodeProcess = childProcess.fork path, PROCESS_OPTIONS
    nodeProcess.stdout.on 'data', (data) ->
        logsReader.log data
        if logsReader.terminated
            nodeProcess.kill()
    nodeProcess.stderr.on 'data', (data) ->
        mainErr ?= String(data)
        log.error data
    nodeProcess.on 'exit', ->
        log.info 'local tests terminated'
        callback mainErr or logsReader.error

exports.runTestsLocally = (callback) ->
    testsFile.saveBuildTestsFile TARGET, (err) ->
        if err
            return callback err
        runTestsInProcess callback
