ImageResource @class
=============

	'use strict'

	Schema = require 'schema'
	utils = require 'utils'

*ImageResource* ImageResource() extends *Resources.Resource*
------------------------------------------------------------

	module.exports = (Resources) -> class ImageResource extends Resources.Resource
		@__name__ = 'ImageResource'
		@__path__ = 'Resources.ImageResource'

		constructor: ->
			@width = 0
			@height = 0
			super()

*Float* ImageResource::width = 0
--------------------------------

*Float* ImageResource::height = 0
---------------------------------

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