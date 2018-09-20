'use strict'

module.exports = (Networking, impl) ->
    send: (res, data, callback) ->
        callback()

    setHeader: ->

    redirect: (res, status, uri, callback) ->
        impl.networking.createLocalRequest
            method: Networking.Request.GET
            type: Networking.Request.HTML_TYPE
            uri: uri
        callback()
