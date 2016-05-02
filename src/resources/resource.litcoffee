Resource @class
===============

    'use strict'

    log = require 'src/log'
    utils = require 'src/utils'
    assert = require 'src/assert'

    log = log.scope 'Resources', 'Resource'

    module.exports = (Resources) -> class Resource
        @__name__ = 'Resource'
        @__path__ = 'Resources.Resource'
        @FILE_NAME = ///^(.*?)(?:@([0-9p]+)x)?(?:\.([a-zA-Z0-9]+))?(?:\#([a-zA-Z0-9]+))?$///

*Resource* Resource.fromJSON(*String|Object* json)
--------------------------------------------------

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

*Object* Resource.parseFileName(*String* name)
----------------------------------------------

        @parseFileName = (name) ->
            if name and (match = Resource.FILE_NAME.exec(name))
                file: match[1]
                resolution: if match[2]? then parseFloat(match[2].replace('p', '.'))
                format: match[3]
                property: match[4]

*Resource* Resource()
---------------------

        constructor: ->
            assert.instanceOf @, Resource

            @file = ''
            @color = ''
            @width = 0
            @height = 0
            @formats = null
            @resolutions = null
            @paths = null

*String* Resource::file = ''
----------------------------

*String* Resource::color = ''
-----------------------------

*Float* Resource::width = 0
---------------------------

*Float* Resource::height = 0
----------------------------

*Array* Resource::formats
-------------------------

*Array* Resource::resolutions
-----------------------------

*Object* Resource::paths
------------------------

*String* Resource::resolve([*String* uri, *Object* request])
------------------------------------------------------------

        resolve: (uri='', req) ->
            if req is undefined and utils.isPlainObject(uri)
                req = uri
                uri = ''

            if uri is ''
                file = @file
            else
                name = Resource.parseFileName uri
                {file} = name
                resolution = name.resolution
                if name.format
                    formats = [name.format]
                property = name.property

            assert.isString uri
            assert.isPlainObject req if req?

            resolution ?= req?.resolution or 1
            formats ?= req?.formats or @formats
            property ||= req?.property or 'file'

            # if file isnt @file
            #   return

            if property isnt 'file'
                return @[property]

            # get resolution from size
            if utils.isPlainObject(req)
                if req.width > req.height
                    req.resolution *= req.width / @width
                else if req.width < req.height
                    req.resolution *= req.height / @height

            # get best resolution
            diff = Infinity
            rResolution = 0
            for val in @resolutions
                thisDiff = Math.abs(resolution - val)
                if thisDiff < diff or (thisDiff is diff and val > rResolution)
                    diff = thisDiff
                    rResolution = val

            # get path
            for format in formats
                if r = @paths[format]?[rResolution]
                    return r

            return

*Object* Resource::toJSON()
---------------------------

        toJSON: ->
            utils.merge
                __name__: @constructor.__name__
            , @
