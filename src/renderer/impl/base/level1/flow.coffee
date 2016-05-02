'use strict'

utils = require 'src/utils'
log = require 'src/log'
TypedArray = require 'src/typed-array'

log = log.scope 'Renderer', 'Flow'

MAX_LOOPS = 150

min = (a, b) ->
    if a < b
        a
    else
        b

max = (a, b) ->
    if a > b
        a
    else
        b

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

queueIndex = 0
queues = [[], []]
queue = queues[queueIndex]
pending = false

rowsWidth = new TypedArray.Uint32 64
rowsHeight = new TypedArray.Uint32 64
elementsX = new TypedArray.Uint32 64
elementsY = new TypedArray.Uint32 64
elementsRow = new TypedArray.Uint32 64
elementsBottomMargin = new TypedArray.Uint32 64
rowsFills = new TypedArray.Uint8 64
unusedFills = new TypedArray.Uint8 64

updateItem = (item) ->
    unless effectItem = item._effectItem
        return

    {includeBorderMargins, collapseMargins} = item
    children = effectItem._children
    firstChild = children.firstChild
    data = item._impl
    {autoWidth, autoHeight} = data

    if item._children?._layout
        return

    if layout = effectItem._layout
        autoWidth &&= !layout._fillWidth
        autoHeight &&= !layout._fillHeight

    if data.loops is MAX_LOOPS
        log.error "Potential Flow loop detected. Recalculating on this item (#{item.toString()}) has been disabled."
        data.loops++
        return
    else if data.loops > MAX_LOOPS
        return

    # get config
    if padding = item._padding
        topPadding = padding._top
        rightPadding = padding._right
        bottomPadding = padding._bottom
        leftPadding = padding._left
    else
        topPadding = rightPadding = bottomPadding = leftPadding = 0
    maxFlowWidth = if autoWidth then Infinity else effectItem._width - leftPadding - rightPadding
    columnSpacing = item.spacing.column
    rowSpacing = item.spacing.row

    if item._alignment
        alignH = item._alignment._horizontal
        alignV = item._alignment._vertical
    else
        alignH = 'left'
        alignV = 'top'

    # get tmp arrays
    maxLen = children.length
    rowsFills = getCleanArray rowsFills, maxLen
    if elementsX.length < maxLen
        maxLen *= 1.5
        rowsWidth = getArray rowsWidth, maxLen
        rowsHeight = getArray rowsHeight, maxLen
        elementsX = getArray elementsX, maxLen
        elementsY = getArray elementsY, maxLen
        elementsRow = getArray elementsRow, maxLen
        elementsBottomMargin = getArray elementsBottomMargin, maxLen

    # tmp vars
    flowWidth = flowHeight = 0
    currentRow = currentRowY = 0
    lastColumnRightMargin = lastRowBottomMargin = currentRowBottomMargin = 0
    x = y = right = bottom = 0

    # calculate children positions
    rowsFillsSum = visibleChildrenIndex = 0
    nextChild = firstChild
    i = -1
    while child = nextChild
        i += 1
        nextChild = child.nextSibling
        # omit not visible
        if not child._visible
            continue

        margin = child._margin
        layout = child._layout
        width = child._width
        height = child._height

        # get child margins
        if margin
            topMargin = margin._top
            rightMargin = margin._right
            bottomMargin = margin._bottom
            leftMargin = margin._left

            if childLayoutMargin = child._children?._layout?._margin
                if collapseMargins
                    topMargin = max topMargin, childLayoutMargin._top
                    rightMargin = max rightMargin, childLayoutMargin._right
                    bottomMargin = max bottomMargin, childLayoutMargin._bottom
                    leftMargin = max leftMargin, childLayoutMargin._left
                else
                    topMargin += childLayoutMargin._top
                    rightMargin += childLayoutMargin._right
                    bottomMargin += childLayoutMargin._bottom
                    leftMargin += childLayoutMargin._left
        else
            topMargin = rightMargin = bottomMargin = leftMargin = 0

        # width layout fill
        if layout
            unless layout._enabled
                continue

            if layout._fillWidth and not autoWidth
                width = maxFlowWidth
                if includeBorderMargins
                    width -= leftMargin + rightMargin

                child.width = width

        # get child right anchor position
        right = 0
        if includeBorderMargins or x > 0
            if collapseMargins
                x += max leftMargin + (if x > 0 then columnSpacing else 0), lastColumnRightMargin
            else
                x += leftMargin + lastColumnRightMargin + (if x > 0 then columnSpacing else 0)
        right += x + width
        if includeBorderMargins
            right += rightMargin

        # get x
        if right > maxFlowWidth and visibleChildrenIndex > 0
            right -= x
            x = right - width
            currentRowY += rowsHeight[currentRow]
            currentRow++
            lastRowBottomMargin = currentRowBottomMargin
            currentRowBottomMargin = 0

        # height layout fill
        if layout and layout._fillHeight and not autoHeight
            rowsFills[currentRow] = max rowsFills[currentRow], rowsFills[currentRow] + 1
            rowsFillsSum++
            height = 0
            elementsBottomMargin[i] = bottomMargin

        # get child bottom anchor position
        bottom = y + height

        # get y
        y = currentRowY
        if includeBorderMargins or y > 0
            if collapseMargins
                y += max lastRowBottomMargin, topMargin + (if y > 0 then rowSpacing else 0)
            else
                y += lastRowBottomMargin + topMargin + (if y > 0 then rowSpacing else 0)

        # last margins
        lastColumnRightMargin = rightMargin
        currentRowBottomMargin = max currentRowBottomMargin, bottomMargin

        # save data
        elementsX[i] = x
        elementsY[i] = y
        elementsRow[i] = currentRow

        # flow size
        flowWidth = max flowWidth, right
        flowHeight = max flowHeight, y + height

        # get cell size
        rowsWidth[currentRow] = right
        rowsHeight[currentRow] = flowHeight - currentRowY

        # increase x and y by the size
        x += width
        y += height

        visibleChildrenIndex++

    # flow size
    if includeBorderMargins
        flowHeight = max flowHeight, flowHeight + currentRowBottomMargin

    # expand filled rows
    freeHeightSpace = effectItem._height - topPadding - bottomPadding - flowHeight
    if freeHeightSpace > 0 and rowsFillsSum > 0
        unusedFills = getCleanArray unusedFills, currentRow+1
        length = currentRow+1
        perCell = (flowHeight + freeHeightSpace) / length

        update = true
        while update
            update = false
            for i in [0..currentRow] by 1
                if unusedFills[i] is 0 and (rowsFills[i] is 0 or rowsHeight[i] > perCell)
                    length--
                    perCell -= (rowsHeight[i] - perCell) / length
                    unusedFills[i] = 1
                    update = true

        yShift = currentYShift = 0
        nextChild = firstChild
        i = -1
        while child = nextChild
            i += 1
            nextChild = child.nextSibling
            if elementsRow[i] is row + 1 and unusedFills[row] is 0
                yShift += currentYShift
                currentYShift = 0
            row = elementsRow[i]
            elementsY[i] += yShift
            if unusedFills[row] is 0
                layout = child._layout
                if layout and layout._fillHeight and layout._enabled
                    child.height = perCell# - elementsBottomMargin[i]
                    unless currentYShift
                        currentYShift = perCell - rowsHeight[row]
                        rowsHeight[row] = perCell
        freeHeightSpace = 0

    # set children positions
    switch alignH
        when 'left'
            multiplierX = 0
        when 'center'
            multiplierX = 0.5
        when 'right'
            multiplierX = 1
    switch alignV
        when 'top'
            multiplierY = 0
        when 'center'
            multiplierY = 0.5
        when 'bottom'
            multiplierY = 1
    if autoHeight or alignV is 'top'
        plusY = 0
    else
        plusY = freeHeightSpace * multiplierY
    unless autoWidth
        flowWidth = effectItem._width - leftPadding - rightPadding
    unless autoHeight
        flowHeight = effectItem._height - topPadding - bottomPadding
    nextChild = firstChild
    i = -1
    while child = nextChild
        i += 1
        nextChild = child.nextSibling
        # omit not visible
        unless child._visible
            continue

        cell = elementsRow[i]
        anchors = child._anchors
        layout = child._layout

        if layout and not layout._enabled
            continue

        if not anchors or not anchors._autoX
            child.x = elementsX[i] + (flowWidth - rowsWidth[cell]) * multiplierX + leftPadding
        if not anchors or not anchors._autoY
            child.y = elementsY[i] + plusY + (rowsHeight[cell] - child._height) * multiplierY + topPadding

    # set item size
    if autoWidth
        effectItem.width = flowWidth + leftPadding + rightPadding

    if autoHeight
        effectItem.height = flowHeight + topPadding + bottomPadding

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

cleanPending = false
cleanQueue = []
clean = ->
    cleanPending = false
    while data = cleanQueue.pop()
        if data.loops < MAX_LOOPS
            data.loops = 0
    return

update = ->
    data = @_impl

    if data.pending or not @_effectItem?._visible
        return

    unless data.loops++
        cleanQueue.push data
        unless cleanPending
            setTimeout clean
            cleanPending = true

    data.pending = true
    queue.push @

    unless pending
        setImmediate updateItems
        pending = true
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
    child.onWidthChange update, @
    child.onHeightChange update, @
    child.onMarginChange update, @
    child.onAnchorsChange update, @
    child.onLayoutChange update, @

disableChild = (child) ->
    child.onVisibleChange.disconnect update, @
    child.onWidthChange.disconnect update, @
    child.onHeightChange.disconnect update, @
    child.onMarginChange.disconnect update, @
    child.onAnchorsChange.disconnect update, @
    child.onLayoutChange.disconnect update, @

onChildrenChange = (added, removed) ->
    if added
        enableChild.call @, added
    if removed
        disableChild.call @, removed
    update.call @

module.exports = (impl) ->
    DATA =
        loops: 0
        pending: false
        updatePending: false
        autoWidth: true
        autoHeight: true

    DATA: DATA

    createData: impl.utils.createDataCloner 'Item', DATA

    create: (data) ->
        impl.Types.Item.create.call @, data
        @onAlignmentChange updateSize
        @onPaddingChange update

    setFlowEffectItem: (item, oldItem) ->
        if oldItem
            oldItem.onVisibleChange.disconnect update, @
            oldItem.onChildrenChange.disconnect onChildrenChange, @
            oldItem.onLayoutChange.disconnect update, @
            oldItem.onWidthChange.disconnect onWidthChange, @
            oldItem.onHeightChange.disconnect onHeightChange, @

            if @_impl.autoWidth
                oldItem.width = 0
            if @_impl.autoHeight
                oldItem.height = 0

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

    setFlowColumnSpacing: update
    setFlowRowSpacing: update
    setFlowIncludeBorderMargins: update
    setFlowCollapseMargins: update
