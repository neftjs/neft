Renderer.Image
==============

	'use strict'

	expect = require 'expect'
	signal = require 'signal'
	log = require 'log'
	utils = require 'utils'

	log = log.scope 'Renderer', 'Image'

*Image* Image([*Object* options, *Array* children]) : *Renderer.Item*
---------------------------------------------------------------------

This item is used to render image defined by the *Image::source* URL.

If the *Renderer.Item::width* and *Renderer.Item::height* attributes are not
specified, this *Renderer.Item* automatically uses the size of the loaded image.

```nml
Image {
\  source: 'image/source.jpg'
\
\  onLoaded: (error){
\  	if (error){
\  	  console.error("Can't load this image");
\  	} else {
\  	  console.log("Image has been loaded");
\  	}
\  }
}
```

	module.exports = (Renderer, Impl, itemUtils) -> class Image extends Renderer.Item
		@__name__ = 'Image'
		@__path__ = 'Renderer.Image'

		itemUtils.initConstructor @,
			extends: Renderer.Item
			data:
				source: ''

*String* Image::source
----------------------

Image source URL (absolute or relative to the page) or data URI.

*SVG* is fully supported.

### *Signal* Image::sourceChanged(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'source'
			developmentSetter: (val) ->
				expect(val).toBe.string()
			setter: (_super) -> (val) ->
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

*Signal* Image::loaded([*Error* error])
---------------------------------------

This signal is called when the image loading process has been ended, that is
image has been loaded or some error occurs.

Always check, whether first *error* argument is defined if you need to check
whether image is ready.

		signal.createLazy @::, 'loaded'
