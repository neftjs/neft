'use strict'

fs = require 'fs'
Networking = require 'src/networking'
utils = require 'src/utils'
signal = require 'src/signal'

PLATFORM_BUNDLE_PATH =
    browser: './build/app-browser-develop.js'
    ios: './build/ios/neft.js'
    android: './build/android/app/src/main/assets/javascript/neft.js'

getFileBundle = (platform) ->
    fs.readFileSync PLATFORM_BUNDLE_PATH[platform], 'utf-8'

exports.start = (networking) ->
    # manage listeners
    onBundleSignals =
        browser: signal.create()
        ios: signal.create()
        android: signal.create()
    onSend = (platform) ->
        unless onBundleSignals[platform]
            return
        onBundleSignals[platform].emit()
        onBundleSignals[platform].disconnectAll()

    ###
    Request: newBundle
    Responses with bundle code when build change.
    ###
    networking.createHandler
        method: 'get'
        uri: 'newBundle/{platform}'
        callback: (req, res, next) ->
            {platform} = req.params
            onBundleSignals[platform].connect ->
                if res.pending
                    res.send 200, getFileBundle(req.params.platform)


    ###
    Request: onNewBundle
    Responses with no data when build change.
    ###
    networking.createHandler
        method: 'get'
        uri: 'onNewBundle/{platform}'
        callback: (req, res, next) ->
            {platform} = req.params
            onBundleSignals[platform].connect ->
                if res.pending
                    res.send 200, ''

    ###
    Request: bundle
    Responses with bundle code immediately.
    ###
    networking.createHandler
        method: 'get'
        uri: 'bundle/{platform}'
        callback: (req, res, next) ->
            res.send 200, getFileBundle(req.params.platform)

    # exported API
    send: (platform) ->
        onSend platform
