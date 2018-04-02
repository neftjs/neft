`// when=NEFT_IOS`

'use strict'

utils = require 'src/utils'

module.exports = (Networking) ->
    impl = Object.create null
    requests = Object.create null

    ios.httpResponseCallback = (id, error, code, resp, headers) ->
        unless request = requests[id]
            return
        delete requests[id]

        error = utils.tryFunction JSON.parse, null, [error], error
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
        requestAnimationFrame ->
            networking.createLocalRequest
                method: Networking.Request.GET
                type: Networking.Request.HTML_TYPE
                uri: '/'
        return

    ###
    Send a XHR request and call `callback` on response.
    ###
    sendRequest: (req, res, callback) ->
        headers = []
        for name, val of req.headers
            headers.push name, val
        headers.push 'content-type', 'text/plain'
        headers.push 'charset', 'utf-8'
        headers.push 'x-expected-type', req.type

        if cookies = utils.tryFunction(JSON.stringify, null, [req.cookies], null)
            headers.push 'x-cookies', cookies

        # parse data
        {data} = req
        switch typeof data
            when 'undefined'
                data = null
            when 'string'
                # NOP
            else
                data = utils.tryFunction JSON.stringify, null, [data], String(data)

        id = ios.httpRequest req.uri, req.method, headers, data

        requests[id] =
            type: req.type
            callback: callback
        return
