Grid @class
====

#### Position items in grid @snippet

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

	module.exports = (Renderer, Impl, itemUtils) -> class Grid extends Renderer.Item
		@__name__ = 'Grid'
		@__path__ = 'Renderer.Grid'
		@CHILDREN_AUTO_PROPS = x: true, y: true
		@SELF_AUTO_PROPS = width: true, height: true

*Grid* Grid() : *Renderer.Item*
-------------------------------

		constructor: ->
			@_columns = 2
			@_rows = Infinity
			@_spacing = null
			@_alignment = null
			@_includeBorderMargins = true
			@_updatePending = false
			@_autoWidth = true
			@_autoHeight = true
			super()

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

*Integer* Grid::columns = 2
---------------------------

### *Signal* Grid::onColumnsChange(*Integer* oldValue)

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

### *Signal* Grid::onRowsChange(*Integer* oldValue)

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

### *Signal* Grid::onSpacingChange(*Spacing* oldValue)

		Renderer.Item.Spacing @

*Alignment* Grid::alignment
---------------------------

### *Signal* Grid::onAlignmentChange(*Alignment* oldValue)

		Renderer.Item.Alignment @

*Boolean* Grid::includeBorderMargins = true
-------------------------------------------

### *Signal* Grid::onIncludeBorderMarginsChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'includeBorderMargins'
			defaultValue: true
			implementation: Impl.setGridIncludeBorderMargins
			developmentSetter: (val) ->
				assert.isBoolean val

		clone: ->
			clone = super()
			clone.columns = @_columns
			clone.rows = @_rows
			clone.fill = @fill
			clone.alignment = @alignment
			if @_spacing
				clone.spacing = @spacing
			clone
