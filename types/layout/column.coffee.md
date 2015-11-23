Column @class
======

#### Position items in column @snippet

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

	assert = require 'assert'
	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils) -> class Column extends Renderer.Item
		@__name__ = 'Column'
		@__path__ = 'Renderer.Column'

*Column* Column.New(*Component* component, [*Object* options])
--------------------------------------------------------------

		@New = (component, opts) ->
			item = new Column
			itemUtils.Object.initialize item, component, opts
			item.effectItem = item
			item

*Column* Column() : *Renderer.Item*
-----------------------------------

		constructor: ->
			super()
			@_padding = null
			@_spacing = 0
			@_alignment = null
			@_includeBorderMargins = false
			@_effectItem = null

		utils.defineProperty @::, 'effectItem', null, ->
			@_effectItem
		, (val) ->
			if val?
				assert.instanceOf val, Renderer.Item
			oldVal = @_effectItem
			@_effectItem = val
			Impl.setColumnEffectItem.call @, val, oldVal

*Margin* Column::padding
------------------------

### *Signal* Column::onPaddingChange(*Margin* padding)

		Renderer.Item.Margin @,
			propertyName: 'padding'

*Float* Column::spacing = 0
---------------------------

### *Signal* Column::onSpacingChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'spacing'
			defaultValue: 0
			implementation: Impl.setColumnSpacing
			setter: (_super) -> (val) ->
				# state doesn't distinguish column and grid
				if utils.isObject val
					val = 0
				assert.isFloat val
				_super.call @, val

*Alignment* Column::alignment
-----------------------------

### *Signal* Column::onAlignmentChange(*Alignment* oldValue)

		Renderer.Item.Alignment @

*Boolean* Column::includeBorderMargins = false
----------------------------------------------

### *Signal* Column::onIncludeBorderMarginsChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'includeBorderMargins'
			defaultValue: false
			implementation: Impl.setColumnIncludeBorderMargins
			developmentSetter: (val) ->
				assert.isBoolean val
