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

	assert = require 'neft-assert'
	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils) -> class Flow extends Renderer.Item
		@__name__ = 'Flow'
		@__path__ = 'Renderer.Flow'

*Flow* Flow() : *Renderer.Item*
-------------------------------

		constructor: (component, opts) ->
			@_padding = null
			@_spacing = null
			@_alignment = null
			@_includeBorderMargins = false
			@_collapseMargins = false
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

*Margin* Flow::padding
----------------------

### *Signal* Flow::onPaddingChange(*Margin* padding)

		Renderer.Item.Margin @,
			propertyName: 'padding'

*Spacing* Flow::spacing
-----------------------

### *Signal* Flow::onSpacingChange(*Spacing* oldValue)

		Renderer.Item.Spacing @

*Alignment* Flow::alignment
---------------------------

### *Signal* Flow::onAlignmentChange(*Alignment* oldValue)

		Renderer.Item.Alignment @

*Boolean* Flow::includeBorderMargins = false
-------------------------------------------

### *Signal* Flow::onIncludeBorderMarginsChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'includeBorderMargins'
			defaultValue: false
			implementation: Impl.setFlowIncludeBorderMargins
			developmentSetter: (val) ->
				assert.isBoolean val


*Boolean* Flow::collapseMargins = false
---------------------------------------

### *Signal* Flow::onCollapseMarginsChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'collapseMargins'
			defaultValue: false
			implementation: Impl.setFlowCollapseMargins
			developmentSetter: (val) ->
				assert.isBoolean val
