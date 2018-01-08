'use strict'

config = require './config'
processLogs = require './processLogs'
builder = require './builder'
testsFile = require './testsFile'
httpServer = require './httpServer'

{log} = Neft

HTTP_BASED_PLATFORMS =
    html: true
    webgl: true

getEnvTarget = (env) ->
    unless env.platform in ['local', 'npm']
        env.platform

exports.getEnvHandler = (env) ->
    switch env.platform
        when 'local'
            require '../env/local'
        when 'npm'
            require '../env/npm'
        when 'node'
            if env.version is 'current'
                require '../env/node'
            else
                require '../env/nvm'
        when 'html', 'webgl'
            switch env.browser
                when 'chrome'
                    require '../env/chrome'
                else
                    throw new Error "Unsupported browser '#{env.browser}'"
        when 'android'
            require '../env/android'
        when 'ios'
            require '../env/ios'
        when 'macos'
            require '../env/macos'
        else
            throw new Error "Unsupported environment '#{env.platform}'"

targetsToBuild = {}
envQueue = []

for env in config.getEnabledConfigEnvironments()
    if buildTarget = getEnvTarget(env)
        targetsToBuild[buildTarget] = env
    envQueue.push env: env, handler: exports.getEnvHandler(env)

buildProject = (env, callback) ->
    target = getEnvTarget env
    if target
        builder.buildProject target, env, callback
    else
        callback null

exports.runEnvs = (callback) ->
    buildAndRun = (name, envCfg) ->
        buildProjectStep = (callback) ->
            buildProject envCfg.env, (err) ->
                if err
                    return callback err
                prepareTestsStep callback

        prepareTestsStep = (callback) ->
            if typeof envCfg.handler.build is 'function'
                log.log ''
                log.log "📦 **Preparing #{getEnvTarget(env)}**"
                envCfg.handler.build envCfg.env, (err) ->
                    if err
                        return callback err
                    runTestsStep callback
            else
                runTestsStep callback

        runTestsStep = (callback) ->
            log.log ''
            log.info "**#{name}**"
            logsReader = new processLogs.LogsReader name
            envCfg.handler.run envCfg.env, logsReader, (err) ->
                if err# or logsReader.errors.length > 0
                    return callback err
                runNext()

        testsFile.saveBuildTestsFile envCfg.env.platform, (err) ->
            if err
                return callback err
            buildProjectStep callback

    runNext = ->
        unless envCfg = envQueue.shift()
            return callback null
        name = envCfg.handler.getName envCfg.env
        iconIndex = -1

        httpServer.closeServer()

        if HTTP_BASED_PLATFORMS[envCfg.env.platform]
            httpServer.runHttpServer envCfg.env.platform, ->
                buildAndRun name, envCfg
        else
            buildAndRun name, envCfg

        return

    runNext()
