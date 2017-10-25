'use strict'

fs = require 'fs-extra'
cliUtils = require '../utils'
chokidar = require 'chokidar'
Networking = require 'src/networking'
utils = require 'src/utils'
log = require 'src/log'

local = require './build/local'
server = require './build/server'

module.exports = (options, callback) ->
    unless cliUtils.verifyNeftProject('./')
        return

    options.cwd = fs.realpathSync '.'

    local.normalizeLocalFile()
    LOCAL = local.getLocal()

    server.runIfNeeded ->
        process.stdin.resume()

        Networking.createRequest
            method: 'post'
            uri: "#{LOCAL.buildServer.url}build"
            data: options
            onLoadEnd: callback

        Networking.createRequest
            method: 'post'
            uri: "#{LOCAL.buildServer.url}onTerminate"
            onLoadEnd: (err) ->
                log.warn 'Master CLI process stops running'
                if err
                    log.error err
                unless options.isRunning
                    process.exit()

        process.on 'SIGINT', ->
            Networking.createRequest
                method: 'post'
                uri: "#{LOCAL.buildServer.url}stopBuild"
                data: options
                onLoadEnd: ->
                    process.exit()
