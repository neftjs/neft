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

	expect = require 'expect'
	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils) ->

*Grid* Grid([*Object* options, *Array* children]) : *Renderer.Item*
-------------------------------------------------------------------

		class Grid extends Renderer.Item
			@__name__ = 'Grid'
			@__path__ = 'Renderer.Grid'

			itemUtils.initConstructor @,
				extends: Renderer.Item
				data:
					columns: 2
					rows: Infinity

*Integer* Grid::columns = 2
---------------------------

### *Signal* Grid::columnsChanged(*Integer* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'columns'
				implementation: Impl.setGridColumns
				developmentSetter: (val) ->
					expect(val).toBe.greaterThan 0

*Integer* Grid::rows = Infinity
-------------------------------

### *Signal* Grid::rowsChanged(*Integer* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'rows'
				implementation: Impl.setGridRows
				developmentSetter: (val) ->
					expect(val).toBe.greaterThan 0

*Spacing* Grid::spacing
-----------------------

		class Spacing extends itemUtils.DeepObject
			@__name__ = 'Spacing'

			itemUtils.initConstructor @,
				data:
					column: 0
					row: 0

			itemUtils.defineProperty
				constructor: Grid
				name: 'spacing'
				valueConstructor: Spacing

*Float* Grid::spacing.column
----------------------------

### *Signal* Grid::spacing.columnChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'column'
				implementation: Impl.setGridColumnSpacing
				developmentSetter: (val) ->
					expect(val).toBe.float()

*Float* Grid::spacing.row
-------------------------

### *Signal* Grid::spacing.rowChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'row'
				implementation: Impl.setGridRowSpacing
				developmentSetter: (val) ->
					expect(val).toBe.float()

*Float* Grid::spacing.valueOf()
-------------------------------

			valueOf: ->
				if @column is @row
					@column
				else
					throw new Error "column and row grid spacing are different"

		Grid
