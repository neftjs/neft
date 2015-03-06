Positioning/Grid
================

```style
Grid {
\  spacing.column: 15
\  spacing.row: 5
\  columns: 2
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

*Grid* Grid() : *Renderer.Item*
-------------------------------

		class Grid extends Renderer.Item
			@__name__ = 'Grid'
			@__path__ = 'Renderer.Grid'

			constructor: ->
				super()

*Integer* Grid::columns = 2
---------------------------

### *Signal* Grid::columnsChanged(*Integer* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'columns'
				defaultValue: 2
				implementation: Impl.setGridColumns
				developmentSetter: (val) ->
					assert.operator val, '>=', 0
				setter: (_super) -> (val) ->
					if val <= 0
						val = 1
					_super.call @, val

*Integer* Grid::rows = Infinity
-------------------------------

### *Signal* Grid::rowsChanged(*Integer* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'rows'
				defaultValue: Infinity
				implementation: Impl.setGridRows
				developmentSetter: (val) ->
					assert.operator val, '>=', 0
				setter: (_super) -> (val) ->
					if val <= 0
						val = 1
					_super.call @, val

*Spacing* Grid::spacing
-----------------------

		class Spacing extends itemUtils.DeepObject
			@__name__ = 'Spacing'

			itemUtils.defineProperty
				constructor: Grid
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

*Float* Grid::spacing.column
----------------------------

### *Signal* Grid::spacing.columnChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'column'
				defaultValue: 0
				namespace: 'spacing'
				parentConstructor: Grid
				implementation: Impl.setGridColumnSpacing
				developmentSetter: (val) ->
					assert.isFloat val

*Float* Grid::spacing.row
-------------------------

### *Signal* Grid::spacing.rowChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'row'
				defaultValue: 0
				namespace: 'spacing'
				parentConstructor: Grid
				implementation: Impl.setGridRowSpacing
				developmentSetter: (val) ->
					assert.isFloat val

*Float* Grid::spacing.valueOf()
-------------------------------

			valueOf: ->
				if @column is @row
					@column
				else
					throw new Error "column and row grid spacing are different"

		Grid
