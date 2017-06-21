# Resource

    'use strict'

    log = require 'src/log'
    utils = require 'src/utils'
    assert = require 'src/assert'

    log = log.scope 'Resources', 'Resource'

    module.exports = (Resources) -> class Resource
        @__name__ = 'Resource'
        @__path__ = 'Resources.Resource'
        @FILE_NAME = ///
            ^
            (.*?) # file
            (?:@([0-9p]+)x)? # resolution
            (?:\.([a-zA-Z0-9]+))? # format
            (?:\#([a-zA-Z0-9]+))? # property
            $
        ///

## *Resource* Resource.fromJSON(*String*|*Object* json)

        @fromJSON = (json) ->
            if typeof json is 'string'
                json = JSON.parse json
            assert.isObject json

            res = new Resources[json.__name__]
            for prop, val of json
                if prop is '__name__'
                    continue
                res[prop] = val
            res

## *Object* Resource.parseFileName(*String* path)

        @parseFileName = (path) ->
            assert.isString path

            if path and (match = Resource.FILE_NAME.exec(path))
                file: match[1] or undefined
                resolution: if match[2]? then parseFloat(match[2].replace('p', '.'))
                format: match[3]
                property: match[4]

        constructor: ->
            assert.instanceOf @, Resource

            @file = ''
            @name = ''
            @color = ''
            @width = 0
            @height = 0
            @formats = null
            @resolutions = null
            @paths = null

            Object.seal @

## *String* Resource::file = `''`

## *String* Resource::name = `''`

## *String* Resource::color = `''`

## *Float* Resource::width = `0`

## *Float* Resource::height = `0`

## *Array* Resource::formats

## *Array* Resource::resolutions

## *Object* Resource::paths

## *String* Resource::resolve([*String* uri, *Object* request])

        resolve: (uri = '', req) ->
            if req is undefined and utils.isPlainObject(uri)
                req = uri
                uri = ''

            if uri isnt ''
                name = Resource.parseFileName uri
                {file, resolution, property} = name
                if name.format
                    formats = [name.format]

            assert.isString uri
            assert.isPlainObject req if req?

            file ?= req?.file or @file
            resolution ?= req?.resolution or 1
            formats ?= req?.formats or @formats
            property ?= req?.property or 'file'

            if file isnt @file
                return

            if property isnt 'file'
                return @[property]

            # get resolution from size
            if req?.width? or req?.height?
                if req.width? and req.width > req.height
                    resolution *= req.width / @width
                else if req.height? and req.width < req.height
                    resolution *= req.height / @height

            # get best resolution
            diff = Infinity
            bestResolution = 0
            for val in @resolutions
                thisDiff = Math.abs(resolution - val)
                if thisDiff < diff or (thisDiff is diff and val > bestResolution)
                    diff = thisDiff
                    bestResolution = val

            # get path
            for format in formats
                if r = @paths[format]?[bestResolution]
                    return r

            return

## *Object* Resource::toJSON()

        toJSON: ->
            utils.merge
                __name__: @constructor.__name__
            , @
