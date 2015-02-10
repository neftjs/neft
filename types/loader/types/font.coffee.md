Renderer.Font.Loader
====================

```
Item {
  Loader.Font {
  	name: 'myFont'
  	source: 'static/fonts/myFont.woff'
  }

  Text {
  	font.family: 'myFont'
  	text: 'Cool font, bro!'
  }
}
```

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	log = require 'log'
	signal = require 'signal'

	log = log.scope 'Renderer', 'FontLoader'

	module.exports = (Renderer, Impl, itemUtils) -> class Font extends signal.Emitter
		@__name__ = 'Font'
		@__path__ = 'Renderer.Loader.Font'

		SOURCE_FILE = ///(\w+)\.(\w+)$///

		loadFont = (self) ->
			path = SOURCE_FILE.exec self.source
			[_, name, ext] = path

			if ext isnt 'woff'
				log.warn "Recommended font format is WOFF"

			unless self.name
				self.name = name

			Impl.loadFont self.source, self.name

		@fonts = {}

*FontLoader* FontLoader([*Object* options])
-------------------------------------------

		constructor: ->
			@_data =
				name: ''
				source: ''
			super()

*String* FontLoader::name
-------------------------

		utils.defineProperty @::, 'name', null, ->
			@_data.name
		, (val) ->
			expect(val).toBe.truthy().string()
			@_data.name = val.toLowerCase()

*String* FontLoader::source
---------------------------

		utils.defineProperty @::, 'source', null, ->
			@_data.source
		, (val) ->
			expect(val).toBe.truthy().string()
			@_data.source = val

			setImmediate =>
				Object.freeze @_data
				Font.fonts[@name] = @
				loadFont @