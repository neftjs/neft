Resource Manager @engine
========================

	'use strict'

	utils = require 'utils'
	log = require 'log'
	assert = require 'neft-assert'

	log = log.scope 'Resources'

	module.exports = class Resources
		@__name__ = 'Resources'

		@Resources = @
		@Resource = require('./resource') @
		@ImageResource = require('./types/image') @

		@URI = ///^(?:rsc|resource|resources)?:\/?\/?(.*?)(?:\.[a-zA-Z]+)?$///

		if utils.isServer
			@parser = require('./parser') @

*Resources* Resources.fromJSON(*String|Object* json)
----------------------------------------------------

		@fromJSON = (json) ->
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

*Boolean* Resources.testUri(*String* uri)
-----------------------------------------

		@testUri = (uri) ->
			assert.isString uri
			Resources.URI.test uri

*Resources* Resources()
-----------------------

		constructor: ->

*Resources.Resource* Resources::getResource(*String* uri)
---------------------------------------------------------

		getResource: (uri) ->
			if typeof uri is 'string'
				if match = Resources.URI.exec(uri)
					uri = match[1]

			chunk = uri
			while chunk
				if r = @[chunk]
					rest = uri.slice chunk.length + 1
					if rest isnt '' and r instanceof Resources
						r = r.getResource rest
					return r
				chunk = chunk.slice 0, chunk.lastIndexOf('/')
			return

*Object* Resources::toJSON()
----------------------------

		toJSON: ->
			utils.merge
				__name__: @constructor.__name__
			, @
