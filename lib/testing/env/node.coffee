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

exports.getName = ->
    "Node tests"

exports.execFile = (path, logsReader, callback) ->
    mainErr = null
    nodeProcess = childProcess.fork path, PROCESS_OPTIONS
    nodeProcess.stdout.on 'data', (data) ->
        logsReader.log data
        if logsReader.terminated
            nodeProcess.kill()
    nodeProcess.stderr.on 'data', (data) ->
        log.error String(data).trim()
    nodeProcess.on 'exit', ->
        unless logsReader.terminated
            mainErr ?= "Node tests terminated before all tests ended"
        callback mainErr or logsReader.error

exports.run = (env, logsReader, callback) ->
    exports.execFile getInitPath(env), logsReader, callback
