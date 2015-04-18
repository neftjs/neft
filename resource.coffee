'use strict'

log = require 'log'
utils = require 'utils'
assert = require 'neft-assert'

log = log.scope 'Resources', 'Resource'

module.exports = (Resources) -> class Resource
	@__name__ = 'Resource'
	@__path__ = 'Resources.Resource'
	@URI = ///^(.*?)(?:@([0-9p]+)x)?(?:\.([a-zA-Z0-9]+))?$///

	@fromJSON = (json) ->
		res = new Resource
		for prop, val of json
			if prop is '__name__'
				continue
			res[prop] = val
		res

	@parseFileName = (name) ->
		match = Resource.URI.exec name

		file: match[1]
		resolution: if match[2]? then parseFloat(match[2].replace('p', '.')) else 1
		format: match[3]

	constructor: ->
		assert.instanceOf @, Resource

		@file = ''
		@formats = null
		@resolutions = null
		@paths = null
		Object.preventExtensions @

	getPath: (uri, req) ->
		if req is undefined and utils.isPlainObject(uri)
			req = uri
			uri = ''
			file = @file
		else
			name = Resource.parseFileName uri
			file = name.file
			resolution = name.resolution
			if name.format
				formats = [name.format]

		assert.isString uri
		assert.isPlainObject req if req?

		resolution ?= req.resolution or 1
		formats ?= req.formats or @formats

		if file isnt @file
			return

		# get best resolution
		diff = Infinity
		rResolution = 0
		for val in @resolutions
			thisDiff = Math.abs(resolution - val)
			if thisDiff < diff
				diff = thisDiff
				rResolution = val[1]

		# get path
		for format in formats
			if r = @paths[format]?[rResolution]
				return r
					
		return

	toJSON: ->
		utils.merge
			__name__: @constructor.__name__
		, @
