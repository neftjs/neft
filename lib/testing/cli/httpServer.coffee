'use strict'

httpServer = require 'http-server'
config = require './config'

{log} = Neft

server = null

exports.isRun = ->
    server?

exports.runHttpServer = (callback) ->
    if server
        return callback()

    {port, host} = config.getConfig().browserHttpServer

    log.info "Running HTTP server for client tests on `#{host}:#{port}`"
    server = httpServer.createServer
        root: './build/'
    server.listen port, host, ->
        callback()
    server

exports.closeServer = ->
    server?.close()
