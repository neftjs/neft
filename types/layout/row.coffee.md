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
			@_spacing = 0
			@_alignment = null
			@_includeBorderMargins = true
			@_updatePending = false
			@_autoWidth = true
			@_autoHeight = true
			super component, opts

		@::_width = -1
		getter = utils.lookupGetter @::, 'width'
		setter = utils.lookupSetter @::, 'width'
		utils.defineProperty @::, 'width', null, getter, do (_super = setter) -> (val) ->
			if not @_updatePending
				@_autoWidth = val is -1
			_super.call @, val
			return

		@::_height = -1
		getter = utils.lookupGetter @::, 'height'
		setter = utils.lookupSetter @::, 'height'
		utils.defineProperty @::, 'height', null, getter, do (_super = setter) -> (val) ->
			if not @_updatePending
				@_autoHeight = val is -1
			_super.call @, val
			return

*Float* Row::spacing = 0
------------------------

### *Signal* Row::onSpacingChange(*Float* oldValue)

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

*Alignment* Row::alignment
--------------------------

### *Signal* Row::onAlignmentChange(*Alignment* oldValue)

		Renderer.Item.Alignment @

*Boolean* Row::includeBorderMargins = true
------------------------------------------

### *Signal* Row::onIncludeBorderMarginsChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'includeBorderMargins'
			defaultValue: true
			implementation: Impl.setRowIncludeBorderMargins
			developmentSetter: (val) ->
				assert.isBoolean val
