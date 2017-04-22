'use strict'

config = require './config'
processLogs = require './processLogs'
builder = require './builder'
testsFile = require './testsFile'

{log} = Neft

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
        when 'browser', 'webgl'
            switch env.browser
                when 'chrome'
                    require '../env/chrome'
                else
                    throw new Error "Unsupported browser '#{env.browser}'"
        when 'android'
            require '../env/android'
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
    runNext = ->
        unless envCfg = envQueue.shift()
            return callback null
        name = envCfg.handler.getName envCfg.env
        iconIndex = -1
        logsReader = new processLogs.LogsReader name
        testsFile.saveBuildTestsFile envCfg.env.platform, (err) ->
            if err
                return callback err
            buildProject envCfg.env, (err) ->
                if err
                    return callback err
                log.info "\n▶️  #{name}"
                envCfg.handler.run envCfg.env, logsReader, (err) ->
                    if err
                        return callback err
                    runNext()
    runNext()
