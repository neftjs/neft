'use strict'

fs = require 'fs'
yaml = require 'js-yaml'
pathUtils = require 'path'
childProcess = require 'child_process'
slash = require 'slash'

{utils} = Neft

CONFIG_FILE_PATHS = [
    'testing.json',
    'testing.yaml',
    'testing.yml'
]

DEFAULT_CONFIG =
    browserHttpServer:
        port: '8000'
        host: '0.0.0.0'
    environments: []

INIT_FILE_PATH = slash pathUtils.join __dirname, './initFile.coffee'

getConfigRawFile = ->
    for path in CONFIG_FILE_PATHS
        try return fs.readFileSync path, 'utf-8'
    null

getConfigFile = ->
    file = getConfigRawFile()
    if typeof file is 'string'
        yaml.safeLoad file
    else
        file

###
Returns parsed testing config file located in app folder.
Supported files:
 - testing.json,
 - testing.yaml,
 - testing.yml.
###
exports.getConfig = ->
    config = utils.mergeAll {}, DEFAULT_CONFIG, getConfigFile()
    config.environments ?= []
    config

###
Returns defined config environments.
Environments with 'enabled' property are removing when:
 - enabled is a false boolean,
 - given string executed in shell is falsy.
###
exports.getEnabledConfigEnvironments = ->
    environments = []
    for env in exports.getConfig().environments
        if env.enabled is false
            continue
        if typeof env.enabled is 'string'
            if env.enabled[0] is '$'
                unless process.env[env.enabled.slice(1)]
                    continue
            else
                echo = childProcess.execSync "echo #{env.enabled}"
                echo = String(echo).trim()
                try echo = JSON.parse echo
                unless echo
                    continue
        environments.push env
    environments

###
Returns URL used to serve static files through HTTP.
###
exports.getBrowserHttpServerUrl = ->
    {port, host} = exports.getConfig().browserHttpServer
    "http://#{host}:#{port}"

###
Returns path to init file.
Init file needs to be placed in 'tests' folder and be called 'init'.
###
exports.getInitFilePath = ->
    INIT_FILE_PATH

exports.getPlatformOutFolder = (target) ->
    "build/#{target}"

exports.getProcessEnv = ->
    try localConfig = JSON.parse fs.readFileSync './local.json', 'utf-8'
    utils.mergeAll {}, process.env, localConfig?.testing?.env
