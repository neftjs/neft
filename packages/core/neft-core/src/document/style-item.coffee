'use strict'

assert = require '../assert'
utils = require '../util'
{Signal} = require '../signal/signal'
log = require '../log'
eventLoop = require '../event-loop'
Renderer = require '../renderer'
InputProp = require './input/prop'
{Tag, Text} = require './element'

log = log.scope 'Styles'

PROPS_CLASS_PRIORITY = 9999
PROP_PREFIX = 'style:'
STYLE_ID_PROP = 'n-style'
DEFAULT_PROP_ALIASES =
    onClick: 'pointer:onClick'
    onPress: 'pointer:onPress'
    onRelease: 'pointer:onRelease'
    onMove: 'pointer:onMove'

module.exports = class StyleItem
    {isHandler} = InputProp

    constructor: (@document, { element, children }, @parent = null) ->
        @element = @document.element.getChildByAccessPath(element)
        @children = children?.map (child) => new StyleItem @document, child, @
        @item = null
        @propsClass = null
        @scope = null

        if @element instanceof Tag
            styleAttr = @element.props[STYLE_ID_PROP]
            @isAutoParent = not /^(.+?)\:(.+?)$/.test(styleAttr)
        else
            @isAutoParent = true

        @element._documentStyle = @

        unless @parent
            @createItemDeeply()

        Object.seal @

    createClassWithPriority: (priority) ->
        assert.ok @item

        r = Renderer.Class.New()
        r.target = @item
        if priority?
            r.priority = priority
        r

    updateText: ->
        @item.text = @element.text
        return

    setPropsClassAttribute: (attr, val) ->
        assert.instanceOf @, StyleItem

        unless @propsClass
            @propsClass = @createClassWithPriority PROPS_CLASS_PRIORITY

        {propsClass} = @

        if propsClass.changes._attributes[attr] is val
            return

        propsClass.running = false
        propsClass.changes.setAttribute attr, val
        propsClass.running = true

        return

    setProp: do ->
        isStyleProp = (prop) -> prop.startsWith PROP_PREFIX

        getPropWithoutPrefix = (prop) ->
            prop.slice PROP_PREFIX.length

        getSplitProp = do ->
            cache = Object.create null
            (prop) ->
                cache[prop] ||= prop.split ':'

        getPropertyPath = do ->
            cache = Object.create null
            (prop) ->
                cache[prop] ||= prop.replace /:/g, '.'

        getInternalProperty = do ->
            cache = Object.create null
            (prop) ->
                cache[prop] ||= "_#{prop}"

        (prop, val, oldVal) ->
            assert.instanceOf @, StyleItem

            if prop.startsWith('n-')
                return false

            if isStyleProp(prop)
                prop = getPropWithoutPrefix(prop)
            else if @element.constructor._styleAliasesByName
                parts = getSplitProp prop
                alias = @element.constructor._styleAliasesByName[parts[0]]
                if alias
                    prop = alias.styleName
                else
                    return false
            else
                prop = DEFAULT_PROP_ALIASES[prop]
                unless prop
                    return false

            parts = getSplitProp prop

            # get object
            obj = @item
            return unless obj
            for i in [0...parts.length - 1] by 1
                unless obj = obj[parts[i]]
                    return false

            # break if property doesn't exist
            lastPart = utils.last parts
            unless lastPart of obj
                return false

            # set value
            internalProp = getInternalProperty lastPart

            # connect function to signal
            if obj[lastPart] instanceof Signal
                if typeof oldVal is 'function'
                    obj[lastPart].disconnect oldVal, @element
                if typeof val is 'function'
                    obj[lastPart].connect val, @element
            else
                @setPropsClassAttribute getPropertyPath(prop), val

            return true

    findAndSetVisibility: ->
        assert.isDefined @item

        {element} = @

        tmp = element
        while tmp
            if tmp._documentStyle and tmp isnt element
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
    Creates and initializes renderer item based on the element 'n-style' attribute.
    The style element 'n-style' attribute may be:
        - a 'Renderer.Item' instance - item will be used as is,
        - a string in format:
            - File, Style, SubId,
            - File, Style.

    The newly created or found item is initialized.
    ###
    createItem: ->
        assert.isNotDefined @item, "Can't create a style item, because it already exists"
        assert.isNotDefined @element.style, '''
            Can't create a style item, because the element already has a style
        '''

        {element} = @

        # whether found item is global and has no parent in NML
        isMainItem = true

        if element instanceof Tag
            id = element.props[STYLE_ID_PROP]
            assert.isDefined id, "Tag must specify #{STYLE_ID_PROP} prop to create an item for it"
        else if element instanceof Text
            id = Renderer.Text.New()

        # use an item from attribute
        if id instanceof Renderer.Item
            @item = id
            @isAutoParent = not id.parent

        # create an item from styles
        else if Array.isArray(id)
            [file, style, subid] = id
            if subid
                isMainItem = false
                parent = @parent

                loop
                    parentStyle = parent?.element.props[STYLE_ID_PROP]
                    if parentStyle and parentStyle[0] is file and parentStyle[1] is style
                        scope = parent.scope
                        @item = scope?.objects[subid]

                    if @item or not parent
                        break

                    parent = parent.parent

                unless @item
                    log.warn "Can't find `#{id}` style item"
                    return
            else
                @scope = @document.style[file]?[style]?()
                @scope or= @document.parent?.style[file]?[style]?()
                if @scope
                    @item = @scope.item
                else
                    log.warn "Style file `#{id}` can't be find"

        else
            throw new Error "Unexpected n-style; '#{id}' given"

        if @item
            @isAutoParent = not @item.parent

            # set visibility
            @findAndSetVisibility()

            # set text
            if element instanceof Text
                @updateText()

            if element instanceof Tag
                # set props
                for key of element.props
                    if isHandler(@element, key)
                        @setProp key, element.props[key], null

            # find parent if necessary or only update index for fixed parents
            if @isAutoParent
                @findItemParent()
            else if isMainItem
                @findItemIndex()

            # set element style
            element.style = @item

            # set style element
            @item.element = element

        return

    ###
    Create an item for this style and for children recursively.
    Item may not be created if it won't be used, that is:
        - parent is a text style.
    ###
    createItemDeeply: eventLoop.bindInLock ->
        @createItem()

        # optimization - don't create styles inside the text style
        if @children
            for child in @children
                child.createItemDeeply()
        return

    findItemParent: ->
        if not @isAutoParent
            return false

        {element} = @
        tmpNode = element.parent
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
        {element, item} = @
        unless parent = item.parent
            return false

        tmpIndexNode = element
        parent = parent._children?._target or parent
        tmpSiblingNode = tmpIndexNode

        # by parents
        while tmpIndexNode
            # by previous sibling
            while tmpSiblingNode
                if tmpSiblingNode isnt element
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
            if tmpIndexNode isnt element and tmpIndexNode.style
                return true
            # check parent
            if tmpSiblingNode = tmpIndexNode._previousSibling
                tmpIndexNode = tmpSiblingNode
            else if tmpIndexNode = tmpIndexNode._parent
                # out of scope
                if tmpIndexNode._documentStyle?.item is parent
                    # no styled previous siblings found;
                    # add item as the first element defined element
                    targetChild = null
                    child = parent.children.firstChild
                    while child
                        if child isnt item and child.element
                            targetChild = child
                            break
                        child = child.nextSibling
                    item.nextSibling = targetChild
                    return true
        return false

    render: ->
        # set properties
        if @element instanceof Tag
            # set props
            for key of @element.props
                unless isHandler(@element, key)
                    @setProp key, @element.props[key], null

        # render children
        if @children
            for style in @children
                style.render()
        return

    revert: ->

