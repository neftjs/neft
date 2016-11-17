'use strict'

local = require '../local'
watchServer = require './watchServer'
build = require './build'
watch = require './watch'
utils = require 'src/utils'
log = require 'src/log'
Networking = require 'src/networking'

runServer = ->
    LOCAL = local.getLocal()

    networking = new Networking utils.merge
        type: Networking.HTTP
        language: 'en'
        allowAllOrigins: true
    , LOCAL.buildServer

    BUILD_SERVER_URL = do (config = LOCAL.buildServer) ->
        config.protocol + '://' +
        config.host + ':' +
        config.port

    prepareBuildOptions = (options) ->
        if options.watch
            utils.merge buildServerUrl: BUILD_SERVER_URL, options
        else
            options
        options

    watchHandler = watchServer.start networking

    buildsStack = new utils.async.Stack
    watchers = Object.create null
    watchersCount = Object.create null

    startWatcher = (platform, options) ->
        watchersCount[platform] ?= 0
        watchersCount[platform] += 1
        if watchersCount[platform] > 1
            return
        watchers[platform] = watch platform, options, (buildOptions, onBuilt) ->
            buildsStack.add (callback) ->
                buildOptions = prepareBuildOptions buildOptions
                build platform, buildOptions, (err) ->
                    watchHandler.send platform
                    onBuilt null
                    callback err
            unless buildsStack.pending
                buildsStack.runAll utils.NOP

    stopWatcher = (platform, options) ->
        watchersCount[platform] += 1
        if watchersCount[platform] > 1
            return
        watchers[platform]?.close()

    startWatchers = (options) ->
        for platform in options.platforms
            startWatcher platform, options
        return

    stopWatchers = (options) ->
        for platform in options.platforms
            stopWatcher platform, options
        return

    # handler called to check whether server is running
    networking.createHandler
        method: 'post'
        uri: 'ping'
        callback: (req, res) ->
            res.send 200

    # handler called when app needs to be built
    networking.createHandler
        method: 'post'
        uri: 'build'
        callback: (req, res) ->
            {data} = req
            stack = new utils.async.Stack
            data = prepareBuildOptions data
            for platform in data.platforms
                stack.add build, null, [platform, data]
            buildsStack.add (callback) ->
                stack.runAll (err) ->
                    callback err
                    if err
                        res.send 500, utils.errorToObject(err)
                    else
                        if data.watch
                            startWatchers data
                        res.send 200
            unless buildsStack.pending
                buildsStack.runAll utils.NOP

    # handler called on CLI killed
    networking.createHandler
        method: 'post'
        uri: 'stopBuild'
        callback: (req, res) ->
            stopWatchers req.data
            res.send 200

    # handler called on this process kill
    networking.createHandler
        method: 'post'
        uri: 'onTerminate'
        callback: (req, res) ->
            process.on 'exit', ->
                res.send 200

isRunning = (onTrue, onFalse) ->
    LOCAL = local.getLocal()
    Networking.createRequest
        method: 'post'
        uri: "#{LOCAL.buildServer.url}ping"
        onLoadEnd: (err) ->
            if err
                onFalse()
            else
                onTrue()

exports.runIfNeeded = (callback) ->
    onRunning = ->
        log.info 'Build request is running on the first run CLI process'
        callback()
    onNotRunning = ->
        runServer()
        endWhenRunning = ->
            isRunning callback, endWhenRunning
        endWhenRunning()
    isRunning onRunning, onNotRunning
