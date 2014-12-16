Renderer.Image
==============

	'use strict'

	expect = require 'expect'
	signal = require 'signal'
	log = require 'log'
	utils = require 'utils'

	log = log.scope 'Renderer', 'Image'

*Image* Image([*Object* options, *Array* children]) : Renderer.Item
-------------------------------------------------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class Image extends Renderer.Item
		@__name__ = 'Image'
		@__path__ = 'Renderer.Image'

		@DATA = utils.merge Object.create(Renderer.Item.DATA),
			source: ''

*String* Image::source
----------------------

### Image::sourceChanged(*String* oldValue)

		itemUtils.defineProperty @::, 'source', null, null, (_super) -> (val) ->
			expect(val).toBe.string()
			unless _super.call @, val
				return false

			Impl.setImageSource.call @, val, (err, opts) =>
				if val isnt @_data.source
					return
				if @_data.hasOwnProperty('width') or @_data.hasOwnProperty('height')
					return

				if err
					err = new Error "Can't load `#{source}` image"
					log.warn err.message
				else
					@width = opts.width
					@height = opts.height

				@loaded? err

			true

Image::loaded([*Error* error])
------------------------------

		signal.createLazy @::, 'loaded'
