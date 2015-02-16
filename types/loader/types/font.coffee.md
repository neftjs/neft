Loading assets/Font
===================

```
Item {
  Loader.Font {
  	name: 'myFont'
  	sources: ['static/fonts/myFont.woff']
  }

  Text {
  	font.family: 'myFont'
  	text: 'Cool font, bro!'
  }
}
```

	'use strict'

	assert = require 'assert'
	utils = require 'utils'
	log = require 'log'
	signal = require 'signal'

	log = log.scope 'Renderer', 'FontLoader'

	module.exports = (Renderer, Impl, itemUtils) -> class FontLoader extends signal.Emitter
		@__name__ = 'FontLoader'
		@__path__ = 'Renderer.Loader.Font'

		SOURCE_FILE = ///(\w+)\.(\w+)$///

		loadFont = (self) ->
			unless self.name
				for source in self.sources
					path = SOURCE_FILE.exec self.source
					if path
						self.name = path[1]
						break

			Impl.loadFont self.sources, self.name

		@fonts = {}

*FontLoader* FontLoader([*Object* options])
-------------------------------------------

This class is used to load custom fonts.

You can override default fonts (*sans-serif*, *sans* and *monospace*) and load new ones.

Font weight and style (italic or normal) is extracted from the font source.

Access it with:
```
Loader.Font {}
```

		constructor: ->
			@_data =
				name: ''
				sources: []
			super()

*String* FontLoader::name
-------------------------

		utils.defineProperty @::, 'name', null, ->
			@_data.name
		, (val) ->
			assert.isString val
			@_data.name = val.toLowerCase()

*String* FontLoader::sources
----------------------------

Place, where the font file can be found.

It needs to be an array, because there is no one font type supported by all browsers.

We recommend usng **WOFF** format and **TTF/OTF** for oldest Android browser.

		utils.defineProperty @::, 'sources', null, ->
			@_data.sources
		, (val) ->
			if val is 'string'
				val = [val]
			assert.isArray val
			assert.notLengthOf val, 0
			assert.isString val[0]
			assert.notLengthOf val[0]
			@_data.sources = val

			setImmediate =>
				Object.freeze @_data
				loadFont @
				FontLoader.fonts[@name] = @
