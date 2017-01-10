'use strict'

fs = require 'fs'
testsFile = require '../cli/testsFile'
config = require '../cli/config'
childProcess = require 'child_process'
pathUtils = require 'path'
nodeEnv = require './node'
nvmEnv = require './nvm'

{log} = Neft

TARGET = 'npm'

PROCESS_OPTIONS =
    silent: true

PACKAGE_FILENAME = do ->
    packageFile = require fs.realpathSync './package.json'
    "#{packageFile.name}-#{packageFile.version}.tgz"

getInitPath = ->
    pathUtils.join __dirname, './local/initFile.js'

buildProject = (callback) ->
    log.info "creating npm package"
    childProcess.exec 'npm pack', (err) ->
        if err
            return callback err
        log.info "npm package created"
        callback null

installProjectOnNode = (env, callback) ->
    log.info "installing npm package"
    cmd = "npm install #{PACKAGE_FILENAME}"
    if env.global
        cmd += " -g"
    childProcess.exec cmd, (err, stdout, stderr) ->
        log.error stderr
        log stdout
        fs.unlinkSync PACKAGE_FILENAME
        log.info "npm package installed"
        callback null

installProjectOnNvm = (env, callback) ->
    log.info "installing npm package on nvm"
    cmd = "npm install #{PACKAGE_FILENAME}"
    if env.global
        cmd += " -g"
    nvmEnv.execCommand env.nodeVersion, cmd, null, (err) ->
        fs.unlinkSync PACKAGE_FILENAME
        log.info "npm package on nvm installed"
        callback null

runTestsInNodeProcess = (env, logsReader, callback) ->
    log.info 'running npm tests'
    nodeEnv.execFile getInitPath(), logsReader, (err) ->
        log.info 'npm tests terminated'
        callback err

runTestsInNvmProcess = (env, logsReader, callback) ->
    {nodeVersion} = env
    log.info "running npm tests on nvm using node #{nodeVersion}"
    nvmEnv.execCommand nodeVersion, "node #{getInitPath()}", logsReader, (err) ->
        log.info "npm tests on nvm using node #{nodeVersion} terminated"
        callback err

exports.run = (env, logsReader, callback) ->
    useNvm = env.nodeVersion isnt 'current'
    installProject = if useNvm then installProjectOnNvm else installProjectOnNode
    runTestsInProcess = if useNvm then runTestsInNvmProcess else runTestsInNodeProcess
    testsFile.saveBuildTestsFile TARGET, (err) ->
        if err
            return callback err
        buildProject (err) ->
            if err
                return callback err
            installProject env, (err) ->
                if err
                    return callback err
                runTestsInProcess env, logsReader, callback
