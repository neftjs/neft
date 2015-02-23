Basic items/Image
=================

```style
Image {
\  source: 'http://lorempixel.com/200/140/'
\
\  onLoaded: function(error){
\    if (error){
\      console.error("Can't load this image");
\    } else {
\      console.log("Image has been loaded");
\    }
\  }
}
```

	'use strict'

	expect = require 'expect'
	signal = require 'signal'
	log = require 'log'
	utils = require 'utils'

	log = log.scope 'Renderer', 'Image'

*Image* Image() : *Renderer.Item*
---------------------------------

This item is used to render image defined by the *Image::source* URL.

If the *Renderer.Item::width* and *Renderer.Item::height* attributes are not
specified, this *Renderer.Item* automatically uses the size of the loaded image.

	module.exports = (Renderer, Impl, itemUtils) -> class Image extends Renderer.Item
		@__name__ = 'Image'
		@__path__ = 'Renderer.Image'

		constructor: ->
			@_source = ''
			super()

*String* Image::source
----------------------

Image source URL (absolute or relative to the page) or data URI.

*SVG* is fully supported.

### *Signal* Image::sourceChanged(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'source'
			defaultValue: ''
			developmentSetter: (val) ->
				expect(val).toBe.string()
			setter: (_super) -> (val) ->
				_super.call @, val

				Impl.setImageSource.call @, val, (err, opts) =>
					if val isnt @source
						return

					if err
						err = new Error "Can't load `#{val}` image"
						log.warn err.message
					else if @width is 0 and @height is 0
						@width = opts.width
						@height = opts.height

					@loaded err

				true

*Signal* Image::loaded([*Error* error])
---------------------------------------

This signal is called when the image loading process has been ended, that is
image has been loaded or some error occurs.

Always check, whether first *error* argument is defined if you need to check
whether image is ready.

		signal.Emitter.createSignal @, 'loaded'
