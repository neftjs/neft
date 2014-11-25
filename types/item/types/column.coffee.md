Renderer.Column
===============

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	Dict = require 'dict'

*Column* Column([*Object* options, *Array* children])
-----------------------------------------------------

**Extends:** `Renderer.Item`

	module.exports = (Renderer, Impl, itemUtils) -> class Column extends Renderer.Item
		@__name__ = 'Column'
		@__path__ = 'Renderer.Column'

		@DATA = utils.merge Object.create(Renderer.Item.DATA),
			spacing: 0

*Float* Column::spacing
-----------------------

### Column::spacingChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'spacing', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setColumnSpacing.call @, val
