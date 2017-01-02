'use strict'

config = require './cli/config'

{utils, Networking, signal} = Neft

exports.onInitializeScreenshots = signal.create()
exports.onScreenshot = signal.create()

exports.startServer = ->
    networking = new Networking utils.merge
        type: Networking.HTTP
        language: 'en'
        allowAllOrigins: true
    , config.getConfig().server

    networking.createHandler
        method: 'options'
        uri: '*'
        callback: (req, res) ->
            res.send 200

    networking.createHandler
        method: 'post'
        uri: 'initializeScreenshots'
        callback: (req, res) ->
            try
                exports.onInitializeScreenshots.emit req.data
            catch err
                res.raise err?.message or err
                return
            res.send 200

    networking.createHandler
        method: 'post'
        uri: 'takeScreenshot'
        callback: (req, res) ->
            try
                exports.onScreenshot.emit req.data
            catch err
                res.raise err?.message or err
                return
            res.send 200

    return
