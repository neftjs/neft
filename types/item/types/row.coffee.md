Renderer.Row
============

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

*Row* Row([*Object* options, *Array* children])
-----------------------------------------------

**Extends:** `Renderer.Item`

	module.exports = (Renderer, Impl, itemUtils) -> class Row extends Renderer.Item
		@__name__ = 'Row'
		@__path__ = 'Renderer.Row'

		@DATA = utils.merge Object.create(Renderer.Item.DATA),
			spacing: 0

*Float* Row::spacing
--------------------

### Row::spacingChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'spacing', Impl.setRowSpacing, null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
