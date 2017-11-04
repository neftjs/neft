`// when=NEFT_MACOS`

'use strict'

utils = require 'src/utils'

module.exports = (Networking) ->
    impl = Object.create null
    requests = Object.create null
    lastId = 0

    __macos__.networkingHandler = (id, error, code, resp, headers) ->
        unless request = requests[id]
            return
        delete requests[id]

        if request.type is Networking.Request.JSON_TYPE
            resp = utils.tryFunction JSON.parse, null, [resp], resp
        cookies = utils.tryFunction JSON.parse, null, [headers?['X-Cookies']], null

        request.callback
            status: code
            data: resp or error
            headers: headers
            cookies: cookies
        return

    Request: require('./request.coffee') Networking, impl
    Response: require('./response.coffee') Networking, impl

    init: (networking) ->
        impl.networking = networking
        __macos__.onLoad = ->
            networking.createLocalRequest
                method: Networking.Request.GET
                type: Networking.Request.HTML_TYPE
                uri: '/'
            return
        return

    ###
    Send a XHR request and call `callback` on response.
    ###
    sendRequest: (req, res, callback) ->
        headers = {}
        for name, val of req.headers
            headers[name] = String val
        headers['content-type'] = 'text/plain'
        headers['charset'] = 'utf-8'
        headers['x-expected-type'] = req.type

        if cookies = utils.tryFunction(JSON.stringify, null, [req.cookies], null)
            headers['x-cookies'] = cookies

        # parse data
        {data} = req
        switch typeof data
            when 'undefined'
                data = null
            when 'string'
                # NOP
            else
                data = utils.tryFunction JSON.stringify, null, [data], String(data)

        if data and typeof data is 'string'
            headers['content-length'] = String data.length

        id = ++lastId
        webkit.messageHandlers.networking.postMessage
            id: id
            uri: String req.uri
            method: req.method
            headers: headers
            data: data

        requests[id] =
            type: req.type
            callback: callback
        return
