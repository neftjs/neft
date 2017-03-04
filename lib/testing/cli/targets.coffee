'use strict'

config = require './config'
processLogs = require './processLogs'

{log} = Neft

getEnvTarget = (env) ->
    unless env.platform in ['local', 'npm']
        env.platform

getEnvHandler = (env) ->
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
        when 'browser'
            switch env.browser
                when 'chrome'
                    require '../env/chrome'
                else
                    throw new Error "Unsupported browser '#{env.browser}'"
        else
            throw new Error "Unsupported environment '#{env.platform}'"

targetsToBuild = {}
envQueue = []

for env in config.getEnabledConfigEnvironments()
    if buildTarget = getEnvTarget(env)
        targetsToBuild[buildTarget] = env
    envQueue.push env: env, handler: getEnvHandler(env)

exports.getTargetsToBuild = ->
    targetsToBuild

exports.runEnvs = (callback) ->
    runNext = ->
        unless envCfg = envQueue.shift()
            return callback null
        name = envCfg.handler.getName envCfg.env
        log.info "\n▶️  #{name}"
        iconIndex = -1
        logsReader = new processLogs.LogsReader name
        envCfg.handler.run envCfg.env, logsReader, (err) ->
            if err
                return callback err
            runNext()
    runNext()
