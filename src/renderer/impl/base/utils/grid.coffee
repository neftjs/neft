'use strict'

MAX_LOOPS = 100

utils = require 'src/utils'
log = require 'src/log'
eventLoop = require 'src/eventLoop'
TypedArray = require 'src/typed-array'

log = log.scope 'Renderer'

queueIndex = 0
queues = [[], []]
queue = queues[queueIndex]
pending = false

visibleChildren = new TypedArray.Uint8 64
columnsSizes = new TypedArray.Float64 64
columnsFills = new TypedArray.Uint8 64
rowsSizes = new TypedArray.Float64 64
rowsFills = new TypedArray.Uint8 64
unusedFills = new TypedArray.Uint8 64

getArray = (arr, len) ->
    if arr.length < len
        new arr.constructor len * 1.4 | 0
    else
        arr

getCleanArray = (arr, len) ->
    newArr = getArray arr, len
    if newArr is arr
        for i in [0...len] by 1
            arr[i] = 0
        arr
    else
        newArr

ALIGNMENT_TO_POINT =
    left: 0
    center: 0.5
    right: 1
    top: 0
    bottom: 1

updateItem = (item) ->
    unless effectItem = item._effectItem
        return

    {includeBorderMargins} = item
    {children} = effectItem
    firstChild = children.firstChild
    data = item._impl
    {gridType} = data

    # get config
    {autoWidth, autoHeight} = data
    columnSpacing = rowSpacing = 0

    if layout = effectItem._layout
        autoWidth and= not layout._fillWidth
        autoHeight and= not layout._fillHeight

    if gridType is ALL
        columnsLen = item.columns
        rowsLen = item.rows
        columnSpacing = item.spacing.column
        rowSpacing = item.spacing.row
    else if gridType is COLUMN
        rowSpacing = item.spacing
        columnsLen = 1
        rowsLen = Infinity
    else if gridType is ROW
        columnSpacing = item.spacing
        columnsLen = Infinity
        rowsLen = 1

    if alignment = item._alignment
        alignH = ALIGNMENT_TO_POINT[alignment._horizontal]
        alignV = ALIGNMENT_TO_POINT[alignment._vertical]
    else
        alignH = 0
        alignV = 0

    if padding = item._padding
        topPadding = padding._top
        rightPadding = padding._right
        bottomPadding = padding._bottom
        leftPadding = padding._left
    else
        topPadding = rightPadding = bottomPadding = leftPadding = 0

    # get tmp variables
    maxColumnsLen = if columnsLen is Infinity then children.length else columnsLen
    columnsSizes = getCleanArray columnsSizes, maxColumnsLen
    columnsFills = getCleanArray columnsFills, maxColumnsLen

    maxRowsLen = if rowsLen is Infinity then Math.ceil(children.length / columnsLen) else rowsLen
    rowsSizes = getCleanArray rowsSizes, maxRowsLen
    rowsFills = getCleanArray rowsFills, maxRowsLen

    visibleChildren = getArray visibleChildren, children.length

    # get last column and last row
    i = lastColumn = 0
    lastRow = -1
    nextChild = firstChild
    childIndex = -1
    while child = nextChild
        childIndex += 1
        nextChild = child.nextSibling
        # check visibility
        if not child._visible or (child._layout and not child._layout._enabled)
            visibleChildren[childIndex] = 0
            continue
        visibleChildren[childIndex] = 1

        # get max column and max row
        column = i % columnsLen
        row = Math.floor(i / columnsLen) % rowsLen
        if column > lastColumn
            lastColumn = column
        if row > lastRow
            lastRow = row
        i++

    # get columns and rows sizes
    i = columnsFillsSum = rowsFillsSum = 0
    nextChild = firstChild
    childIndex = -1
    while child = nextChild
        childIndex += 1
        nextChild = child.nextSibling
        unless visibleChildren[childIndex]
            continue

        # child
        width = child._width
        height = child._height
        margin = child._margin
        layout = child._layout

        column = i % columnsLen
        row = Math.floor(i / columnsLen) % rowsLen

        if layout
            if layout._fillWidth
                width = 0
                columnsFillsSum++
                columnsFills[column] = 1
            if layout._fillHeight
                height = 0
                rowsFillsSum++
                rowsFills[row] = 1

        # margins
        if margin
            if includeBorderMargins or column isnt 0
                width += margin._left
            if includeBorderMargins or column isnt lastColumn
                width += margin._right
            if includeBorderMargins or row isnt 0
                height += margin._top
            if includeBorderMargins or row isnt lastRow
                height += margin._bottom

        # save
        if width > columnsSizes[column]
            columnsSizes[column] = width
        if height > rowsSizes[row]
            rowsSizes[row] = height

        i++

    # get grid size
    gridWidth = 0
    if autoWidth or columnsFillsSum > 0 or alignH isnt 0
        for i in [0..lastColumn] by 1
            gridWidth += columnsSizes[i]

    gridHeight = 0
    if autoHeight or rowsFillsSum > 0 or alignV isnt 0
        for i in [0..lastRow] by 1
            gridHeight += rowsSizes[i]

    # expand filled cells
    if not autoWidth
        freeWidthSpace = effectItem._width - columnSpacing * lastColumn - leftPadding - rightPadding - gridWidth
        if freeWidthSpace > 0 and columnsFillsSum > 0
            unusedFills = getCleanArray unusedFills, lastColumn + 1
            length = lastColumn + 1
            perCell = (gridWidth + freeWidthSpace) / length

            update = true
            while update
                update = false
                for i in [0..lastColumn] by 1
                    if unusedFills[i] is 0 and (columnsFills[i] is 0 or columnsSizes[i] > perCell)
                        length--
                        perCell -= (columnsSizes[i] - perCell) / length
                        unusedFills[i] = 1
                        update = true

            for i in [0..lastColumn] by 1
                if unusedFills[i] is 0
                    columnsSizes[i] = perCell
            freeWidthSpace = 0

    if not autoHeight
        freeHeightSpace = effectItem._height - rowSpacing * lastRow - topPadding - bottomPadding - gridHeight
        if freeHeightSpace > 0 and rowsFillsSum > 0
            unusedFills = getCleanArray unusedFills, lastRow+1
            length = lastRow+1
            perCell = (gridHeight + freeHeightSpace) / length

            update = true
            while update
                update = false
                for i in [0..lastRow] by 1
                    if unusedFills[i] is 0 and (rowsFills[i] is 0 or rowsSizes[i] > perCell)
                        length--
                        perCell -= (rowsSizes[i] - perCell) / length
                        unusedFills[i] = 1
                        update = true

            for i in [0..lastRow] by 1
                if unusedFills[i] is 0
                    rowsSizes[i] = perCell
            freeHeightSpace = 0

    # get grid content margin
    if autoWidth or alignH is 0
        plusX = 0
    else
        plusX = freeWidthSpace * alignH

    if autoHeight or alignV is 0
        plusY = 0
    else
        plusY = freeHeightSpace * alignV

    # set children positions and sizes
    i = cellX = cellY = 0
    nextChild = firstChild
    childIndex = -1
    while child = nextChild
        childIndex += 1
        nextChild = child.nextSibling
        unless visibleChildren[childIndex]
            continue

        margin = child._margin
        layout = child._layout
        anchors = child._anchors

        column = i % columnsLen
        row = Math.floor(i / columnsLen) % rowsLen

        # get cell position
        if column is 0
            cellX = 0
            if row is 0
                cellY = 0
            else
                cellY += rowsSizes[row-1] + rowSpacing
        else
            cellX += columnsSizes[column-1] + columnSpacing

        # get child margins
        leftMargin = rightMargin = 0
        if margin
            if includeBorderMargins or column isnt 0
                leftMargin = margin._left
            if includeBorderMargins or column isnt lastColumn
                rightMargin = margin._right

        topMargin = bottomMargin = 0
        if margin
            if includeBorderMargins or row isnt 0
                topMargin = margin._top
            if includeBorderMargins or row isnt lastRow
                bottomMargin = margin._bottom

        # set sizes
        if layout
            # set width
            if layout._fillWidth
                width = columnsSizes[column] - leftMargin - rightMargin
                child.width = width

            # set height
            if layout._fillHeight
                height = rowsSizes[row] - topMargin - bottomMargin
                child.height = height

        # set x
        unless anchors?._autoX
            child.x = cellX + plusX + leftMargin + leftPadding + columnsSizes[column] * alignH - (child._width + leftMargin + rightMargin) * alignH

        # set y
        unless anchors?._autoY
            child.y = cellY + plusY + topMargin + topPadding + rowsSizes[row] * alignV - (child._height + topMargin + bottomMargin) * alignV

        i++

    # set effect item size
    if autoWidth
        effectItem.width = gridWidth + columnSpacing * lastColumn + leftPadding + rightPadding

    if autoHeight
        effectItem.height = gridHeight + rowSpacing * lastRow + topPadding + bottomPadding
    return

updateItems = ->
    pending = false
    currentQueue = queue
    queue = queues[++queueIndex % queues.length]

    while currentQueue.length
        item = currentQueue.pop()
        item._impl.pending = false
        item._impl.updatePending = true
        updateItem item
        item._impl.updatePending = false
    return

update = ->
    data = @_impl
    if data.pending or not @_effectItem?._visible
        return

    data.pending = true

    if data.updatePending
        if data.gridUpdateLoops > MAX_LOOPS
            return

        if ++data.gridUpdateLoops is MAX_LOOPS
            log.error "Potential Grid/Column/Row loop detected. Recalculating on this item (#{@toString()}) has been disabled."
            return
    else
        data.gridUpdateLoops = 0

    queue.push @

    unless pending
        pending = true
        eventLoop.setImmediate updateItems
    return

updateSize = ->
    if not @_impl.updatePending
        update.call @
    return

onWidthChange = (oldVal) ->
    if @_effectItem and not @_impl.updatePending and (not (layout = @_effectItem._layout) or not layout._fillWidth)
        @_impl.autoWidth = @_effectItem._width is 0 and oldVal isnt -1
    updateSize.call @

onHeightChange = (oldVal) ->
    if @_effectItem and not @_impl.updatePending and (not (layout = @_effectItem._layout) or not layout._fillHeight)
        @_impl.autoHeight = @_effectItem._height is 0 and oldVal isnt -1
    updateSize.call @

enableChild = (child) ->
    child.onVisibleChange update, @
    child.onWidthChange updateSize, @
    child.onHeightChange updateSize, @
    child.onMarginChange update, @
    child.onAnchorsChange update, @
    child.onLayoutChange update, @

disableChild = (child) ->
    child.onVisibleChange.disconnect update, @
    child.onWidthChange.disconnect updateSize, @
    child.onHeightChange.disconnect updateSize, @
    child.onMarginChange.disconnect update, @
    child.onAnchorsChange.disconnect update, @
    child.onLayoutChange.disconnect update, @

onChildrenChange = (added, removed) ->
    if added
        enableChild.call @, added
    if removed
        disableChild.call @, removed
    update.call @

COLUMN = exports.COLUMN = 1<<0
ROW = exports.ROW = 1<<1
ALL = exports.ALL = (1<<2) - 1

exports.DATA =
    pending: false
    updatePending: false
    gridType: 0
    gridUpdateLoops: 0
    autoWidth: true
    autoHeight: true

exports.create = (item, type) ->
    item._impl.gridType = type
    item.onAlignmentChange updateSize
    item.onPaddingChange updateSize

exports.update = update

exports.setEffectItem = (item, oldItem) ->
    if oldItem
        oldItem.onVisibleChange.disconnect update, @
        oldItem.onChildrenChange.disconnect onChildrenChange, @
        oldItem.onLayoutChange.disconnect update, @
        oldItem.onWidthChange.disconnect onWidthChange, @
        oldItem.onHeightChange.disconnect onHeightChange, @

        child = oldItem.children.firstChild
        while child
            disableChild.call @, child
            child = child.nextSibling

    if item
        if @_impl.autoWidth = item.width is 0
            item.width = -1
        if @_impl.autoHeight = item.height is 0
            item.height = -1

        item.onVisibleChange update, @
        item.onChildrenChange onChildrenChange, @
        item.onLayoutChange update, @
        item.onWidthChange onWidthChange, @
        item.onHeightChange onHeightChange, @

        child = item.children.firstChild
        while child
            enableChild.call @, child
            child = child.nextSibling

        update.call @

    return
