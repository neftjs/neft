'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
childProcess = require 'child_process'
config = require './config'
testsFile = require './testsFile'
httpServer = require './httpServer'

{utils, log} = Neft

NEFT_BIN_PATH = pathUtils.join __dirname, '../../../bin/neft.js'

BUILD_ARGS = [
    'build',
    '',
    "--init-file=#{config.getInitFilePath()}",
    '--out=',
    '--config='
]

BUILD_OPTIONS =
    silent: true
    env:
        RUN_TESTS: false

BUILD_LOG_PREFIX = '   '

###
Builds Neft app for the given target.
See `neft help` for available targets.
Callback function is called when build is ready.
###
exports.buildProject = (target, env, callback) ->
    args = utils.clone BUILD_ARGS
    args[1] = target # target
    args[3] += config.getPlatformOutFolder(target) # out
    args[4] += JSON.stringify # config
        testingServerUrl: config.getServerUrl()
        environment: env
    error = null
    buildProcess = childProcess.fork NEFT_BIN_PATH, args, BUILD_OPTIONS
    buildProcess.stdout.on 'data', (data) ->
        log BUILD_LOG_PREFIX + String(data).trim()
    buildProcess.stderr.on 'data', (data) ->
        error = String(data).trim()
        log.error TAG, error
        buildProcess.kill()
    buildProcess.on 'exit', ->
        callback error
    return

exports.buildProjects = (targetsToBuild, callback) ->
    targets = Object.keys targetsToBuild

    builtAmount = 0
    buildNext = (err) ->
        if err
            return callback err

        unless target = targets[0]
            return callback()

        if target is 'browser' and not httpServer.isRun()
            builtAmount -= 1
            httpServer.runHttpServer buildNext
            return

        builtAmount += 1
        log.info "\n✏️  Building #{target} [#{builtAmount}/#{targets.length}]"

        targets.shift()
        testsFile.saveBuildTestsFile target, (err) ->
            if err
                return callback err
            env = targetsToBuild[target]
            exports.buildProject target, env, buildNext

    buildNext()
    return
