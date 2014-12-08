Renderer.FontLoader
===================

```
Item {
  FontLoader {
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

	log = log.scope 'Renderer', 'FontLoader'

	module.exports = (Renderer, Impl, itemUtils) -> class FontLoader
		@__name__ = 'FontLoader'

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

		@DATA =
			name: ''
			source: ''

*FontLoader* FontLoader([*Object* options])
-------------------------------------------

		constructor: (opts) ->
			expect().defined(opts).toBe.simpleObject()

			data = Object.create(FontLoader.DATA)
			utils.defineProperty @, '_data', null, data
			Object.freeze @

			itemUtils.fill @, opts

*String* FontLoader::name
-------------------------

		utils.defineProperty @::, 'name', null, ->
			@_data.name
		, (val) ->
			expect(val).toBe.truthy().string()
			@_data.name = val

*String* FontLoader::source
---------------------------

		utils.defineProperty @::, 'source', null, ->
			@_data.source
		, (val) ->
			expect(val).toBe.truthy().string()
			@_data.source = val

			setImmediate =>
				Object.freeze @_data
				FontLoader.fonts[@name] = @
				loadFont @