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

	assert = require 'assert'
	utils = require 'utils'

*Column* Column() : *Renderer.Item*
-----------------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class Column extends Renderer.Item
		@__name__ = 'Column'
		@__path__ = 'Renderer.Column'

		constructor: ->
			super()
			@_autoHeight = true

		getter = utils.lookupGetter @::, 'height'
		setter = utils.lookupSetter @::, 'height'
		utils.defineProperty @::, 'height', null, getter, do (_super = setter) -> (val) ->
			if @_width isnt val
				@_autoHeight = false
			_super.call @, val
			return

*Float* Column::spacing = 0
---------------------------

### *Signal* Column::spacingChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'spacing'
			defaultValue: 0
			implementation: Impl.setColumnSpacing
			setter: (_super) -> (val) ->
				# state doesn't distinguishes column and grid
				if utils.isObject val
					val = 0
				assert.isFloat val
				_super.call @, val

		clone: ->
			clone = super()
			clone._autoHeight = @_autoHeight
			clone.spacing = @_spacing
			clone
