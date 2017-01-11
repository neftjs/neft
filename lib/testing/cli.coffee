'use strict'

global.Neft = require 'cli/bundle/neft-node-develop'

builder = require './cli/builder'
httpServer = require './cli/httpServer'
testsFile = require './cli/testsFile'
chromeEnv = require './env/chrome'
processLogs = require './cli/processLogs'
screenshot = require './screenshot/server'
server = require './server'

config = require './cli/config'

{log} = Neft

getEnvTarget = (env) ->
    unless env.platform in ['local', 'npm']
        env.platform

getEnvHandler = (env) ->
    switch env.platform
        when 'local'
            require './env/local'
        when 'npm'
            require './env/npm'
        when 'node'
            if env.version is 'current'
                require './env/node'
            else
                require './env/nvm'
        when 'browser'
            switch env.browser
                when 'chrome'
                    require './env/chrome'
                else
                    throw new Error "Unsupported browser '#{env.browser}'"
        else
            throw new Error "Unsupported environment '#{env.platform}'"

targetsToBuild = {}
envQueue = []
httpServerProcess = null

for env in config.getEnabledConfigEnvironments()
    if buildTarget = getEnvTarget(env)
        targetsToBuild[buildTarget] = env
    envQueue.push env: env, handler: getEnvHandler(env)

buildProjects = (callback) ->
    targets = Object.keys targetsToBuild
    buildNext = (err) ->
        if err
            return callback err
        unless target = targets[0]
            return callback()
        if target is 'browser' and not httpServerProcess
            httpServerProcess = httpServer.runHttpServer buildNext
            return
        targets.shift()
        testsFile.saveBuildTestsFile target, (err) ->
            if err
                return callback err
            env = targetsToBuild[target]
            builder.buildProject target, env, buildNext
    buildNext()

runEnvs = (callback) ->
    runNext = (err) ->
        if err
            return callback err
        unless envCfg = envQueue.shift()
            return callback null
        logsReader = new processLogs.LogsReader
        envCfg.handler.run envCfg.env, logsReader, runNext
    runNext()

reportAndExit = (err) ->
    if err
        log.error err
        log.error 'All tests ended: FAILURE'
        process.exit 1
    else
        log.ok 'All tests ended: SUCCESS'
        process.exit 0

server.startServer()
buildProjects (err) ->
    if err
        return reportAndExit err
    runEnvs (err) ->
        httpServerProcess?.close()
        reportAndExit err
