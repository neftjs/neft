# Resources

    'use strict'

    utils = require '../util'
    log = require '../log'
    assert = require '../assert'

    log = log.scope 'Resources'

    module.exports = class Resources
        @__name__ = 'Resources'

        @Resources = @
        @Resource = require('./resource') @

        URI_SEPARATOR = '/'

        @URI = ///
            ^
            (?:rsc|resource|resources)?:\/?\/? # schema
            (.*?) # file
            (
                (?:@(?:[0-9p]+)x)? # resolution
                (?:\.(?:[a-zA-Z0-9]+))? # format
                (?:\#(?:[a-zA-Z0-9]+))? # property
            )
            $
        ///

## *Resources* Resources.fromJSON(*String*|*Object* json)

        @fromJSON = (json, resources = new Resources) ->
            if typeof json is 'string'
                json = JSON.parse json
            assert.isObject json

            for prop, val of json
                if prop is '__name__'
                    continue
                val = Resources[val.__name__].fromJSON val
                assert.notOk prop of resources, """
                    Can't set '#{prop}' property in this resources object, \
                    because it's already defined
                """
                resources[prop] = val

            resources

## *Boolean* Resources.testUri(*String* uri)

        @testUri = (uri) ->
            assert.isString uri
            Resources.URI.test uri

        constructor: ->

## *Resource* Resources::getResource(*String* uri)

        getResource: (uri) ->
            if typeof uri is 'string'
                if match = Resources.URI.exec(uri)
                    uri = match[1]

            chunk = uri
            while chunk
                if r = @[chunk]
                    rest = uri.slice chunk.length + 1
                    if rest isnt '' and r instanceof Resources
                        return r.getResource rest
                    else if uri is chunk
                        return r
                    return
                chunk = chunk.substring 0, chunk.lastIndexOf(URI_SEPARATOR)
            return

## *String* Resources::resolve(*String* uri, [*Object* request])

        resolve: (uri, req) ->
            return unless Resources.testUri uri
            rsc = @getResource uri
            rscUri = Resources.URI.exec(uri)?[2]
            rsc?.resolve rscUri, req

## *Object* Resources::toJSON()

        toJSON: ->
            utils.merge
                __name__: @constructor.__name__
            , @
