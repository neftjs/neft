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
			@_isLoaded = false
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
			setter: do ->
				loadCallback = (err, opts) ->
					if err
						log.warn "Can't load `#{@source}` image"
					else if opts?
						@width = opts.width
						@height = opts.height

					@_isLoaded = true
					@isLoadedChanged false
					@loaded err

				(_super) -> (val) ->
					_super.call @, val
					if @_isLoaded
						@_isLoaded = false
						@isLoadedChanged true
					Impl.setImageSource.call @, val, loadCallback
					return

ReadOnly *Boolean* Image::isLoaded
----------------------------------

		utils.defineProperty @::, 'isLoaded', null, ->
			@_isLoaded
		, null

### *Signal* Image::isLoadedChanged(*Boolean* oldValue)

		signal.Emitter.createSignal @, 'isLoadedChanged'

*Signal* Image::loaded([*Error* error])
---------------------------------------

This signal is called when the image loading process has been ended, that is
image has been loaded or some error occurs.

Always check, whether first *error* argument is defined if you need to check
whether image is ready.

		signal.Emitter.createSignal @, 'loaded'
