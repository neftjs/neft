# Element.Tag

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    signal = require 'src/signal'
    stringify = require './tag/stringify'
    TypedArray = require 'src/typed-array'

    {emitSignal} = signal.Emitter

    assert = assert.scope 'View.Element.Tag'

    isDefined = (elem) -> elem?

    CSS_ID_RE = ///\#([^\s]+)///

# **Class** Tag : *Element*

    module.exports = (Element) -> class Tag extends Element
        @INTERNAL_TAGS = [
            'neft:attr', 'neft:fragment', 'neft:rule', 'neft:target',
            'neft:use', 'neft:require', 'neft:blank', 'neft:log', 'neft:script'
        ]

        @DEFAULT_STRINGIFY_REPLACEMENTS = Object.create null

        @extensions = Object.create null

        @__name__ = 'Tag'
        @__path__ = 'File.Element.Tag'

        JSON_CTOR_ID = @JSON_CTOR_ID = Element.JSON_CTORS.push(Tag) - 1

        i = Element.JSON_ARGS_LENGTH
        JSON_NAME = i++
        JSON_CHILDREN = i++
        JSON_ATTRS = i++
        JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

        @_fromJSON = (arr, obj=new Tag) ->
            Element._fromJSON arr, obj
            obj.name = arr[JSON_NAME]
            utils.merge obj.attrs, arr[JSON_ATTRS]

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
            Element.call this

            @name = 'neft:blank'
            @children = []
            @attrs = new Attrs @

            `//<development>`
            if @constructor is Tag
                Object.seal @
            `//</development>`

## *String* Tag::name

## *Array* Tag::children

## *Signal* Tag::onChildrenChange(*Element* added, *Element* removed)

        signal.Emitter.createSignal @, 'onChildrenChange'

## *Element.Tag.Attrs* Tag::attrs

## *Signal* Tag::onAttrsChange(*String* attribute, *Any* oldValue)

        signal.Emitter.createSignal @, 'onAttrsChange'

        clone: (clone = new Tag) ->
            super clone
            clone.name = @name
            utils.merge clone.attrs, @attrs
            clone

## *Element.Tag* Tag::cloneDeep()

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

## *Element* Tag::getCopiedElement(*Element* lookForElement, *Element* copiedParent)

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

## *Element.Tag* Tag::getChildByAccessPath(*Array* accessPath)

        getChildByAccessPath: (arr) ->
            assert.isArray arr

            elem = @
            for i in arr by -1
                unless elem = elem.children[i]
                    return null

            elem

## *Array* Tag::queryAll(*String* query, [*Function* onElement, *Any* onElementContext])

        @query = query = require('./tag/query') Element, @

        queryAll: query.queryAll

## *Element* Tag::query(*String* query)

        query: query.query

## *Watcher* Tag::watch(*String* query)

```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```

        watch: query.watch

## *String* Tag::stringify([*Object* replacements])

        stringify: (replacements=Tag.DEFAULT_STRINGIFY_REPLACEMENTS) ->
            stringify.getOuterHTML @, replacements

## *String* Tag::stringifyChildren([*Object* replacements])

        stringifyChildren: (replacements=Tag.DEFAULT_STRINGIFY_REPLACEMENTS) ->
            stringify.getInnerHTML @, replacements

## Tag::replace(*Element* oldElement, *Element* newElement)

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
            arr[JSON_ATTRS] = @attrs

            for child in @children
                children.push child.toJSON()

            arr

# **Class** Attrs

        @Attrs = class Attrs
            constructor: (ref) ->
                utils.defineProperty @, '_ref', 0, ref

            NOT_ENUMERABLE = utils.CONFIGURABLE | utils.WRITABLE
            utils.defineProperty @::, 'constructor', NOT_ENUMERABLE, Attrs

## *Array* Attrs::item(*Integer* index, [*Array* target])

            utils.defineProperty @::, 'item', NOT_ENUMERABLE, (index, target=[]) ->
                assert.isArray target

                target[0] = target[1] = undefined

                i = 0
                for key, val of @
                    if @hasOwnProperty(key) and i is index
                        target[0] = key
                        target[1] = val
                        break
                    i++

                target

## *Boolean* Attrs::has(*String* name)

            utils.defineProperty @::, 'has', NOT_ENUMERABLE, (name) ->
                assert.isString name
                assert.notLengthOf name, 0

                @hasOwnProperty name

## *Boolean* Attrs::set(*String* name, *Any* value)

            utils.defineProperty @::, 'set', NOT_ENUMERABLE, (name, value) ->
                assert.isString name
                assert.notLengthOf name, 0

                # save change
                old = @[name]
                if old is value
                    return false

                @[name] = value

                # trigger event
                emitSignal @_ref, 'onAttrsChange', name, old
                query.checkWatchersDeeply @_ref

                true

# Glossary

- [Element.Tag](#class-tag)
- [Element.Tag.Attrs](#class-attrs)
