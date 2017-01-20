'use strict'

config = require './config'
processLogs = require './processLogs'
logger = require './logger'

LOGGER_TEST_ICONS = ['🌕', '🌖', '🌗', '🌘', '🌑', '🌒', '🌓', '🌔']

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
    # 🎞
    runNext = ->
        unless envCfg = envQueue.shift()
            return callback null
        name = envCfg.handler.getName envCfg.env
        iconIndex = -1
        logger.changeGroup name, "⌛️  #{name}"
        logsReader = new processLogs.LogsReader name
        logsReader.onTest ->
            iconIndex = (iconIndex + 1) % LOGGER_TEST_ICONS.length
            icon = LOGGER_TEST_ICONS[iconIndex]
            logger.changeGroup name, "#{icon}  #{name}",
        envCfg.handler.run envCfg.env, logsReader, (err) ->
            if err
                logger.changeGroup name, "❌  #{name}", 'red'
                return callback err
            logger.changeGroup name, "🎉  #{name}", 'green'
            runNext()
    runNext()
