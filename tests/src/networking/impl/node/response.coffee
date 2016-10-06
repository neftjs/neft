'use strict'

{unit, assert, utils} = Neft
{describe, it, beforeEach} = unit
ResponseImpl = require 'src/networking/impl/node/response'

describe 'src/networking/impl/node/response', ->
    beforeEach ->
        @headers = {}
        @uid = 'a1'
        @pending =
            "#{@uid}":
                serverReq:
                    method: 'OPTIONS'
                    headers: {}
                serverRes:
                    getHeader: -> null
                    setHeader: (name, val) => @headers[name] = val
                    end: ->
                networking:
                    url: 'debugUrl'
                    allowAllOrigins: false
        @impl = ResponseImpl null, @pending

    describe 'send()', ->
        describe 'Access-Control-Allow-Origin header', ->
            it 'is equal wildcard when allowAllOrigins is true', ->
                @pending[@uid].networking.allowAllOrigins = true
                res = request: uid: @uid, type: 'text'
                @impl.send res, '', utils.NOP
                assert.is @headers['Access-Control-Allow-Origin'], '*'

            it 'is equal url when allowAllOrigins is false', ->
                {url} = @pending[@uid].networking
                res = request: uid: @uid, type: 'text'
                @impl.send res, '', utils.NOP
                assert.is @headers['Access-Control-Allow-Origin'], url
