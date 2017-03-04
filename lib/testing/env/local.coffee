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
        unless logsReader.terminated
            mainErr ?= "Local tests terminated before all tests ended"
        callback mainErr or logsReader.error

exports.getName = ->
    "Local tests"

exports.run = (env, logsReader, callback) ->
    testsFile.saveBuildTestsFile TARGET, (err) ->
        if err
            return callback err
        runTestsInProcess logsReader, callback
