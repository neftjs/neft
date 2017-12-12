'use strict'

fs = require 'fs-extra'
cliUtils = require '../utils'

local = require './build/local'
watchServer = require './build/watchServer'
build = require './build/build'
watch = require './build/watch'
utils = require 'src/utils'
log = require 'src/log'
Networking = require 'src/networking'

startWatcher = (watchHandler, buildsStack, platform, options) ->
    watch platform, options, (buildOptions, onBuilt) ->
        buildsStack.add (callback) ->
            build platform, buildOptions, (err, result) ->
                watchHandler.send platform, result
                onBuilt result
                callback err
        unless buildsStack.pending
            buildsStack.runAll utils.NOP

startWatchers = (options) ->
    networking = new Networking utils.merge
        type: Networking.HTTP
        language: 'en'
        allowAllOrigins: true
    , options.buildServer

    watchHandler = watchServer.start networking
    buildsStack = new utils.async.Stack

    for platform in options.platforms
        startWatcher watchHandler, buildsStack, platform, options
    return

module.exports = (options, callback) ->
    unless cliUtils.verifyNeftProject('./')
        return

    data = utils.clone options
    data.cwd = fs.realpathSync '.'

    local.normalizeLocalFile()
    local = local.getLocal()

    if data.watch
        data.buildServer = local.buildServer
        data.buildServerUrl = local.buildServer.url

    stack = new utils.async.Stack

    for platform in data.platforms
        stack.add build, null, [platform, data]

    stack.runAll (err, result) ->
        if data.watch
            data.lastResult = result
            startWatchers data
        callback err
