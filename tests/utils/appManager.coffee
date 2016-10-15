'use strict'

fs = require 'fs'
cp = require 'child_process'
pathUtils = require 'path'

{utils, signal, log} = Neft
log = log.scope 'app'

NEFT_BIN_PATH = fs.realpathSync './bin/neft.js'
BUILD_OPTIONS = ['--with-tests']
exports.APP_PORT = 9999

class BuiltApp
    constructor: (@path, @platform) ->
        @pending = true
        @onBuilt = signal.create()
        @error = null

builtApps = {}

prepareAppConfig = (appPath) ->
    packagePath = pathUtils.join appPath, '/package.json'
    config = require packagePath
    config.config.port = exports.APP_PORT
    config.config.url = "http://localhost:#{exports.APP_PORT}"
    json = JSON.stringify config, null, 2
    fs.writeFileSync packagePath, json

buildApp = (builtApp, platformResolver, callback) ->
    log "build #{builtApp.platform}"
    prepareAppConfig builtApp.path
    argv = ['build', builtApp.platform, BUILD_OPTIONS...]
    child = cp.fork NEFT_BIN_PATH, argv, cwd: builtApp.path, silent: true
    child.stderr.on 'data', (data) ->
        log.error data
    child.on 'exit', (code) ->
        if code is 1
            error = new Error "Cannot build project `#{builtApp.path}`"
        builtApp.pending = false
        builtApp.error = error
        callback null

        if error
            return builtApp.onBuilt.emit error
        unless platformResolver
            return builtApp.onBuilt.emit error, builtApp
        platformResolver builtApp.path, (err, customData) ->
            if customData?
                builtApp[builtApp.platform] = customData
            builtApp.onBuilt.emit err, builtApp

stack = new utils.async.Stack

exports.runCustomCliTask = (func, ctx, args) ->
    stack.add func, ctx, args
    unless stack.pending
        stack.runAll (err) ->
            if err then log.error err

exports.buildApp = (appPath, platform, platformResolver) ->
    builtApp = new BuiltApp appPath, platform

    builtApps[appPath] ?= {}
    builtApps[appPath][platform] = builtApp

    exports.runCustomCliTask buildApp, null, [builtApp, platformResolver]
    return

exports.onAppBuilt = (appPath, platform, callback) ->
    builtApp = builtApps[appPath][platform]
    if builtApp.pending
        log 'waiting for build'
        builtApp.onBuilt.connect callback
    else
        callback builtApp.error, builtApp

class AppServer
    constructor: (@path, @child) ->
    close: ->
        log 'terminate app server'
        @child.send 'terminate'

runAppServer = (appServer, onStart, onExit) ->
    log 'run app server'
    prepareAppConfig appServer.path
    child = cp.fork NEFT_BIN_PATH, ['run', 'node'], cwd: appServer.path, silent: true
    appServer.child = child
    callbackCalled = false
    stdout = ''
    child.stdout.on 'data', (data) ->
        stdout += data
        if not callbackCalled and utils.has(stdout, 'Start as')
            callbackCalled = true
            onStart null, appServer
    child.stderr.on 'data', (data) ->
        log.error data
    child.on 'exit', (code) ->
        log 'app server stopped'
        unless callbackCalled
            callbackCalled = true
            onStart new Error code
        onExit null
    child

exports.runAppServer = (appPath, callback) ->
    runAppServerWrapper = (appServer, innerCallback) ->
        onStart = (err) ->
            if err then log.error err
            callback err, appServer
        onExit = (err) ->
            innerCallback err
        runAppServer appServer, onStart, onExit

    appServer = new AppServer appPath, null
    exports.runCustomCliTask runAppServerWrapper, null, [appServer]
    return
