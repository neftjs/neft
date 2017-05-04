'use strict'

httpServer = require 'http-server'
config = require './config'

{log} = Neft

server = null

exports.isRun = ->
    server?

exports.runHttpServer = (target, callback) ->
    if server
        return callback()

    {port, host} = config.getConfig().browserHttpServer

    log.info "\n📡  Running HTTP server for #{target} tests on `#{host}:#{port}`"
    server = httpServer.createServer
        root: "./build/#{target}"
    server.listen port, host, ->
        callback()
    server

exports.closeServer = ->
    server?.close()
    server = null
