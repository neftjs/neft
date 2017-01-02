'use strict'

testsFile = require '../cli/testsFile'
config = require '../cli/config'
childProcess = require 'child_process'
pathUtils = require 'path'

{log} = Neft

TARGET = 'local'

PROCESS_OPTIONS =
    silent: true

getInitPath = ->
    pathUtils.join __dirname, './local/initFile.js'

runTestsInProcess = (logsReader, callback) ->
    log.info 'running local tests'
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

exports.run = (env, logsReader, callback) ->
    testsFile.saveBuildTestsFile TARGET, (err) ->
        if err
            return callback err
        runTestsInProcess logsReader, callback
