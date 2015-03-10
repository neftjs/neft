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
			@_autoWidth = true
			@_autoHeight = true
			super()

		getter = utils.lookupGetter @::, 'width'
		setter = utils.lookupSetter @::, 'width'
		utils.defineProperty @::, 'width', null, getter, do (_super = setter) -> (val) ->
			@_autoWidth = false
			_super.call @, val
			return

		getter = utils.lookupGetter @::, 'height'
		setter = utils.lookupSetter @::, 'height'
		utils.defineProperty @::, 'height', null, getter, do (_super = setter) -> (val) ->
			@_autoHeight = false
			_super.call @, val
			return

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
				defaultSize =
					width: 0
					height: 0

				loadCallback = (err=null, opts) ->
					if err
						log.warn "Can't load `#{@source}` image"
					else
						@naturalWidth = opts.width
						@naturalHeight = opts.height
						if @_autoWidth
							@width = opts.width
							@_autoWidth = true
						if @_autoHeight
							@height = opts.height
							@_autoHeight = true

					@_isLoaded = true
					@isLoadedChanged false
					@loaded err

				(_super) -> (val) ->
					_super.call @, val
					if @_isLoaded
						@_isLoaded = false
						@isLoadedChanged true
					if val
						Impl.setImageSource.call @, val, loadCallback
					else
						Impl.setImageSource.call @, null, null
						loadCallback.call @, null, defaultSize
					return

*Integer* Image::naturalWidth
-----------------------------

### *Signal* Image::naturalWidthChanged(*Integer* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'naturalWidth'
			defaultValue: 0
			developmentSetter: (val) ->
				expect(val).toBe.float()

*Integer* Image::naturalHeight
------------------------------

### *Signal* Image::naturalHeightChanged(*Integer* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'naturalHeight'
			defaultValue: 0
			developmentSetter: (val) ->
				expect(val).toBe.float()

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
