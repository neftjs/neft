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

		@DATA = utils.merge Object.create(Renderer.Item.DATA),
			spacing: 0

*Float* Column::spacing
-----------------------

### *Signal* Column::spacingChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'spacing', Impl.setColumnSpacing, null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
