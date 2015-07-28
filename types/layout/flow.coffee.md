Flow @class
====

#### Position items in natural order @snippet

```style
Flow {
\  width: 90
\  spacing.column: 15
\  spacing.row: 5
\
\  Rectangle { color: 'blue'; width: 60; height: 50; }
\  Rectangle { color: 'green'; width: 20; height: 70; }
\  Rectangle { color: 'red'; width: 50; height: 30; }
\  Rectangle { color: 'yellow'; width: 20; height: 20; }
}
```

	'use strict'

	assert = require 'assert'
	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils) -> class Flow extends Renderer.Item
		@__name__ = 'Flow'
		@__path__ = 'Renderer.Flow'

*Flow* Flow() : *Renderer.Item*
-------------------------------

		constructor: (component, opts) ->
			@_spacing = null
			@_alignment = null
			@_includeBorderMargins = true
			@_effectItem = null
			super component, opts
			@effectItem = @

		utils.defineProperty @::, 'effectItem', null, ->
			@_effectItem
		, (val) ->
			if val?
				assert.instanceOf val, Renderer.Item
			oldVal = @_effectItem
			@_effectItem = val
			Impl.setFlowEffectItem.call @, val, oldVal

*Spacing* Flow::spacing
-----------------------

### *Signal* Flow::onSpacingChange(*Spacing* oldValue)

		Renderer.Item.Spacing @

*Alignment* Flow::alignment
---------------------------

### *Signal* Flow::onAlignmentChange(*Alignment* oldValue)

		Renderer.Item.Alignment @

*Boolean* Flow::includeBorderMargins = true
-------------------------------------------

### *Signal* Flow::onIncludeBorderMarginsChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'includeBorderMargins'
			defaultValue: true
			implementation: Impl.setFlowIncludeBorderMargins
			developmentSetter: (val) ->
				assert.isBoolean val
