'use strict'

httpServer = require 'http-server'
config = require './config'

{log} = Neft

exports.runHttpServer = (callback) ->
    {port, host} = config.getConfig().browserHttpServer

    log.info 'HTTP server running'
    server = httpServer.createServer
        root: './build/browser'
    server.listen port, host, ->
        log.info 'HTTP server run'
        callback()
    server
