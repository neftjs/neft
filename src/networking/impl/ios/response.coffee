'use strict'

module.exports = (Networking) ->
    send: (res, data, callback) ->
        callback()

    setHeader: ->

    redirect: (res, status, uri, callback) ->
        networking.createLocalRequest
            method: Networking.Request.GET
            type: Networking.Request.HTML_TYPE
            uri: uri
        callback()
