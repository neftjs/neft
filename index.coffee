'use strict'

utils = require 'utils'
assert = require 'neft-assert'

module.exports = class Resources
	@__name__ = 'Resources'

	@Resources = @
	@Resource = require('./resource') @
	@ImageResource = require('./types/image') @

	@URI = ///^rsc:\/\/(.*)$////

	@fromJSON = (json) ->
		assert.isString json
		if typeof json is 'string'
			json = JSON.parse json
		assert.isObject json

		resources = new Resources
		for prop, val of json
			if prop is '__name__'
				continue
			val = Resources[val.__name__].fromJSON val
			assert.notOk prop of resources, "Can't set '#{prop}' property in this resources object, because it's already defined"
			resources[prop] = val

		resources

	@testUri = (uri) ->
		assert.isString uri
		Resources.URI.test uri

	constructor: ->

	getResource: (uri) ->
		if typeof uri is 'string'
			if match = Resources.URI.exec(uri)
				uri = match[1]
			if uri.indexOf('/') isnt -1
				uri = uri.split '/'
		
		if Array.isArray(uri)
			res = @
			for chunk in uri
				if res instanceof Resources.Resource
					unless res.getPath(chunk)
						return
				unless res = res.getResource chunk
					break
		else
			res = @[uri]?.getResource(uri)
		res

	toJSON: ->
		utils.merge
			__name__: @constructor.__name__
		, @
