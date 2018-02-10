'use strict'

assert = require 'src/assert'
utils = require 'src/utils'
signal = require 'src/signal'
log = require 'src/log'
eventLoop = require 'src/eventLoop'
Renderer = require 'src/renderer'

log = log.scope 'Styles'

PROPS_CLASS_PRIORITY = 9999
PROP_PREFIX = 'style:'

module.exports = (File, data) -> class Style
    {windowStyle, styles, queries} = data
    {Element} = File
    {Tag, Text} = Element

    @__name__ = 'Style'
    @__path__ = 'File.Style'

    @STYLE_ID_PROP = STYLE_ID_PROP = 'n-style'
    @JSON_CTOR_ID = File.Style?.JSON_CTOR_ID
    @JSON_CTOR_ID ?= File.JSON_CTORS.push(Style) - 1
    {JSON_CTOR_ID} = @

    i = 1
    JSON_NODE = i++
    JSON_PROPS = i++
    JSON_CHILDREN = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @applyStyleQueriesInDocument = (file, localQueries = queries) ->
        assert.instanceOf file, File

        for elem in localQueries
            nodes = file.node.queryAll elem.query
            for node in nodes
                unless node instanceof Tag
                    log.warn 'query can be attached only to tags; ' +
                        "query '#{elem.query}' has been omitted for this node"
                    continue
                node.props.set STYLE_ID_PROP, elem.style

        file

    @createStylesInDocument = do ->
        nStyleWarned = false
        getStyleAttrs = (node) ->
            props = null
            for prop of node.props when node.props.hasOwnProperty(prop)
                isStyleProp = prop.slice(0, 8) is 'n-style:'
                if isStyleProp and not nStyleWarned
                    nStyleWarned = true
                    log.warn 'n-style is deprecated, use style instead'
                isStyleProp ||= prop.slice(0, 6) is 'style:'
                if isStyleProp
                    props ?= {}
                    props[prop] = true
            props

        forNode = (file, node, parentStyle) ->
            isText = node instanceof Text
            if isText or node.props[STYLE_ID_PROP]
                style = new Style
                style.file = file
                style.node = node
                style.parent = parentStyle
                style.props = not isText and getStyleAttrs node

                if parentStyle
                    parentStyle.children.push style
                else
                    file.styles.push style

                parentStyle = style

            unless isText
                for child in node.children
                    forNode file, child, parentStyle
            return

        (file) ->
            assert.instanceOf file, File
            forNode file, file.node, null
            file

    @extendDocumentByStyles = (file) ->
        assert.instanceOf file, File

        Style.applyStyleQueriesInDocument file
        Style.createStylesInDocument file

        file

    @_fromJSON = (file, arr, obj) ->
        unless obj
            obj = new Style
        obj.file = file
        obj.node = file.node.getChildByAccessPath arr[JSON_NODE]
        obj.props = arr[JSON_PROPS]

        for child in arr[JSON_CHILDREN]
            cloneChild = Style._fromJSON file, child
            cloneChild.parent = obj
            obj.children.push cloneChild

        obj

    constructor: ->
        @file = null
        @node = null
        @props = null
        @parent = null
        @children = []
        @isAutoParent = true
        @usesWindowItem = false
        @item = null
        @scope = null
        @textProp = ''
        @propsClass = null

        Object.seal @

    createClassWithPriority: (priority) ->
        assert.ok @item

        r = Renderer.Class.New()
        r.target = @item
        if priority?
            r.priority = priority
        r

    getTextProp: ->
        {item} = @
        assert.isDefined item
        assert.notOk @textProp

        if @node instanceof Text or 'text' of item
            "#{PROP_PREFIX}text"
        else
            ''

    updateText: ->
        {textProp, node} = @
        assert.ok textProp

        isText = node instanceof Text

        if node instanceof Tag
            text = node.stringifyChildren()
        else
            text = node.text

        @setProp textProp, text
        return

    setPropsClassAttribute: (attr, val) ->
        assert.instanceOf @, Style

        unless @propsClass
            @propsClass = @createClassWithPriority PROPS_CLASS_PRIORITY

        {propsClass} = @

        propsClass.running = false
        propsClass.changes.setAttribute attr, val
        propsClass.running = true

        return

    setProp: do ->
        DEPRECATED_PREFIX = 'n-style:'

        getPropWithoutPrefix = (prop) ->
            if prop.slice(0, DEPRECATED_PREFIX.length) is DEPRECATED_PREFIX
                prop.slice DEPRECATED_PREFIX.length
            else
                prop.slice PROP_PREFIX.length

        getSplitProp = do ->
            cache = Object.create null
            (prop) ->
                cache[prop] ||= getPropWithoutPrefix(prop).split ':'

        getPropertyPath = do ->
            cache = Object.create null
            (prop) ->
                cache[prop] ||= getPropWithoutPrefix(prop).replace /:/g, '.'

        getInternalProperty = do ->
            cache = Object.create null
            (prop) ->
                cache[prop] ||= "_#{prop}"

        (prop, val, oldVal) ->
            assert.instanceOf @, Style

            parts = getSplitProp prop

            # get object
            obj = @item
            return unless obj
            for i in [0...parts.length - 1] by 1
                unless obj = obj[parts[i]]
                    log.warn "Attribute '#{prop}' doesn't exist in item '#{@item}'"
                    return false

            # break if property doesn't exist
            lastPart = utils.last parts
            unless lastPart of obj
                log.warn "Attribute '#{prop}' doesn't exist in item '#{@item}'"
                return false

            # set value
            internalProp = getInternalProperty lastPart

            # connect a function to the signal
            isSignal = obj[internalProp] is undefined
            isSignal &&= typeof obj[lastPart] is 'function'
            isSignal &&= obj[lastPart].connect
            if isSignal
                if typeof oldVal is 'function'
                    obj[lastPart].disconnect oldVal
                if typeof val is 'function'
                    obj[lastPart] val

            # omit 'null' values for primitive properties;
            # all props from string interpolation may be equal 'null' by default
            else if val isnt null or typeof obj[internalProp] is 'object'
                @setPropsClassAttribute getPropertyPath(prop), val

            return true

    ###
    Updates item classes comparing changes between given values.
    Classes order is preserved.
    ###
    syncClassProp: (val, oldVal) ->
        {item} = @
        {classes} = item

        if typeof val is 'string' and val isnt ''
            newClasses = val.split ' '
        if typeof oldVal is 'string' and oldVal isnt ''
            oldClasses = oldVal.split ' '

        # remove all
        if oldClasses
            for name in oldClasses
                if classes.has(name)
                    classes.remove name
        if newClasses
            for name in newClasses
                if classes.has(name)
                    classes.remove name

        # add new classes
        if newClasses
            for name, i in newClasses when name isnt ''
                if newClasses.indexOf(name, i + 1) isnt -1
                    continue
                classes.append name

        return

    findAndSetLinkUri: ->
        assert.isDefined @item

        {node} = @

        tmp = node
        while tmp
            if tmp._documentStyle and tmp isnt node
                break
            if tmp.name is 'a' and tmp.props.has('href')
                @setLinkUri tmp.props.href
                break
            tmp = tmp.parent
        return

    setLinkUri: (val) ->
        if @item
            @item.linkUri = val + ''
        return

    findAndSetVisibility: ->
        assert.isDefined @item

        {node} = @

        tmp = node
        while tmp
            if tmp._documentStyle and tmp isnt node
                break
            unless tmp.visible
                @setVisibility false
                break
            tmp = tmp.parent
        return

    ###
    Sets the item visibility.
    ###
    setVisibility: (val) ->
        assert.isBoolean val

        if @item
            @setPropsClassAttribute 'visible', val
        return

    ###
    Creates and initializes renderer item based on the node 'n-style' attribute.
    The style node 'n-style' attribute may be:
        - a 'Renderer.Item' instance - item will be used as is,
        - a string in format:
            - 'renderer:Type' where the 'Type' is a Renderer class;
                a new item will be created,
            - 'styles:File:Style:SubId' where the 'File' is a property
                from 'styles' passed to initialize this file,
                'Style' is a main item id in File,
                the 'SubId' is a main item children id;
                an item from the first parent with style 'styles:File:Style' will be used,
            - 'styles:File:Style' where 'SubId' is unknown and a main item
                from the Style will be used; matched items will be cloned;
            - 'styles:File' where 'Style' is a '_main' by default;
                matched items will be cloned.

    The newly created or found item is initialized.
    ###
    createItem: ->
        assert.isNotDefined @item, "Can't create a style item, because it already exists"
        assert.isNotDefined @node.style, '''
            Can't create a style item, because the node already has a style
        '''

        unless windowStyle
            return

        {node} = @

        # whether found item is global and has no parent in NML
        isMainItem = true

        if node instanceof Tag
            id = node.props[STYLE_ID_PROP]
            assert.isDefined id, "Tag must specify #{STYLE_ID_PROP} prop to create an item for it"
        else if node instanceof Text
            id = Renderer.Text.New()

        # use an item from attribute
        if id instanceof Renderer.Item
            @item = id
            @isAutoParent = not id.parent

        # create an item from styles
        else if /^styles\:/.test(id)
            [_, file, style, subid] = id.split(':')
            style ?= '_main'
            if subid
                isMainItem = false
                parentId = "styles:#{file}:#{style}"
                parent = @parent

                loop
                    if parent and parent.node.props[STYLE_ID_PROP] is parentId
                        scope = parent.scope
                        @item = scope?.objects[subid]
                    else if not parent?.scope and file is '__windowItem__'
                        @usesWindowItem = true
                        @item = windowStyle.objects[subid]

                    if @item or not parent
                        break

                    parent = parent.parent

                unless @item
                    log.warn "Can't find `#{id}` style item"
                    return
            else
                @scope = styles[file]?[style]?()
                if @scope
                    @item = @scope.item
                else
                    log.warn "Style file `#{id}` can't be find"

        # create an item from renderer
        else if /^renderer\:/.test(id)
            [_, type] = id.split(':')
            assert.isDefined Renderer[type], "'#{id}' is not defined in Renderer"
            @item = Renderer[type].New()

        else
            throw new Error "Unexpected n-style; '#{id}' given"

        if @item
            @isAutoParent = not @item.parent

            # set visibility
            @findAndSetVisibility()

            # set text
            if @textProp = @getTextProp()
                @updateText()

            # set linkUri
            @findAndSetLinkUri()

            if node instanceof Tag
                # set props
                if @props
                    for key of @props
                        @setProp key, node.props[key], null

                # set class prop
                if classAttr = node.props['class']
                    @syncClassProp classAttr, ''

            # find parent if necessary or only update index for fixed parents
            if @isAutoParent
                @findItemParent()
            else if isMainItem
                @findItemIndex()

            # set node style
            node.style = @item

            # set style node
            @item.node = node

        return

    ###
    Create an item for this style and for children recursively.
    Item may not be created if it won't be used, that is:
        - parent is a text style.
    ###
    createItemDeeply: eventLoop.bindInLock ->
        @createItem()

        # optimization - don't create styles inside the text style
        unless @textProp
            for child in @children
                child.createItemDeeply()
        return

    findItemParent: ->
        if not @isAutoParent
            return false

        {node} = @
        tmpNode = node.parent
        while tmpNode
            if style = tmpNode._documentStyle
                if item = style.item
                    @item.parent = item
                    break

            tmpNode = tmpNode.parent

        unless item
            @item.parent = null
            return false

        return true

    setItemParent: (val) ->
        if @isAutoParent and @item
            @item.parent = val
            @findItemIndex()
        return

    findItemWithParent = (item, parent) ->
        tmp = item
        while tmp and (tmpParent = tmp._parent)
            if tmpParent is parent
                return tmp
            tmp = tmpParent
        return

    findItemIndex: ->
        {node, item} = @
        unless parent = item.parent
            return false

        tmpIndexNode = node
        parent = parent._children?._target or parent
        tmpSiblingNode = tmpIndexNode

        # by parents
        while tmpIndexNode
            # by previous sibling
            while tmpSiblingNode
                if tmpSiblingNode isnt node
                    # get sibling item
                    tmpSiblingDocStyle = tmpSiblingNode._documentStyle
                    if tmpSiblingDocStyle and tmpSiblingDocStyle.isAutoParent
                        if tmpSiblingItem = tmpSiblingDocStyle.item
                            if tmpSiblingTargetItem = findItemWithParent(tmpSiblingItem, parent)
                                if item isnt tmpSiblingTargetItem
                                    item.previousSibling = tmpSiblingTargetItem
                                return true
                    # check children of special tags
                    else unless tmpSiblingDocStyle
                        tmpIndexNode = tmpSiblingNode
                        tmpSiblingNode = utils.last tmpIndexNode.children
                        continue
                # check previous sibling
                tmpSiblingNode = tmpSiblingNode._previousSibling
            # no sibling found, but parent is styled
            if tmpIndexNode isnt node and tmpIndexNode.style
                return true
            # check parent
            if tmpSiblingNode = tmpIndexNode._previousSibling
                tmpIndexNode = tmpSiblingNode
            else if tmpIndexNode = tmpIndexNode._parent
                # out of scope
                if tmpIndexNode._documentStyle?.item is parent
                    # no styled previous siblings found;
                    # add item as the first node defined element
                    targetChild = null
                    child = parent.children.firstChild
                    while child
                        if child isnt item and child.node
                            targetChild = child
                            break
                        child = child.nextSibling
                    item.nextSibling = targetChild
                    return true
        return false

    render: ->
        # manually remove and add elements of __windowItem__
        # as this is the main Item which is not under Document management
        if @usesWindowItem
            for style in @children
                continue if style.item?.parent
                style.findItemParent()
                style.findItemIndex()
        return

    revert: ->
        if @usesWindowItem
            for style in @children
                style.item?.parent = null
        return

    clone: (originalFile, file) ->
        clone = new Style

        clone.file = file

        node = clone.node = originalFile.node.getCopiedElement @node, file.node
        node._documentStyle = clone

        if node instanceof Tag
            styleAttr = node.props[STYLE_ID_PROP]
            clone.isAutoParent = not /^styles:(.+?)\:(.+?)\:(.+?)$/.test(styleAttr)

        # set props
        if @props
            clone.props = @props

        # clone children
        for child in @children
            child = child.clone originalFile, file
            child.parent = clone
            clone.children.push child

        # create item recursively
        if not @parent
            clone.createItemDeeply()

        clone

    toJSON: do ->
        callToJSON = (elem) ->
            elem.toJSON()

        (key, arr) ->
            unless arr
                arr = new Array JSON_ARGS_LENGTH
                arr[0] = JSON_CTOR_ID
            arr[JSON_NODE] = @node.getAccessPath @file.node
            arr[JSON_PROPS] = @props
            arr[JSON_CHILDREN] = @children.map callToJSON
            arr

    Style
