Positioning/Row
===============

```style
Row {
\  spacing: 5
\
\  Rectangle { color: 'blue'; width: 50; height: 50; }
\  Rectangle { color: 'green'; width: 20; height: 50; }
\  Rectangle { color: 'red'; width: 50; height: 20; }
}
```

	'use strict'

	assert = require 'assert'
	utils = require 'utils'

*Row* Row() : *Renderer.Item*
-----------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class Row extends Renderer.Item
		@__name__ = 'Row'
		@__path__ = 'Renderer.Row'

		constructor: ->
			super()

*Float* Row::spacing = 0
------------------------

### *Signal* Row::spacingChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'spacing'
			defaultValue: 0
			implementation: Impl.setRowSpacing
			setter: (_super) -> (val) ->
				# state doesn't distinguishes column and grid
				if utils.isObject val
					val = 0
				assert.isFloat val
				_super.call @, val
