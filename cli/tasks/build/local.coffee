'use strict'

fs = require 'fs'

{utils} = Neft

DEFAULT_LOCAL_FILE =
    buildServer:
        protocol: 'http'
        host: 'localhost'
        port: 3001
    android:
        sdkDir: '$ANDROID_HOME'
        compileSdkVersion: 23
        buildToolsVersion: '23'
        dependencies: [
            'com.android.support:appcompat-v7:23.0.0'
        ]

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

    # buildServer url
    local.buildServer.url = do ->
        "#{local.buildServer.protocol}://" +
        "#{local.buildServer.host}:" +
        "#{local.buildServer.port}/"

    local
