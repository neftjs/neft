Renderer.Image
==============

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

*Image* Image([*Object* options, *Array* children])
---------------------------------------------------

**Extends:** `Renderer.Item`

	module.exports = (Renderer, Impl, itemUtils) -> class Image extends Renderer.Item
		@__name__ = 'Image'
		@__path__ = 'Renderer.Image'

		@DATA = utils.merge Object.create(Renderer.Item.DATA),
			source: ''

*String* Image::source
----------------------

### Image::sourceChanged(*String* oldValue)

		itemUtils.defineProperty @::, 'source', Impl.setImageSource, null, (_super) -> (val) ->
			expect(val).toBe.string()
			_super.call @, val
