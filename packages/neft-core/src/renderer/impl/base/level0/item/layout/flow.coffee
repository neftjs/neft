'use strict'

utils = require '../../../../../../util'
log = require '../../../../../../log'
eventLoop = require '../../../../../../event-loop'
TypedArray = require '../../../../../../typed-array'

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

rowsWidth = new TypedArray.Float64 64
rowsHeight = new TypedArray.Float64 64
elementsX = new TypedArray.Float64 64
elementsY = new TypedArray.Float64 64
elementsRow = new TypedArray.Float64 64
elementsBottomMargin = new TypedArray.Float64 64
rowsFills = new TypedArray.Uint8 64
unusedFills = new TypedArray.Uint8 64

updateItem = (item) ->
    children = item._children
    firstChild = children.firstChild
    data = item._impl
    {autoWidth, autoHeight} = data

    autoWidth &&= !item._fillWidth
    autoHeight &&= !item._fillHeight

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
    maxFlowWidth = if autoWidth then Infinity else item._width - leftPadding - rightPadding
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

        margin = child._margin
        anchors = child._anchors
        width = child._width
        height = child._height

        # omit not visible
        if not child._visible or (anchors and anchors._runningCount)
            continue

        # get child margins
        if margin
            topMargin = margin._top
            rightMargin = margin._right
            bottomMargin = margin._bottom
            leftMargin = margin._left
        else
            topMargin = rightMargin = bottomMargin = leftMargin = 0

        # fill width
        if child._fillWidth and not autoWidth
            width = maxFlowWidth - leftMargin - rightMargin
            child.width = width

        # get child right anchor position
        right = 0
        x += leftMargin + lastColumnRightMargin + (if x > 0 then columnSpacing else 0)
        right += x + width + rightMargin

        # get x
        if right > maxFlowWidth and visibleChildrenIndex > 0
            right -= x
            x = right - width
            currentRowY += rowsHeight[currentRow]
            currentRow++
            lastRowBottomMargin = currentRowBottomMargin
            currentRowBottomMargin = 0

        # fill height
        if child._fillHeight and not autoHeight
            rowsFills[currentRow] = max rowsFills[currentRow], rowsFills[currentRow] + 1
            rowsFillsSum++
            height = 0
            elementsBottomMargin[i] = bottomMargin

        # get child bottom anchor position
        bottom = y + height

        # get y
        y = currentRowY
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
    flowHeight = max flowHeight, flowHeight + currentRowBottomMargin

    # expand filled rows
    freeHeightSpace = item._height - topPadding - bottomPadding - flowHeight
    if freeHeightSpace > 0 and rowsFillsSum > 0
        length = currentRow + 1
        unusedFills = getCleanArray unusedFills, length
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
        row = -1
        i = -1
        while child = nextChild
            i += 1
            nextChild = child.nextSibling
            anchors = child._anchors

            # omit not visible
            if not child._visible or (anchors and anchors._runningCount)
                continue

            if elementsRow[i] is row + 1 and unusedFills[row] is 0
                yShift += currentYShift
                currentYShift = 0
            row = elementsRow[i]
            elementsY[i] += yShift
            if unusedFills[row] is 0
                if child._fillHeight
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
        flowWidth = item._width - leftPadding - rightPadding
    unless autoHeight
        flowHeight = item._height - topPadding - bottomPadding
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

        if anchors and anchors._runningCount
            continue

        child.x = elementsX[i] + (flowWidth - rowsWidth[cell]) * multiplierX + leftPadding
        child.y = elementsY[i] + plusY + (rowsHeight[cell] - child._height) * multiplierY + topPadding

    # set item size
    if autoWidth
        item.width = flowWidth + leftPadding + rightPadding

    if autoHeight
        item.height = flowHeight + topPadding + bottomPadding

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

    if data.pending or not @_visible
        return

    unless data.loops++
        cleanQueue.push data
        unless cleanPending
            setTimeout clean
            cleanPending = true

    data.pending = true
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

    turnOff: (item, oldItem) ->
        @onAlignmentChange.disconnect updateSize
        @onPaddingChange.disconnect update
        @onVisibleChange.disconnect update
        @onChildrenChange.disconnect onChildrenChange
        @onWidthChange.disconnect onWidthChange
        @onHeightChange.disconnect onHeightChange

        if @_impl.autoWidth
            @width = 0
        if @_impl.autoHeight
            @height = 0

        child = @children.firstChild
        while child
            disableChild.call @, child
            child = child.nextSibling

        return

    turnOn: ->
        @onAlignmentChange.connect updateSize
        @onPaddingChange.connect update
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

    update: update
