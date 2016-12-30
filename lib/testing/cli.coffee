'use strict'

global.Neft = require 'cli/bundle/neft-node-develop'

builder = require './cli/builder'
httpServer = require './cli/httpServer'
testsFile = require './cli/testsFile'
chromeEnv = require './env/chrome'

config = require './cli/config'

{log} = Neft

getEnvTarget = (env) ->
    unless env.platform in ['local']
        env.platform

getEnvHandler = (env) ->
    switch env.platform
        when 'local'
            require './env/local'
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
server = null

for env in config.getEnabledConfigEnvironments()
    if buildTarget = getEnvTarget env
        targetsToBuild[buildTarget] = true
    envQueue.push env: env, handler: getEnvHandler(env)

buildProjects = (callback) ->
    targets = Object.keys targetsToBuild
    buildNext = (err) ->
        if err
            return callback err
        unless target = targets[0]
            return callback()
        if target is 'browser' and not server
            server = httpServer.runHttpServer buildNext
            return
        targets.shift()
        testsFile.saveBuildTestsFile target, (err) ->
            if err
                return callback err
            builder.buildProject target, buildNext
    buildNext()

runEnvs = (callback) ->
    runNext = (err) ->
        if err
            return callback err
        unless envCfg = envQueue.shift()
            return callback null
        envCfg.handler.run envCfg.env, runNext
    runNext()

reportAndExit = (err) ->
    if err
        log.error 'All tests ended: FAILURE'
        process.exit 1
    else
        log.ok 'All tests ended: SUCCESS'
        process.exit 0

buildProjects (err) ->
    if err
        return reportAndExit err
    runEnvs (err) ->
        server?.close()
        reportAndExit err
