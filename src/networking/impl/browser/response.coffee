'use strict'

Document = require 'src/document'

module.exports = (Networking, impl) ->
    uriPop = false
    window.addEventListener 'popstate', ->
        uriPop = true

    send: (res, data, callback) ->
        # render data
        if data instanceof Document
            # change browser URI in the history
            if uriPop
                uriPop = false
            else
                history.pushState null, '', res.request.uri

        callback()

    setHeader: ->

    redirect: (res, status, uri, callback) ->
        impl.changePage uri
        callback()
