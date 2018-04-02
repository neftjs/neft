'use strict'

fs = require 'fs'
cliUtils = require 'cli/utils'

{utils} = Neft

DEFAULT_LOCAL_FILE =
    buildServer:
        protocol: 'http'
        host: 'localhost'
        port: 3001
    android:
        sdkDir: '$ANDROID_HOME'
        compileSdkVersion: 25
        targetSdkVersion: 25
        buildToolsVersion: '25'
        dependencies: []

exports.normalizeLocalFile = ->
    if fs.existsSync('./local.json')
        localFile = JSON.parse fs.readFileSync './local.json', 'utf-8'
        local = {}
        utils.mergeDeep local, DEFAULT_LOCAL_FILE
        utils.mergeDeep local, localFile
    else
        local = DEFAULT_LOCAL_FILE
    fs.writeFileSync './local.json', JSON.stringify(local, null, 4)

exports.getLocal = ->
    local = require 'local.json'

    # change localhost to local ips
    # most devices can't link `localhost` to the host machine
    local.buildServer.host = cliUtils.getValidHost local.buildServer.host

    # buildServer url
    local.buildServer.url = do ->
        "#{local.buildServer.protocol}://" +
        "#{local.buildServer.host}:" +
        "#{local.buildServer.port}"

    local
