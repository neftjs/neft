'use strict'

fs = require 'fs'
Networking = require 'src/networking'
utils = require 'src/utils'

PLATFORM_BUNDLE_PATH =
    browser: './build/app-browser-develop.js'
    ios: './build/ios/neft.js'

getFileBundle = (platform) ->
    fs.readFileSync PLATFORM_BUNDLE_PATH[platform], 'utf-8'

exports.start = (serverConfig, platform) ->
    # create server
    networking = new Networking utils.merge
        type: Networking.HTTP
        language: 'en'
        accessAllOrigins: true
    , serverConfig

    # create options handler
    networking.createHandler
        method: 'options'
        uri: 'newBundle'
        callback: (req, res, next) ->
            res.send 200, 'OK'

    # create get handler
    onSend = ->
    networking.createHandler
        method: 'get'
        uri: 'newBundle'
        callback: (req, res, next) ->
            onSend = ->
                if res.pending
                    res.send 200, getFileBundle(platform)

    # exported API
    send: ->
        onSend()
