Renderer.Column
===============

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

*Column* Column([*Object* options, *Array* children]) : *Renderer.Item*
-----------------------------------------------------------------------

```nml,render
Column {
\  spacing: 5
\
\  Rectangle { color: 'blue'; width: 50; height: 50; }
\  Rectangle { color: 'green'; width: 20; height: 50; }
\  Rectangle { color: 'red'; width: 50; height: 20; }
}
```

	module.exports = (Renderer, Impl, itemUtils) -> class Column extends Renderer.Item
		@__name__ = 'Column'
		@__path__ = 'Renderer.Column'

		itemUtils.initConstructor @,
			extends: Renderer.Item
			data:
				spacing: 0

*Float* Column::spacing
-----------------------

### *Signal* Column::spacingChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'spacing'
			implementation: Impl.setColumnSpacing
			developmentSetter: (val) ->
				expect(val).toBe.float()
