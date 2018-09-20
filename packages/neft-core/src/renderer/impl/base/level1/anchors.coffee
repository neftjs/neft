'use strict'

assert = require '../../../../assert'
log = require '../../../../log'
utils = require '../../../../util'
eventLoop = require '../../../../event-loop'

log = log.scope 'Renderer', 'Anchors'

{isArray} = Array

module.exports = (impl) ->
    GET_ZERO = -> 0

    MAX_LOOPS = 10

    queueIndex = 0
    queues = [[], []]
    queue = queues[queueIndex]
    pending = false

    updateItems = ->
        pending = false
        currentQueue = queue
        queue = queues[++queueIndex % queues.length]

        while currentQueue.length
            anchor = currentQueue.pop()
            anchor.pending = false
            anchor.update()
        return

    update = ->
        if @pending
            return

        @pending = true
        queue.push @
        unless pending
            pending = true
            eventLoop.setImmediate updateItems
        return

    getItemProp =
        left: 'x'
        top: 'y'
        right: 'x'
        bottom: 'y'
        horizontalCenter: 'x'
        verticalCenter: 'y'
        fillWidthSize: 'width'
        fillHeightSize: 'height'

    getSourceWatchProps =
        left: ['onMarginChange']
        top: ['onMarginChange']
        right: ['onMarginChange', 'onWidthChange']
        bottom: ['onMarginChange', 'onHeightChange']
        horizontalCenter: ['onMarginChange', 'onWidthChange']
        verticalCenter: ['onMarginChange', 'onHeightChange']
        fillWidthSize: ['onMarginChange']
        fillHeightSize: ['onMarginChange']

    getTargetWatchProps =
        left:
            parent: []
            children: []
            sibling: ['onXChange']
        top:
            parent: []
            children: []
            sibling: ['onYChange']
        right:
            parent: ['onWidthChange']
            sibling: ['onXChange', 'onWidthChange']
        bottom:
            parent: ['onHeightChange']
            sibling: ['onYChange', 'onHeightChange']
        horizontalCenter:
            parent: ['onWidthChange']
            sibling: ['onXChange', 'onWidthChange']
        verticalCenter:
            parent: ['onHeightChange']
            sibling: ['onYChange', 'onHeightChange']
        fillWidthSize:
            parent: ['onWidthChange']
            children: []
            sibling: ['onWidthChange']
        fillHeightSize:
            parent: ['onHeightChange']
            children: []
            sibling: ['onHeightChange']

    getSourceValue =
        left: (item) ->
            0
        top: (item) ->
            0
        right: (item) ->
            -item._width
        bottom: (item) ->
            -item._height
        horizontalCenter: (item) ->
            -item._width / 2
        verticalCenter: (item) ->
            -item._height / 2
        fillWidthSize: (item) ->
            0
        fillHeightSize: (item) ->
            0

    getTargetValue =
        left:
            parent: (target) ->
                0
            children: (target) ->
                0
            sibling: (target) ->
                target._x
        top:
            parent: (target) ->
                0
            children: (target) ->
                0
            sibling: (target) ->
                target._y
        right:
            parent: (target) ->
                target._width
            sibling: (target) ->
                target._x + target._width
        bottom:
            parent: (target) ->
                target._height
            sibling: (target) ->
                target._y + target._height
        horizontalCenter:
            parent: (target) ->
                target._width / 2
            sibling: (target) ->
                target._x + target._width / 2
        verticalCenter:
            parent: (target) ->
                target._height / 2
            sibling: (target) ->
                target._y + target._height / 2
        fillWidthSize:
            parent: (target) ->
                target._width
            children: (target) ->
                tmp = 0
                size = 0
                child = target.firstChild
                while child
                    if child._visible
                        tmp = child._x + child._width
                        if tmp > size
                            size = tmp
                    child = child.nextSibling
                size
            sibling: (target) ->
                target._width
        fillHeightSize:
            parent: (target) ->
                target._height
            children: (target) ->
                tmp = 0
                size = 0
                child = target.firstChild
                while child
                    if child._visible
                        tmp = child._y + child._height
                        if tmp > size
                            size = tmp
                    child = child.nextSibling
                size
            sibling: (target) ->
                target._height

    getMarginValue =
        left: (margin) ->
            margin._left
        top: (margin) ->
            margin._top
        right: (margin) ->
            -margin._right
        bottom: (margin) ->
            -margin._bottom
        horizontalCenter: (margin) ->
            margin._left - margin._right
        verticalCenter: (margin) ->
            margin._top - margin._bottom
        fillWidthSize: (margin) ->
            -margin._left - margin._right
        fillHeightSize: (margin) ->
            -margin._top - margin._bottom

    onParentChange = (oldVal) ->
        if oldVal
            for handler in getTargetWatchProps[@line].parent
                oldVal[handler].disconnect update, @

        if val = @targetItem = @item._parent
            for handler in getTargetWatchProps[@line].parent
                val[handler] update, @

        update.call @
        return

    onNextSiblingChange = (oldVal) ->
        if oldVal
            for handler in getTargetWatchProps[@line].sibling
                oldVal[handler].disconnect update, @

        if val = @targetItem = @item._nextSibling
            for handler in getTargetWatchProps[@line].sibling
                val[handler] update, @

        update.call @
        return

    onPreviousSiblingChange = (oldVal) ->
        if oldVal
            for handler in getTargetWatchProps[@line].sibling
                oldVal[handler].disconnect update, @

        if val = @targetItem = @item._previousSibling
            for handler in getTargetWatchProps[@line].sibling
                val[handler] update, @

        update.call @
        return

    onChildInsert = (child) ->
        child.onVisibleChange update, @
        if @source is 'fillWidthSize'
            child.onXChange update, @
            child.onWidthChange update, @
        if @source is 'fillHeightSize'
            child.onYChange update, @
            child.onHeightChange update, @

        update.call @
        return

    onChildPop = (child) ->
        child.onVisibleChange.disconnect update, @
        if @source is 'fillWidthSize'
            child.onXChange.disconnect update, @
            child.onWidthChange.disconnect update, @
        if @source is 'fillHeightSize'
            child.onYChange.disconnect update, @
            child.onHeightChange.disconnect update, @

        update.call @
        return

    onChildrenChange = (added, removed) ->
        if added
            onChildInsert.call @, added
        if removed
            onChildPop.call @, removed

    class Anchor
        pool = []

        @factory = (item, source, def) ->
            if pool.length > 0 and (elem = pool.pop())
                Anchor.call elem, item, source, def
                elem
            else
                new Anchor item, source, def

        constructor: (@item, @source, def) ->
            item = @item
            source = @source
            [target, line] = def
            line ?= source
            @target = target
            @line = line
            @pending = false
            @updateLoops = 0

            if target is 'parent' or item._parent is target
                @type = 'parent'
            else if target is 'children'
                @type = 'children'
            else
                @type = 'sibling'

            for handler in getSourceWatchProps[source]
                item[handler] update, @

            @prop = getItemProp[source]
            @getSourceValue = getSourceValue[source]
            @getTargetValue = getTargetValue[line][@type]
            @targetItem = null

            Object.seal @

            if typeof @getTargetValue isnt 'function'
                @getTargetValue = GET_ZERO
                log.error "Unknown anchor `#{@}` given"

            switch target
                when 'parent'
                    @targetItem = item._parent
                    item.onParentChange onParentChange, @
                    onParentChange.call @, null
                when 'children'
                    @targetItem = item.children
                    item.onChildrenChange onChildrenChange, @
                    child = @targetItem.firstChild
                    while child
                        onChildInsert.call @, child
                        child = child.nextSibling
                when 'nextSibling'
                    @targetItem = item._nextSibling
                    item.onNextSiblingChange onNextSiblingChange, @
                    onNextSiblingChange.call @, null
                when 'previousSibling'
                    @targetItem = item._previousSibling
                    item.onPreviousSiblingChange onPreviousSiblingChange, @
                    onPreviousSiblingChange.call @, null
                else
                    if not utils.isObject(target) or handler not of target
                        log.error "Unknown anchor `#{@}` given"
                        return
                    if @targetItem = target
                        for handler in getTargetWatchProps[line][@type]
                            @targetItem[handler] update, @
                    update.call @

        update: ->
            # sometimes it can be already destroyed
            if not @item or @updateLoops >= MAX_LOOPS
                return

            # targetItem can be possibly different than actual value;
            # e.g. when Anchor listener to change targetItem is not called firstly
            switch @target
                when 'parent'
                    targetItem = @item._parent
                when 'children'
                    targetItem = @item.children
                when 'nextSibling'
                    targetItem = @item._nextSibling
                when 'previousSibling'
                    targetItem = @item._previousSibling
                else
                    {targetItem} = @
            if not targetItem or targetItem isnt @targetItem
                return

            if targetItem
                `//<development>`
                fails = @item._parent
                fails &&= targetItem isnt @item._children
                fails &&= @item._parent isnt targetItem
                fails &&= @item._parent isnt targetItem._parent
                if fails
                    log.error """
                        Invalid anchor point; \
                        you can anchor only to a parent or a sibling; \
                        item '#{@item.toString()}.anchors.#{@source}: #{@target}'
                    """
                `//</development>`

                r = @getSourceValue(@item) + @getTargetValue(targetItem)
            else
                r = 0
            if margin = @item._margin
                r += getMarginValue[@source] margin

            @updateLoops++
            @item[@prop] = r
            if @updateLoops is MAX_LOOPS
                log.error """
                    Potential anchors loop detected; \
                    recalculating on this anchor (#{@}) has been disabled
                """
                @updateLoops++
            else if @updateLoops < MAX_LOOPS
                @updateLoops--
            return

        destroy: ->
            switch @target
                when 'parent'
                    @item.onParentChange.disconnect onParentChange, @
                when 'children'
                    @item.onChildrenChange.disconnect onChildrenChange, @
                    child = @item.children.firstChild
                    while child
                        onChildPop.call @, child, -1
                        child = child.nextSibling
                when 'nextSibling'
                    @item.onNextSiblingChange.disconnect onNextSiblingChange, @
                when 'previousSibling'
                    @item.onPreviousSiblingChange.disconnect onPreviousSiblingChange, @

            for handler in getSourceWatchProps[@source]
                @item[handler].disconnect update, @

            if @targetItem
                for handler in getTargetWatchProps[@line][@type]
                    @targetItem[handler].disconnect update, @

            @item = @targetItem = null

            pool.push @
            return

        toString: ->
            "#{@item.toString()}.anchors.#{@source}: #{@target}.#{@line}"

    getBaseAnchors =
        centerIn: ['horizontalCenter', 'verticalCenter']
        fillWidth: ['fillWidthSize', 'left']
        fillHeight: ['fillHeightSize', 'top']
        fill: ['fillWidthSize', 'fillHeightSize', 'left', 'top']

    getBaseAnchorsPerAnchorType =
        __proto__: null

    isMultiAnchor = (source) ->
        !!getBaseAnchors[source]

    class MultiAnchor
        pool = []

        @factory = (item, source, def) ->
            if elem = pool.pop()
                MultiAnchor.call elem, item, source, def
                elem
            else
                new MultiAnchor item, source, def

        constructor: (item, source, def) ->
            assert.lengthOf def, 1
            @anchors = []
            def = [def[0], '']
            @pending = false

            baseAnchors = getBaseAnchorsPerAnchorType[def[0]]?[source]
            baseAnchors ?= getBaseAnchors[source]
            for line in baseAnchors
                def[1] = line
                anchor = Anchor.factory item, line, def
                @anchors.push anchor
            return

        update: ->
            for anchor in @anchors
                anchor.update()
            return

        destroy: ->
            for anchor in @anchors
                anchor.destroy()
            pool.push @
            return

    createAnchor = (item, source, def) ->
        if isMultiAnchor(source)
            MultiAnchor.factory item, source, def
        else
            Anchor.factory item, source, def

    exports =
    setItemAnchor: (type, val) ->
        if val isnt null
            assert.isArray val

        anchors = @_impl.anchors ?= {}

        if not val and not anchors[type]
            return

        if anchors[type]
            anchors[type].destroy()
            anchors[type] = null

        if val
            anchors[type] = createAnchor(@, type, val)

        return
