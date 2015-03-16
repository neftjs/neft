Positioning/Flow
================

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

	module.exports = (Renderer, Impl, itemUtils) ->

*Flow* Flow() : *Renderer.Item*
-------------------------------

		class Flow extends Renderer.Item
			@__name__ = 'Flow'
			@__path__ = 'Renderer.Flow'

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

*Float* Flow::width = -1
------------------------

*Float* Flow::height = -1
-------------------------

*Spacing* Flow::spacing
-----------------------

		class Spacing extends itemUtils.DeepObject
			@__name__ = 'Spacing'

			itemUtils.defineProperty
				constructor: Flow
				name: 'spacing'
				valueConstructor: Spacing
				setter: (_super) -> (val) ->
					{spacing} = @
					if utils.isObject(val)
						spacing.column = val.column if val.column?
						spacing.row = val.row if val.row?
					else
						spacing.column = spacing.row = val
					_super.call @, val
					return

			constructor: ->
				super()

*Float* Flow::spacing.column
----------------------------

### *Signal* Flow::spacing.columnChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'column'
				defaultValue: 0
				namespace: 'spacing'
				parentConstructor: Flow
				implementation: Impl.setFlowColumnSpacing
				developmentSetter: (val) ->
					assert.isFloat val

*Float* Flow::spacing.row
-------------------------

### *Signal* Flow::spacing.rowChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'row'
				defaultValue: 0
				namespace: 'spacing'
				parentConstructor: Flow
				implementation: Impl.setFlowRowSpacing
				developmentSetter: (val) ->
					assert.isFloat val

*Float* Flow::spacing.valueOf()
-------------------------------

			valueOf: ->
				if @column is @row
					@column
				else
					throw new Error "column and row flow spacing are different"

			toJSON: ->
				column: @column
				row: @row

		Flow
