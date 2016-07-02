'use strict'

assert = require 'src/assert'
utils = require 'src/utils'
signal = require 'src/signal'
log = require 'src/log'
Renderer = require 'src/renderer'

log = log.scope 'Styles'

ATTRS_CLASS_PRIORITY = 9999
PROPS_CLASS_PRIORITY = -2

module.exports = (File, data) -> class Style
    {windowStyle, styles, queries} = data
    {Element} = File
    {Tag, Text} = Element

    @__name__ = 'Style'
    @__path__ = 'File.Style'

    @JSON_CTOR_ID = File.Style?.JSON_CTOR_ID
    @JSON_CTOR_ID ?= File.JSON_CTORS.push(Style) - 1
    {JSON_CTOR_ID} = @

    i = 1
    JSON_NODE = i++
    JSON_ATTRS = i++
    JSON_CHILDREN = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @applyStyleQueriesInDocument = (file) ->
        assert.instanceOf file, File

        for elem in queries
            nodes = file.node.queryAll elem.query
            for node in nodes
                unless node instanceof Tag
                    log.warn 'document.query can be attached only to tags; ' +
                        "query '#{elem.query}' has been omitted for this node"
                    continue
                unless node.attrs.has('neft:style')
                    node.attrs.set 'neft:style', elem.style

        file

    @createStylesInDocument = do ->
        getStyleAttrs = (node) ->
            attrs = null
            for attr of node.attrs when node.attrs.hasOwnProperty(attr)
                if attr.slice(0, 6) is 'style:'
                    attrs ?= {}
                    attrs[attr] = true
            attrs

        forNode = (file, node, parentStyle) ->
            isText = node instanceof Text
            if isText or (attr = node.attrs['neft:style'])
                style = new Style
                style.file = file
                style.node = node
                style.parent = parentStyle
                style.attrs = not isText and getStyleAttrs node

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
        obj.attrs = arr[JSON_ATTRS]

        for child in arr[JSON_CHILDREN]
            cloneChild = Style._fromJSON file, child
            cloneChild.parent = obj
            obj.children.push cloneChild

        obj

    constructor: ->
        @file = null
        @node = null
        @attrs = null
        @parent = null
        @children = []
        @isAutoParent = true
        @item = null
        @scope = null
        @textObject = null
        @attrsClass = null
        @propsClass = null

        Object.seal @

    createClassWithPriority: (priority) ->
        assert.ok @item

        r = Renderer.Class.New()
        r.target = @item
        if priority?
            r.priority = priority
        r

    getTextObject: ->
        {item} = @
        assert.isDefined item
        assert.isNotDefined @textObject

        if @node instanceof Text
            item
        else if ($ = item._$) and 'text' of $
            $
        else if 'text' of item
            item

    updateText: ->
        {textObject, node} = @
        assert.isDefined textObject

        isText = node instanceof Text

        if node instanceof Tag
            text = node.stringifyChildren()
        else
            text = node.text

        textObject.text = text
        return

    setAttr: do ->
        PREFIX_LENGTH = 'style:'.length

        getSplitAttr = do ->
            cache = Object.create null
            (prop) ->
                cache[prop] ||= prop.slice(PREFIX_LENGTH).split ':'

        getPropertyPath = do ->
            cache = Object.create null
            (prop) ->
                cache[prop] ||= prop.slice(PREFIX_LENGTH).replace /:/g, '.'

        getInternalProperty = do ->
            cache = Object.create null
            (prop) ->
                cache[prop] ||= "_#{prop}"

        (attr, val, oldVal) ->
            assert.instanceOf @, Style
            assert.isDefined @attrsClass

            {attrsClass} = @
            props = getSplitAttr attr

            # get object
            obj = @item
            for i in [0...props.length - 1] by 1
                unless obj = obj[props[i]]
                    log.warn "Attribute '#{attr}' doesn't exist in item '#{@item}'"
                    return false

            # break if property doesn't exist
            prop = utils.last props
            unless prop of obj
                log.warn "Attribute '#{attr}' doesn't exist in item '#{@item}'"
                return false

            # set value
            internalProp = getInternalProperty prop

            # connect a function to the signal
            if obj[internalProp] is undefined and typeof obj[prop] is 'function' and obj[prop].connect
                if typeof oldVal is 'function'
                    obj[prop].disconnect oldVal
                if typeof val is 'function'
                    obj[prop] val

            # omit 'null' values for primitive properties;
            # all attributes from string interpolation may be equal 'null' by default
            else if val isnt null or typeof internalProp is 'object'
                isEnabled = attrsClass.running
                if isEnabled
                    attrsClass.disable()
                attrsClass.changes.setAttribute getPropertyPath(attr), val
                if isEnabled
                    attrsClass.enable()

            return true

    ###
    Updates item classes comparing changes between given values.
    Classes order is preserved.
    ###
    syncClassAttr: (val, oldVal) ->
        {item} = @
        {classes} = item

        if typeof val is 'string' and val isnt ''
            newClasses = val.split(' ')

        # check removed values
        if typeof oldVal is 'string' and oldVal isnt ''
            oldClasses = oldVal.split ' '
            for name in oldClasses when name isnt ''
                if not newClasses or not utils.has(newClasses, name)
                    classes.remove name

        # add new classes
        if newClasses
            prevIndex = -1
            for name, i in newClasses when name isnt ''
                index = classes.index name
                if prevIndex is -1 and index is -1
                    index = classes.length
                    classes.append name
                else if index isnt prevIndex + 1
                    if index isnt -1
                        classes.pop index
                        if prevIndex > index
                            prevIndex--
                    index = prevIndex + 1
                    classes.insert index, name
                prevIndex = index

        return

    findAndSetLinkUri: ->
        assert.isDefined @item

        {node} = @

        tmp = node
        while tmp
            if tmp._documentStyle and tmp isnt node
                break
            if tmp.name is 'a' and tmp.attrs.has('href')
                @setLinkUri tmp.attrs.href
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
            @propsClass ?= @createClassWithPriority PROPS_CLASS_PRIORITY
            @propsClass.disable()
            @propsClass.changes._attributes.visible = val
            @propsClass.enable()
        return

    ###
    Creates and initializes renderer item based on the node 'neft:style' attribute.
    The style node 'neft:style' attribute may be:
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
        assert.isNotDefined @node.style, "Can't create a style item, because the node already has a style"

        {node} = @

        if node instanceof Tag
            id = node.attrs['neft:style']
            assert.isDefined id, "Tag must specify 'neft:style' attr to create an item for it"
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
                parentId = "styles:#{file}:#{style}"
                parent = @parent

                loop
                    if parent and parent.node.attrs['neft:style'] is parentId
                        scope = parent.scope
                        @item = scope.objects[subid]
                    else if not parent?.scope and file is 'view'
                        @item = windowStyle.objects[subid]

                    if @item or not parent
                        break

                    parent = parent.parent

                unless @item
                    log.warn "Can't find `#{id}` style item"
                    return
            else
                @scope = styles[file]?[style]?.getComponent()
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
            throw new Error "Unexpected neft:style; '#{id}' given"

        if @item
            @isAutoParent = not @item.parent

            # set visibility
            @findAndSetVisibility()

            # set text
            if @textObject = @getTextObject()
                @updateText()

            # set linkUri
            @findAndSetLinkUri()

            if node instanceof Tag
                # set attrs
                if @attrs
                    @attrsClass = @createClassWithPriority ATTRS_CLASS_PRIORITY
                    for key of @attrs
                        @setAttr key, node.attrs[key], null
                    @attrsClass.enable()

                # set class attr
                if classAttr = node.attrs['class']
                    @syncClassAttr classAttr, ''

            # find parent if necessary or only update index for fixed parents
            if @isAutoParent
                @findItemParent()
            else
                @findItemIndex()

            # set node style
            node.style = @item

            # set style node
            @item.document.node = node

        return

    ###
    Create an item for this style and for children recursively.
    Item may not be created if it won't be used, that is:
        - parent is a text style.
    ###
    createItemDeeply: ->
        @createItem()

        # optimization - don't create styles inside the text style
        unless @textObject
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
                        if child isnt item and child.document.node
                            targetChild = child
                            break
                        child = child.nextSibling
                    item.nextSibling = targetChild
                    return true
        return false

    clone: (originalFile, file) ->
        clone = new Style

        clone.file = file

        node = clone.node = originalFile.node.getCopiedElement @node, file.node
        node._documentStyle = clone

        if node instanceof Tag
            styleAttr = node.attrs['neft:style']
            clone.isAutoParent = not /^styles:(.+?)\:(.+?)\:(.+?)$/.test(styleAttr)

        # set attrs
        if @attrs
            clone.attrs = @attrs

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
            arr[JSON_ATTRS] = @attrs
            arr[JSON_CHILDREN] = @children.map callToJSON
            arr

    Style
