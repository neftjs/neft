'use strict'

fs = require 'fs-extra'
cliUtils = require '../utils'
chokidar = require 'chokidar'
notifier = require 'node-notifier'
pathUtils = require 'path'

{utils, log} = Neft

parseApp = require './build/parse'
createBundle = require './build/bundle'
saveBundle = require './build/saveBundle'
watchServer = require './build/watchServer'

NOTIFY_ICON_PATH = pathUtils.join __dirname, '../../media/logo-white.png'

DEFAULT_LOCAL_FILE =
    watchServer:
        general:
            protocol: 'http'
            host: 'localhost'
        ios:
            port: 3010
        android:
            port: 3011
        browser:
            port: 3012
    android:
        sdkDir: '$ANDROID_HOME'
        compileSdkVersion: 23
        buildToolsVersion: '23'
        dependencies: [
            'com.android.support:appcompat-v7:23.0.0'
        ]

clear = (platform, callback) ->
    fs.remove './index.js', callback

watch = (platform, options, callback) ->
    changedFiles = []
    buildBundleOnly = false
    isWaiting = false
    isPending = false
    shouldBuildAgain = false

    ignored = '^(?:build|index\.js|local\.json|node_modules)|\.git'
    if options.out
        ignored += "|#{options.out}"

    update = ->
        isWaiting = false
        if isPending
            shouldBuildAgain = true
            return

        console.log ''
        isPending = true
        buildOptions = utils.mergeAll {}, options,
            changedFiles: changedFiles
            buildBundleOnly: buildBundleOnly
        changedFiles = []
        buildBundleOnly = true
        build platform, buildOptions, (err) ->
            isPending = false
            callback err

            if shouldBuildAgain
                shouldBuildAgain = false
                update()

    chokidar.watch('.', ignored: new RegExp(ignored)).on 'all', (event, path) ->
        if event is 'change'
            changedFiles.push fs.realpathSync path
        unless isWaiting
            setTimeout update, 200
            isWaiting = true
        return
    return

build = (platform, options, callback) ->
    # create build folder
    fs.ensureDirSync './build'

    stack = new utils.async.Stack
    args = [platform, options, null]

    # create temporary 'index.js' file
    stack.add ((platform, options, callback) ->
        parseApp platform, options, (err, app) ->
            args[2] = app
            callback err
    ), null, args

    # create bundle files
    stack.add createBundle, null, args

    # save output if needed
    if options.out
        stack.add saveBundle, null, args

    # clear
    stack.add clear, null, args

    # notify
    if options.notify
        callback = do (callback) -> (err) ->
            notifier.notify
                title: 'Neft'
                icon: NOTIFY_ICON_PATH
                subtitle: if err then 'Error' else ''
                message: if err then err.name or err else 'Build ready'
            callback err

    # run
    stack.runAll callback

module.exports = (platform, options, callback) ->
    unless cliUtils.verifyNeftProject('./')
        return

    # normalize local.json file
    if fs.existsSync('./local.json')
        localFile = JSON.parse fs.readFileSync './local.json', 'utf-8'
        local = {}
        utils.mergeDeep local, DEFAULT_LOCAL_FILE
        utils.mergeDeep local, localFile
    else
        local = DEFAULT_LOCAL_FILE
    fs.writeFileSync './local.json', JSON.stringify(local, null, 4)

    # watch for changes
    if options.watch
        # get local file
        try
            local = require 'local.json'
            watchServerConfig = {}
            utils.merge watchServerConfig, local.watchServer.general
            utils.merge watchServerConfig, local.watchServer[platform]
        catch err
            throw new Error 'File local.json must specify watchServer config'
            return

        try
            runServer = watchServer.start watchServerConfig, platform
        catch err
            return callback err
        callbackCalled = false
        options.watchServerConfig = watchServerConfig
        watch platform, options, (err) ->
            unless err
                runServer.send()
            unless callbackCalled
                callbackCalled = true
                callback err
        return

    build platform, options, callback
