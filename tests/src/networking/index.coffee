'use strict'

{unit, Networking, assert, utils} = Neft
{describe, it, beforeEach} = unit
{Impl} = Networking

describe 'src/networking', ->
    beforeEach ->
        Networking.Impl =
            init: ->

        @config =
            type: Networking.HTTP
            protocol: 'http'
            port: 3000
            host: 'localhost'
            language: 'en'

    afterEach ->
        Networking.Impl = Impl

    describe 'option.allowAllOrigins', ->
        it 'is false by default', ->
            assert.is new Networking(@config).allowAllOrigins, false

            utils.merge @config, {allowAllOrigins: null}
            assert.is new Networking(@config).allowAllOrigins, false

        it 'can be set to true', ->
            assert.is new Networking(@config).allowAllOrigins, true
