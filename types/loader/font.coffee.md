FontLoader @class
==========

#### Load a font @snippet

```
Item {
  FontLoader {
  	name: 'myFont'
  	source: 'rsc:/static/fonts/myFont'
  }

  Text {
  	font.family: 'myFont'
  	text: 'Cool font!'
  }
}
```

	'use strict'

	assert = require 'assert'
	utils = require 'utils'
	log = require 'log'
	signal = require 'signal'

	log = log.scope 'Renderer', 'FontLoader'

	module.exports = (Renderer, Impl, itemUtils) -> class FontLoader extends itemUtils.FixedObject
		@__name__ = 'FontLoader'
		@__path__ = 'Renderer.FontLoader'

		SOURCE_FILE = ///(\w+)\.(\w+)$///

		loadFont = (self) ->
			unless self.name
				path = SOURCE_FILE.exec self.source
				if path
					self.name = path[1]

			Impl.loadFont self.source, self.name
			return

		@fonts = {}

*FontLoader* FontLoader()
-------------------------

This class is used to load custom fonts.

You can override default fonts (*sans-serif*, *sans* and *monospace*) and load new ones.

Font weight and style (italic or normal) is extracted from the font source.

Access it with:
```
FontLoader {}
```

		constructor: (component, opts) ->
			@_name = ''
			@_source = ''
			super component, opts

*String* FontLoader::name
-------------------------

		utils.defineProperty @::, 'name', null, ->
			@_name
		, (val) ->
			assert.isString val
			@_name = val.toLowerCase()

*String* FontLoader::source
---------------------------

Place, where the font file can be found.

We recommend usng **WOFF** format and **TTF/OTF** for oldest Android browser.

		utils.defineProperty @::, 'source', null, ->
			@_source
		, (val) ->
			assert.isString val
			assert.notLengthOf val, 0
			@_source = val

			setImmediate =>
				loadFont @
				FontLoader.fonts[@name] = @
			return
