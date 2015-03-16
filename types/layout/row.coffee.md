Positioning/Row
===============

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

		constructor: ->
			super()
			@_width = -1
			@_height = -1
			@fill.width = true
			@fill.height = true

		getter = utils.lookupGetter @::, 'width'
		setter = utils.lookupSetter @::, 'width'
		utils.defineProperty @::, 'width', null, getter, do (_super = setter) -> (val) ->
			@fill.width = val is -1
			_super.call @, val
			return

		getter = utils.lookupGetter @::, 'height'
		setter = utils.lookupSetter @::, 'height'
		utils.defineProperty @::, 'height', null, getter, do (_super = setter) -> (val) ->
			@fill.height = val is -1
			_super.call @, val
			return

*Float* Row::width = -1
-----------------------

*Float* Row::height = -1
------------------------

*Float* Row::spacing = 0
------------------------

### *Signal* Row::spacingChanged(*Float* oldValue)

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

		clone: ->
			clone = super()
			clone.fill = @fill
			clone.spacing = @_spacing
			clone
