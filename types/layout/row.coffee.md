Row @class
===

#### Position items in row @snippet

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

		constructor: (component, opts) ->
			@_padding = null
			@_spacing = 0
			@_alignment = null
			@_includeBorderMargins = false
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
			Impl.setRowEffectItem.call @, val, oldVal

*Margin* Row::padding
---------------------

### *Signal* Row::onPaddingChange(*Margin* padding)

		Renderer.Item.Margin @,
			propertyName: 'padding'

*Float* Row::spacing = 0
------------------------

### *Signal* Row::onSpacingChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'spacing'
			defaultValue: 0
			implementation: Impl.setRowSpacing
			setter: (_super) -> (val) ->
				# state doesn't distinguish column and grid
				if utils.isObject val
					val = 0
				assert.isFloat val
				_super.call @, val

*Alignment* Row::alignment
--------------------------

### *Signal* Row::onAlignmentChange(*Alignment* oldValue)

		Renderer.Item.Alignment @

*Boolean* Row::includeBorderMargins = false
-------------------------------------------

### *Signal* Row::onIncludeBorderMarginsChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'includeBorderMargins'
			defaultValue: false
			implementation: Impl.setRowIncludeBorderMargins
			developmentSetter: (val) ->
				assert.isBoolean val
