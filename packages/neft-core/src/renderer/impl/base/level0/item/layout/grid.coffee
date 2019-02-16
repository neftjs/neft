'use strict'

MAX_LOOPS = 100

utils = require '../../../../../../util'
log = require '../../../../../../log'
eventLoop = require '../../../../../../event-loop'
TypedArray = require '../../../../../../typed-array'

log = log.scope 'Renderer'

COLUMN = 1<<0
ROW = 1<<1
ALL = (1<<2) - 1

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
    {children} = item
    firstChild = children.firstChild
    data = item._impl
    {gridType} = data

    # get config
    {autoWidth, autoHeight} = data
    columnSpacing = rowSpacing = 0

    autoWidth and= not item._fillWidth
    autoHeight and= not item._fillHeight

    columnSpacing = item.spacing.column
    rowSpacing = item.spacing.row
    if gridType is ALL
        columnsLen = item.columns
        rowsLen = item.rows
    else if gridType is COLUMN
        columnsLen = 1
        rowsLen = Infinity
    else if gridType is ROW
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
        if not child._visible or (child._anchors and child._anchors._runningCount)
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

        column = i % columnsLen
        row = Math.floor(i / columnsLen) % rowsLen

        if child._fillWidth
            width = 0
            columnsFillsSum++
            columnsFills[column] = 1
        if child._fillHeight
            height = 0
            rowsFillsSum++
            rowsFills[row] = 1

        # margins
        if margin
            width += margin._left
            width += margin._right
            height += margin._top
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
        freeWidthSpace = item._width - columnSpacing * lastColumn - leftPadding - rightPadding - gridWidth
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
        freeHeightSpace = item._height - rowSpacing * lastRow - topPadding - bottomPadding - gridHeight
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
            leftMargin = margin._left
            rightMargin = margin._right

        topMargin = bottomMargin = 0
        if margin
            topMargin = margin._top
            bottomMargin = margin._bottom

        # set width
        if child._fillWidth
            width = columnsSizes[column] - leftMargin - rightMargin
            child.width = width

        # set height
        if child._fillHeight
            height = rowsSizes[row] - topMargin - bottomMargin
            child.height = height

        # set x
        child.x = cellX + plusX + leftMargin + leftPadding + columnsSizes[column] * alignH - (child._width + leftMargin + rightMargin) * alignH

        # set y
        child.y = cellY + plusY + topMargin + topPadding + rowsSizes[row] * alignV - (child._height + topMargin + bottomMargin) * alignV

        i++

    # set effect item size
    if autoWidth
        item.width = gridWidth + columnSpacing * lastColumn + leftPadding + rightPadding

    if autoHeight
        item.height = gridHeight + rowSpacing * lastRow + topPadding + bottomPadding
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
    if data.pending or not @_visible
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

module.exports = (impl) ->
    onWidthChange = (oldVal) ->
        @_impl.autoWidth = impl.Renderer.sizeUtils.isAutoWidth @
        updateSize.call @

    onHeightChange = (oldVal) ->
        @_impl.autoHeight = impl.Renderer.sizeUtils.isAutoHeight @
        updateSize.call @

    enableChild = (child) ->
        child.onVisibleChange.connect update, @
        child.onWidthChange.connect updateSize, @
        child.onHeightChange.connect updateSize, @
        child.onFillWidthChange.connect update, @
        child.onFillHeightChange.connect update, @
        child.onMarginChange.connect update, @
        child.onAnchorsChange.connect update, @

    disableChild = (child) ->
        child.onVisibleChange.disconnect update, @
        child.onWidthChange.disconnect updateSize, @
        child.onHeightChange.disconnect updateSize, @
        child.onFillWidthChange.disconnect update, @
        child.onFillHeightChange.disconnect update, @
        child.onMarginChange.disconnect update, @
        child.onAnchorsChange.disconnect update, @

    onChildrenChange = (added, removed) ->
        if added
            enableChild.call @, added
        if removed
            disableChild.call @, removed
        update.call @

    COLUMN: COLUMN
    ROW: ROW
    ALL: ALL

    update: update

    turnOff: ->
        @onAlignmentChange.disconnect updateSize
        @onPaddingChange.disconnect updateSize
        @onVisibleChange.disconnect update
        @onChildrenChange.disconnect onChildrenChange
        @onWidthChange.disconnect onWidthChange
        @onHeightChange.disconnect onHeightChange

        child = @children.firstChild
        while child
            disableChild.call @, child
            child = child.nextSibling

        return

    turnOn: (gridType) ->
        @_impl.gridType = gridType
        @onAlignmentChange.connect updateSize
        @onPaddingChange.connect updateSize
        @onVisibleChange.connect update
        @onChildrenChange.connect onChildrenChange
        @onWidthChange.connect onWidthChange
        @onHeightChange.connect onHeightChange

        child = @children.firstChild
        while child
            enableChild.call @, child
            child = child.nextSibling

        update.call @

        return
