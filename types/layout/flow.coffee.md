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

		constructor: ->
			@_width = -1
			@_height = -1
			@_spacing = null
			@_includeBorderMargins = true
			super()
			@fill.width = true
			@fill.height = true

		@::_width = -1
		getter = utils.lookupGetter @::, 'width'
		setter = utils.lookupSetter @::, 'width'
		utils.defineProperty @::, 'width', null, getter, do (_super = setter) -> (val) ->
			@fill.width = val is -1
			_super.call @, val
			return

		@::_height = -1
		getter = utils.lookupGetter @::, 'height'
		setter = utils.lookupSetter @::, 'height'
		utils.defineProperty @::, 'height', null, getter, do (_super = setter) -> (val) ->
			@fill.height = val is -1
			_super.call @, val
			return

		clone: ->
			clone = super()
			clone.fill = @fill
			if @_spacing
				clone.spacing = @spacing
			clone

*Spacing* Flow::spacing
-----------------------

### *Signal* Flow::onSpacingChange(*Spacing* oldValue)

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

		Renderer.Item.Spacing @
