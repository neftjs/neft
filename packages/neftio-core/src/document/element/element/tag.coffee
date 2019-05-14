'use strict'

utils = require '../../../util'
assert = require '../../../assert'
{SignalsEmitter} = require '../../../signal'
TypedArray = require '../../../typed-array'
stringify = require './tag/stringify'

assert = assert.scope 'View.Element.Tag'

module.exports = (Element) -> class Tag extends Element
    @Props = Props = require('./tag/props') @

    @__name__ = 'Tag'
    @__path__ = 'File.Element.Tag'

    JSON_CTOR_ID = @JSON_CTOR_ID = Element.JSON_CTORS.push(Tag) - 1

    i = Element.JSON_ARGS_LENGTH
    JSON_NAME = @JSON_NAME = i++
    JSON_CHILDREN = i++
    JSON_PROPS = i++
    JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

    @CustomTag = require('./tag/custom') Element, @

    @_fromJSON = (arr, obj) ->
        name = arr[JSON_NAME]
        unless obj
            obj = new Tag
        Element._fromJSON arr, obj
        obj.name = name
        utils.merge obj.props, arr[JSON_PROPS]

        prevChild = null
        for child in arr[JSON_CHILDREN]
            childObj = Element.fromJSON child
            obj.children.push childObj
            childObj._parent = obj
            if childObj._previousSibling = prevChild
                prevChild._nextSibling = childObj
            prevChild = childObj

        obj

    constructor: ->
        super()

        @name = 'blank'
        @children = []
        @props = new Props @

        `//<development>`
        if @constructor is Tag
            Object.seal @
        `//</development>`

    SignalsEmitter.createSignal @, 'onChildrenChange'

    SignalsEmitter.createSignal @, 'onPropsChange'

    clone: (clone = new @constructor) ->
        super clone
        clone.name = @name
        utils.merge clone.props, @props
        clone

    cloneDeep: ->
        clone = @clone()

        prevClonedChild = null
        for child in @children
            if child instanceof Tag
                clonedChild = child.cloneDeep()
            else
                clonedChild = child.clone()
            clone.children.push clonedChild
            clonedChild._parent = clone
            if clonedChild._previousSibling = prevClonedChild
                prevClonedChild._nextSibling = clonedChild
            prevClonedChild = clonedChild

        clone

    getCopiedElement: do ->
        arr = new TypedArray.Uint16 256
        (lookForElement, copiedParent) ->
            assert.instanceOf @, Tag
            assert.instanceOf lookForElement, Element
            assert.instanceOf copiedParent, Element

            if lookForElement is @
                return copiedParent

            i = 0

            # get indexes to parent
            elem = lookForElement
            while parent = elem._parent
                arr[i++] = parent.children.indexOf elem
                elem = parent
                if elem is @
                    break

            # walk by indexes in copied parent
            elem = copiedParent
            while i-- > 0
                index = arr[i]
                elem = elem.children[index]

            elem

    getChildByAccessPath: (arr) ->
        assert.isArray arr

        elem = @
        for i in arr by -1
            unless elem = elem.children[i]
                return null

        elem

    @query = query = require('./tag/query') Element, @

    queryAll: query.queryAll

    query: query.query

    watch: query.watch

    stringify: ->
        stringify.getOuterHTML @

    stringifyChildren: ->
        stringify.getInnerHTML @

    replace: (oldElement, newElement) ->
        assert.instanceOf oldElement, Element
        assert.instanceOf newElement, Element
        assert.is oldElement.parent, @

        index = @children.indexOf oldElement

        oldElement.parent = undefined

        newElement.parent = @
        newElement.index = index

        null

    toJSON: (arr) ->
        unless arr
            arr = new Array JSON_ARGS_LENGTH
            arr[0] = JSON_CTOR_ID
        super arr
        arr[JSON_NAME] = @name
        children = arr[JSON_CHILDREN] = []
        arr[JSON_PROPS] = @props

        for child in @children
            children.push child.toJSON()

        arr
