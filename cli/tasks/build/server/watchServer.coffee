'use strict'

fs = require 'fs'
Networking = require 'src/networking'
utils = require 'src/utils'
signal = require 'src/signal'

PLATFORM_BUNDLE_PATH =
    browser: './build/app-browser-develop.js'
    ios: './build/ios/neft.js'
    macos: './build/macos/neft.js'
    android: './build/android/app/src/main/assets/javascript/neft.js'

getFileBundle = (platform) ->
    fs.readFileSync PLATFORM_BUNDLE_PATH[platform], 'utf-8'

exports.start = (networking) ->
    # manage listeners
    onBundleSignals =
        browser: signal.create()
        ios: signal.create()
        macos: signal.create()
        android: signal.create()
    onSend = (platform, result) ->
        unless onBundleSignals[platform]
            return
        onBundleSignals[platform].emit result.hotReloads
        onBundleSignals[platform].disconnectAll()


    ###
    Request: onNewBundle
    Responses with no data when build change or an object with hotReloads.
    ###
    networking.createHandler
        method: 'get'
        uri: 'onNewBundle/{platform}'
        callback: (req, res, next) ->
            {platform} = req.params
            onBundleSignals[platform].connect (hotReloads) ->
                if res.pending
                    if hotReloads
                        res.send 200, JSON.stringify hotReloads: hotReloads
                    else
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
    send: onSend
