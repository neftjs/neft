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

exports.start = (serverConfig, platform) ->
    # create server
    networking = new Networking utils.merge
        type: Networking.HTTP
        language: 'en'
        accessAllOrigins: true
    , serverConfig

    # allow browsers to request
    networking.createHandler
        method: 'options'
        uri: 'newBundle'
        callback: (req, res, next) ->
            res.send 200, 'OK'

    # manage listeners
    onBundleSignal = signal.create()
    onSend = ->
        onBundleSignal.emit()
        onBundleSignal.disconnectAll()

    ###
    Request: newBundle
    Responses with bundle code when build change.
    ###
    networking.createHandler
        method: 'get'
        uri: 'newBundle'
        callback: (req, res, next) ->
            onBundleSignal.connect ->
                if res.pending
                    res.send 200, getFileBundle(platform)


    ###
    Request: onNewBundle
    Responses with no data when build change.
    ###
    networking.createHandler
        method: 'get'
        uri: 'onNewBundle'
        callback: (req, res, next) ->
            onBundleSignal.connect ->
                if res.pending
                    res.send 200, ''

    ###
    Request: bundle
    Responses with bundle code immediately.
    ###
    networking.createHandler
        method: 'get'
        uri: 'bundle'
        callback: (req, res, next) ->
            res.send 200, getFileBundle(platform)

    # exported API
    send: ->
        onSend()
