'use strict'

utils = require 'utils'

module.exports = (impl) ->
	{Types, items} = impl
	{Item} = Types

	update = (id) ->
		item = items[id]
		return if item.updatePending

		item.updatePending = true

		do -> # HACK: using setImmediate occurs in one-frame not positioned elements
			{children, columns, rows, columnsPositions, rowsPositions} = item
			{rowSpacing, columnSpacing, updateX, updateY} = item

			# reset columns positions
			for column, i in columnsPositions
				columnsPositions[i] = 0

			# reset rows positions
			for row, i in rowsPositions
				rowsPositions[i] = 0

			# refresh widths
			for childId, i in children
				column = i % columns
				row = Math.floor(i/columns) % rows

				# omit not visible children
				unless impl.getItemVisible childId
					continue

				width = impl.getItemWidth childId
				height = impl.getItemHeight childId

				columnsPositions[column] = Math.max (columnsPositions[column] or 0), width
				rowsPositions[row] = Math.max (rowsPositions[row] or 0), height

			# sum columns positions
			last = 0
			for column, i in columnsPositions
				val = columnsPositions[i]
				last = columnsPositions[i] += last + (if val then columnSpacing else 0)

			# sum rows positions
			last = 0
			for row, i in rowsPositions
				val = rowsPositions[i]
				last = rowsPositions[i] += last + (if val then rowSpacing else 0)

			# set positions
			for childId, i in children
				column = i % columns
				row = Math.floor(i/columns) % rows

				if updateX
					impl.setItemX childId, (columnsPositions[column-1] or 0)

				if updateY
					impl.setItemY childId, (rowsPositions[row-1] or 0)

			# set item size
			impl.setItemWidth id, utils.last(columnsPositions) - columnSpacing
			impl.setItemHeight id, utils.last(rowsPositions) - rowSpacing

			item.updatePending = false

	appendChild = (parentId, childId) ->
		parent = items[parentId]

		parent.children.push childId
		update parentId

	removeChild = (parentId, childId) ->
		parent = items[parentId]

		utils.remove parent.children, childId
		update parentId

	impl.setItemParent = do (_super = impl.setItemParent) -> (id, val) ->
		old = impl.getItemParent id

		_super id, val

		if items[old]?.type is 'Grid'
			removeChild old, id

		if items[val]?.type is 'Grid'
			appendChild val, id

	overrideSetter = (methodName) ->
		impl[methodName] = do (_super = impl[methodName]) -> (id, val) ->
			_super id, val

			parentId = impl.getItemParent id
			if items[parentId]?.type is 'Grid'
				update parentId

	overrideSetter 'setItemWidth'
	overrideSetter 'setItemHeight'
	overrideSetter 'setItemVisible'

	create: (id, target) ->
		Item.create id, target

		target.updatePending = false
		target.columns = 3
		target.rows = Infinity
		target.columnSpacing = 0
		target.rowSpacing = 0
		target.updateX = true
		target.updateY = true
		target.children = []
		target.columnsPositions = []
		target.rowsPositions = []

	getGridColumns: (id) ->
		items[id].columns

	setGridColumns: (id, val) ->
		items[id].columns = val
		update id

	getGridRows: (id) ->
		items[id].rows

	setGridRows: (id, val) ->
		items[id].rows = val
		update id

	getGridColumnSpacing: (id) ->
		items[id].columnSpacing

	setGridColumnSpacing: (id, val) ->
		items[id].columnSpacing = val
		update id

	getGridRowSpacing: (id) ->
		items[id].rowSpacing

	setGridRowSpacing: (id, val) ->
		items[id].rowSpacing = val
		update id
