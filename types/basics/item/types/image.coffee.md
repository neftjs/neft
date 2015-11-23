Image @class
=====

#### Render an image @snippet

```style
Image {
\  source: 'http://lorempixel.com/200/140/'
\
\  onLoad: function(error){
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
	assert = require 'assert'
	signal = require 'signal'
	log = require 'log'
	utils = require 'utils'

	log = log.scope 'Renderer', 'Image'

	module.exports = (Renderer, Impl, itemUtils) -> class Image extends Renderer.Item
		@__name__ = 'Image'
		@__path__ = 'Renderer.Image'

*Image* Image.New(*Component* component, [*Object* options])
------------------------------------------------------------

		@New = (component, opts) ->
			item = new Image
			itemUtils.Object.initialize item, component, opts
			item

*Image* Image() : *Renderer.Item*
---------------------------------

This item is used to render image defined by the *Image::source* URL.

If the *Renderer.Item::width* and *Renderer.Item::height* attributes are not
specified, this *Renderer.Item* automatically uses the size of the loaded image.

		constructor: ->
			super()
			@_source = ''
			@_loaded = false
			@_autoWidth = true
			@_autoHeight = true
			@_sourceWidth = 0
			@_sourceHeight = 0
			@_fillMode = 'Stretch'

*Float* Image.pixelRatio = 1
----------------------------

### *Signal* Image.onPixelRatioChange(*Float* oldValue)

		signal.create @, 'onPixelRatioChange'

		pixelRatio = 1
		utils.defineProperty @, 'pixelRatio', utils.CONFIGURABLE, ->
			pixelRatio
		, (val) ->
			assert.isFloat val
			if val is pixelRatio
				return
			oldVal = pixelRatio
			pixelRatio = val
			Impl.setStaticImagePixelRatio.call @, val
			@onPixelRatioChange.emit oldVal

		updateSizes = ->
			if @_autoHeight is @_autoWidth
				return

			if @_autoHeight
				autoWidth = @_autoWidth
				@_autoWidth = false
				@height = @_width / @sourceWidth * @sourceHeight or 0
				@_autoWidth = autoWidth
				@_autoHeight = true

			if @_autoWidth
				autoHeight = @_autoHeight
				@_autoHeight = false
				@width = @_height / @sourceHeight * @sourceWidth or 0
				@_autoHeight = autoHeight
				@_autoWidth = true
			return

		getter = utils.lookupGetter @::, 'width'
		setter = utils.lookupSetter @::, 'width'
		utils.defineProperty @::, 'width', null, getter, do (_super = setter) -> (val) ->
			if @_width isnt val
				@_autoWidth = false
				_super.call @, val
				updateSizes.call @
			return

		getter = utils.lookupGetter @::, 'height'
		setter = utils.lookupSetter @::, 'height'
		utils.defineProperty @::, 'height', null, getter, do (_super = setter) -> (val) ->
			if @_height isnt val
				@_autoHeight = false
				_super.call @, val
				updateSizes.call @
			return

*String* Image::source
----------------------

Image source URL (absolute or relative to the page) or data URI.

*SVG* is fully supported.

### *Signal* Image::onSourceChange(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'source'
			defaultValue: ''
			developmentSetter: (val) ->
				expect(val).toBe.string()
			setter: do ->
				RESOURCE_REQUEST =
					resolution: 1

				defaultSize =
					width: 0
					height: 0

				loadCallback = (err=null, opts) ->
					if err
						log.warn "Can't load '#{@source}' image at #{@toString()}"
					else
						@sourceWidth = opts.width
						@sourceHeight = opts.height
						if @_autoWidth
							@width = opts.width
							@_autoWidth = true
						if @_autoHeight
							@height = opts.height
							@_autoHeight = true
						updateSizes.call @

					@_loaded = true
					@onLoadedChange.emit false
					if err
						@onError.emit err
					else
						@onLoad.emit()

				(_super) -> (val) ->
					_super.call @, val
					if @_loaded
						@_loaded = false
						@onLoadedChange.emit true
					if val
						RESOURCE_REQUEST.resolution = Renderer.Device.pixelRatio * Image.pixelRatio
						val = Renderer.resources?.resolve(val, RESOURCE_REQUEST) or val
						Impl.setImageSource.call @, val, loadCallback
					else
						Impl.setImageSource.call @, null, null
						loadCallback.call @, null, defaultSize
					return

*Integer* Image::sourceWidth = 0
--------------------------------

### *Signal* Image::onSourceWidthChange(*Integer* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'sourceWidth'
			defaultValue: 0
			implementation: Impl.setImageSourceWidth
			developmentSetter: (val) ->
				expect(val).toBe.float()

*Integer* Image::sourceHeight = 0
---------------------------------

### *Signal* Image::onSourceHeightChange(*Integer* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'sourceHeight'
			defaultValue: 0
			implementation: Impl.setImageSourceHeight
			developmentSetter: (val) ->
				expect(val).toBe.float()

*Float* Image::offsetX = 0
--------------------------

### *Signal* Image::onOffsetXChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'offsetX'
			defaultValue: 0
			implementation: Impl.setImageOffsetX
			developmentSetter: (val) ->
				expect(val).toBe.float()

*Float* Image::offsetY = 0
--------------------------

### *Signal* Image::onOffsetYChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'offsetY'
			defaultValue: 0
			implementation: Impl.setImageOffsetY
			developmentSetter: (val) ->
				expect(val).toBe.float()

*Integer* Image::fillMode = 'Stretch'
-------------------------------------

### *Signal* Image::onFillModeChange(*Integer* oldValue)

		FILL_MODE_OPTIONS = ['Stretch', 'Tile']

		itemUtils.defineProperty
			constructor: @
			name: 'fillMode'
			defaultValue: 'Stretch'
			implementation: Impl.setImageFillMode
			developmentSetter: (val='Stretch') ->
				assert.isString val
				assert.ok utils.has(FILL_MODE_OPTIONS, val), "Accepted fillMode values: '#{FILL_MODE_OPTIONS}'"

ReadOnly *Boolean* Image::loaded
--------------------------------

		utils.defineProperty @::, 'loaded', null, ->
			@_loaded
		, null

### *Signal* Image::onLoadedChange(*Boolean* oldValue)

		signal.Emitter.createSignal @, 'onLoadedChange'

*Signal* Image::onLoad()
------------------------

		signal.Emitter.createSignal @, 'onLoad'

*Signal* Image::onError(*Error* error)
--------------------------------------

		signal.Emitter.createSignal @, 'onError'
