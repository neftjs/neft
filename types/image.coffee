'use strict'

Schema = require 'schema'
utils = require 'utils'

module.exports = (Resources) -> class ImageResource extends Resources.Resource
	@__name__ = 'ImageResource'
	@__path__ = 'Resources.ImageResource'

	@fromJSON = (json) ->
		new ImageResource json

	constructor: ->
		@width = 0
		@height = 0
		super()

	getPath: (uri, req) ->
		obj = req or uri
		if utils.isPlainObject(obj)
			{resolution} = obj
			if obj.width > obj.height
				obj.resolution *= obj.width / @width
			else if obj.width < obj.height
				obj.resolution *= obj.height / @height

		r = super uri, req

		if utils.isPlainObject(obj)
			obj.resolution = resolution

		r