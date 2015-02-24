Positioning/Column
==================

```style
Column {
\  spacing: 5
\
\  Rectangle { color: 'blue'; width: 50; height: 50; }
\  Rectangle { color: 'green'; width: 20; height: 50; }
\  Rectangle { color: 'red'; width: 50; height: 20; }
}
```

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

*Column* Column() : *Renderer.Item*
-----------------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class Column extends Renderer.Item
		@__name__ = 'Column'
		@__path__ = 'Renderer.Column'

		constructor: ->
			super()

*Float* Column::spacing = 0
---------------------------

### *Signal* Column::spacingChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'spacing'
			defaultValue: 0
			implementation: Impl.setColumnSpacing
			developmentSetter: (val) ->
				expect(val).toBe.float()
