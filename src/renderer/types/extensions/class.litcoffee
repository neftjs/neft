# Class

    'use strict'

    assert = require 'src/assert'
    utils = require 'src/utils'
    signal = require 'src/signal'
    log = require 'src/log'
    List = require 'src/list'
    TagQuery = require 'src/document/element/element/tag/query'

    log = log.scope 'Rendering', 'Class'

    {emitSignal} = signal.Emitter

    module.exports = (Renderer, Impl, itemUtils) ->
        class ChangesObject
            constructor: ->
                @_attributes = {}
                @_functions = []
                @_bindings = {}

            setAttribute: (prop, val) ->
                @_attributes[prop] = val
                return

            setFunction: (prop, val) ->
                boundFunc = (arg1, arg2) ->
                    val.call @_target, arg1, arg2
                @_functions.push prop, boundFunc
                return

            setBinding: (prop, val) ->
                @_attributes[prop] = val
                @_bindings[prop] = true
                return

        class Class extends Renderer.Extension
            @__name__ = 'Class'

## *Renderer.Class* Class.New([*Object* options])

            @New = (opts) ->
                item = new Class
                itemUtils.Object.initialize item, opts
                item

## *Class* Class::constructor() : *Renderer.Extension*

            lastUid = 0
            constructor: ->
                super()
                @_classUid = (lastUid++)+''
                @_priority = 0
                @_inheritsPriority = 0
                @_nestingPriority = 0
                @_name = ''
                @_changes = null
                @_document = null
                @_children = null

## *String* Class::name

This property is used in the *Item*::classes list
to identify various classes.

## *Signal* Class::onNameChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'name'
                developmentSetter: (val) ->
                    assert.isString val
                    assert.notLengthOf val, 0
                setter: (_super) -> (val) ->
                    {target, name} = @

                    if name is val
                        return

                    if target
                        if target.classes.has(name)
                            @disable()
                        target._classExtensions[name] = null
                        target._classExtensions[val] = @

                    _super.call @, val

                    if target
                        if val
                            target._classExtensions ?= {}

                        if target._classes?.has(val)
                            @enable()
                    return

## *Item* Class::target

Reference to the *Item* on which this class has effects.

If state is created inside the *Item*, this property is set automatically.

## *Signal* Class::onTargetChange(*Item* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'target'
                developmentSetter: (val) ->
                    if val?
                        assert.instanceOf val, itemUtils.Object
                setter: (_super) -> (val) ->
                    oldVal = @_target
                    {name} = @

                    if oldVal is val
                        return

                    @disable()

                    if oldVal
                        utils.remove oldVal._extensions, @
                        if @_running and not @_document?._query
                            unloadObjects @, oldVal
                    if name
                        if oldVal
                            oldVal._classExtensions[name] = null
                        if val
                            val._classExtensions ?= {}
                            val._classExtensions[name] = @

                    _super.call @, val

                    if val
                        val._extensions.push @
                        if val._classes?.has(name) or @_when or (@_priority isnt -1 and !@_name and !@_bindings?.when and !@_document?._query)
                            @enable()
                    return

## *Object* Class::changes

This objects contains all properties to change on the target item.

It accepts bindings and listeners as well.

            utils.defineProperty @::, 'changes', null, ->
                @_changes ||= new ChangesObject
            , (obj) ->
                assert.isObject obj

                {changes} = @
                for prop, val of obj
                    if typeof val is 'function'
                        changes.setFunction prop, val
                    else if Array.isArray(val) and val.length is 2 and typeof val[0] is 'function' and Array.isArray(val[1])
                        changes.setBinding prop, val
                    else
                        changes.setAttribute prop, val
                return

## *Integer* Class::priority = `0`

## *Signal* Class::onPriorityChange(*Integer* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'priority'
                defaultValue: 0
                developmentSetter: (val) ->
                    assert.isInteger val
                setter: (_super) -> (val) ->
                    _super.call @, val
                    updatePriorities @
                    return

## *Boolean* Class::when

Indicates whether the class is active or not.

When it's `true`, this state is appended on the
end of the *Item*::classes list.

Mostly used with bindings.

```javascript
Grid {
    columns: 2
    // reduce to one column if the view width is lower than 500 pixels
    Class {
        when: windowItem.width < 500
        changes: {
            columns: 1
        }
    }
}
```

## *Signal* Class::onWhenChange(*Boolean* oldValue)

            enable: ->
                docQuery = @_document?._query
                if @_running or not @_target or docQuery
                    if docQuery
                        for classElem in @_document._classesInUse
                            classElem.enable()
                    return

                super()
                updateTargetClass saveAndEnableClass, @_target, @

                unless @_document?._query
                    loadObjects @, @_target

                return

            disable: ->
                if not @_running or not @_target
                    if @_document and @_document._query
                        for classElem in @_document._classesInUse
                            classElem.disable()
                    return

                super()

                unless @_document?._query
                    unloadObjects @, @_target

                updateTargetClass saveAndDisableClass, @_target, @
                return

## *Object* Class::children

            utils.defineProperty @::, 'children', null, ->
                @_children ||= new ChildrenObject(@)
            , (val) ->
                {children} = @

                # clear
                length = children.length
                while length--
                    children.pop length

                if val
                    assert.isArray val

                    for child in val
                        children.append child

                return

            class ChildrenObject

## *Integer* Class::children.length = `0`

                constructor: (ref) ->
                    @_ref = ref
                    @length = 0

## *Object* Class::children.append(*Object* value)

                append: (val) ->
                    assert.instanceOf val, itemUtils.Object
                    assert.isNot val, @_ref

                    if val instanceof Class
                        updateChildPriorities @_ref, val

                    @[@length++] = val

                    val

## *Object* Class::children.pop(*Integer* index)

                pop: (i=@length-1) ->
                    assert.operator i, '>=', 0
                    assert.operator i, '<', @length

                    oldVal = @[i]
                    delete @[i]
                    --@length

                    oldVal

            clone: ->
                clone = cloneClassWithNoDocument.call @

                if doc = @_document
                    cloneDoc = clone.document
                    cloneDoc.query = doc.query
                    for name, arr of doc._signals
                        cloneDoc._signals[name] = utils.clone arr

                clone

        loadObjects = (classElem, item) ->
            if children = classElem._children
                for child in children
                    if child instanceof Renderer.Item
                        child.parent ?= item
                    else
                        if child instanceof Class
                            updateChildPriorities classElem, child
                        child.target ?= item
            return

        unloadObjects = (classElem, item) ->
            if children = classElem._children
                for child in children
                    if child instanceof Renderer.Item
                        if child.parent is item
                            child.parent = null
                    else
                        if child.target is item
                            child.target = null
            return

        updateChildPriorities = (parent, child) ->
            child._inheritsPriority = parent._inheritsPriority + parent._priority
            child._nestingPriority = parent._nestingPriority + 1 + (child._document?._priority or 0)
            updatePriorities child
            return

        updatePriorities = (classElem) ->
            # refresh if needed
            if classElem._running and ifClassListWillChange(classElem)
                target = classElem._target
                updateTargetClass disableClass, target, classElem
                updateClassList target
                updateTargetClass enableClass, target, classElem

            # children
            if children = classElem._children
                for child in children
                    if child instanceof Class
                        updateChildPriorities classElem, child

            # document
            if document = classElem._document
                {_inheritsPriority, _nestingPriority} = classElem
                for child in document._classesInUse
                    child._inheritsPriority = _inheritsPriority
                    child._nestingPriority = _nestingPriority
                    updatePriorities child
                for child in document._classesPool
                    child._inheritsPriority = _inheritsPriority
                    child._nestingPriority = _nestingPriority
            return

        ifClassListWillChange = (classElem) ->
            target = classElem._target
            classList = target._classList
            index = classList.indexOf classElem

            if index > 0 and classListSortFunc(classElem, classList[index - 1]) < 0
                return true
            if index < classList.length - 1 and classListSortFunc(classElem, classList[index + 1]) > 0
                return true
            false

        classListSortFunc = (a, b) ->
            (b._priority + b._inheritsPriority) - (a._priority + a._inheritsPriority) or
            (b._nestingPriority) - (a._nestingPriority)

        updateClassList = (item) ->
            item._classList.sort classListSortFunc

        cloneClassChild = (classElem, child) ->
            child.clone()

        cloneClassWithNoDocument = ->
            clone = Class.New()
            clone.id = @id
            clone._classUid = @_classUid
            clone._name = @_name
            clone._priority = @_priority
            clone._inheritsPriority = @_inheritsPriority
            clone._nestingPriority = @_nestingPriority
            clone._changes = @_changes

            if @_bindings
                for prop, val of @_bindings
                    clone.createBinding prop, val

            # clone children
            if children = @_children
                for child, i in children
                    childClone = cloneClassChild clone, child
                    clone.children.append childClone

            clone

        {splitAttribute, getObjectByPath} = itemUtils

        setAttribute = (item, attr, val) ->
            path = splitAttribute attr
            if object = getObjectByPath(item, path)
                object[path[path.length - 1]] = val
            return

        saveAndEnableClass = (item, classElem) ->
            item._classList.unshift classElem
            if ifClassListWillChange(classElem)
                updateClassList item
            enableClass item, classElem

        saveAndDisableClass = (item, classElem) ->
            disableClass item, classElem
            utils.remove item._classList, classElem

        ATTRS_ALIAS_DEF = [
            ['x', 'anchors.left', 'anchors.right', 'anchors.horizontalCenter', 'anchors.centerIn', 'anchors.fill', 'anchors.fillWidth'],
            ['y', 'anchors.top', 'anchors.bottom', 'anchors.verticalCenter', 'anchors.centerIn', 'anchors.fill', 'anchors.fillHeight'],
            ['width', 'anchors.fill', 'anchors.fillWidth', 'layout.fillWidth'],
            ['height', 'anchors.fill', 'anchors.fillHeight', 'layout.fillHeight'],
            ['margin.horizontal', 'margin.left'],
            ['margin.horizontal', 'margin.right'],
            ['margin.vertical', 'margin.top'],
            ['margin.vertical', 'margin.bottom'],
            ['padding.horizontal', 'padding.left'],
            ['padding.horizontal', 'padding.right'],
            ['padding.vertical', 'padding.top']
            ['padding.vertical', 'padding.bottom']
        ]

        ATTRS_ALIAS = Object.create null
        ATTRS_ALIAS['margin'] = ['margin.left', 'margin.right', 'margin.horizontal', 'margin.top', 'margin.bottom', 'margin.vertical']
        ATTRS_ALIAS['padding'] = ['padding.left', 'padding.right', 'padding.horizontal', 'padding.top', 'padding.bottom', 'padding.vertical']
        ATTRS_ALIAS['alignment'] = ['alignment.horizontal', 'alignment.vertical']

        do ->
            for aliases in ATTRS_ALIAS_DEF
                for prop in aliases
                    arr = ATTRS_ALIAS[prop] ?= []
                    for alias in aliases
                        if alias isnt prop
                            arr.push alias
            return

        getContainedAttributeOrAlias = (classElem, attr) ->
            if changes = classElem._changes
                attrs = changes._attributes
                if attrs[attr] isnt undefined
                    return attr
                else if aliases = ATTRS_ALIAS[attr]
                    for alias in aliases
                        if attrs[alias] isnt undefined
                            return alias
            return ''

        getPropertyDefaultValue = (obj, prop) ->
            proto = Object.getPrototypeOf obj
            innerProp = itemUtils.getInnerPropName(prop)
            if innerProp of proto
                proto[innerProp]
            else
                proto[prop]

        enableClass = (item, classElem) ->
            assert.instanceOf item, itemUtils.Object
            assert.instanceOf classElem, Class

            classList = item._classList
            classListIndex = classList.indexOf classElem
            classListLength = classList.length
            if classListIndex is -1
                return

            unless changes = classElem._changes
                return

            attributes = changes._attributes
            bindings = changes._bindings
            functions = changes._functions

            # functions
            for attr, i in functions by 2
                path = splitAttribute attr
                object = getObjectByPath item, path
                `//<development>`
                if not object or typeof object?[path[path.length - 1]] isnt 'function'
                    log.error "Handler '#{attr}' doesn't exist in '#{item.toString()}', from '#{classElem.toString()}'"
                `//</development>`
                object?[path[path.length - 1]]? functions[i+1], classElem

            # attributes
            for attr, val of attributes
                path = null
                writeAttr = true
                alias = ''
                for i in [classListIndex-1..0] by -1
                    if getContainedAttributeOrAlias(classList[i], attr)
                        writeAttr = false
                        break

                if writeAttr
                    # unset alias
                    for i in [classListIndex+1...classListLength] by 1
                        if (alias = getContainedAttributeOrAlias(classList[i], attr)) and alias isnt attr
                            path = splitAttribute alias
                            object = getObjectByPath item, path
                            lastPath = path[path.length - 1]
                            unless object
                                continue
                            defaultValue = getPropertyDefaultValue object, lastPath
                            defaultIsBinding = !!classList[i].changes._bindings[alias]
                            if defaultIsBinding
                                object.createBinding lastPath, null, item
                            object[lastPath] = defaultValue
                            break

                    # set new attribute
                    if attr isnt alias or not path
                        path = splitAttribute attr
                        lastPath = path[path.length - 1]
                        object = getObjectByPath item, path

                    # create property on demand
                    if object instanceof itemUtils.CustomObject and not (lastPath of object)
                        itemUtils.Object.createProperty object._ref, lastPath
                    else
                        `//<development>`
                        if not object or not (lastPath of object)
                            log.error "Attribute '#{attr}' doesn't exist in '#{item.toString()}', from '#{classElem.toString()}'"
                            continue
                        `//</development>`
                        unless object
                            continue

                    if bindings[attr]
                        object.createBinding lastPath, val, item
                    else
                        if object._bindings?[lastPath]
                            object.createBinding lastPath, null, item
                        object[lastPath] = val

            return

        disableClass = (item, classElem) ->
            assert.instanceOf item, itemUtils.Object
            assert.instanceOf classElem, Class

            classList = item._classList
            classListIndex = classList.indexOf classElem
            classListLength = classList.length
            if classListIndex is -1
                return

            unless changes = classElem._changes
                return

            attributes = changes._attributes
            bindings = changes._bindings
            functions = changes._functions

            # functions
            for attr, i in functions by 2
                path = splitAttribute attr
                object = getObjectByPath item, path
                object?[path[path.length - 1]]?.disconnect functions[i+1], classElem

            # attributes
            for attr, val of attributes
                path = null
                restoreDefault = true
                alias = ''
                for i in [classListIndex-1..0] by -1
                    # BUG: undefined on QML (potential Array::sort bug)
                    unless classList[i]
                        continue

                    if getContainedAttributeOrAlias(classList[i], attr)
                        restoreDefault = false
                        break

                if restoreDefault
                    # get default value
                    defaultValue = undefined
                    defaultIsBinding = false
                    for i in [classListIndex+1...classListLength] by 1
                        if alias = getContainedAttributeOrAlias(classList[i], attr)
                            defaultValue = classList[i].changes._attributes[alias]
                            defaultIsBinding = !!classList[i].changes._bindings[alias]
                            break
                    alias ||= attr

                    # restore attribute
                    if !!bindings[attr]
                        path = splitAttribute attr
                        object = getObjectByPath item, path
                        lastPath = path[path.length - 1]
                        unless object
                            continue
                        object.createBinding lastPath, null, item

                    # set default value
                    if attr isnt alias or not path
                        path = splitAttribute alias
                        object = getObjectByPath item, path
                        lastPath = path[path.length - 1]
                        unless object
                            continue
                    `//<development>`
                    unless lastPath of object
                        continue
                    `//</development>`
                    if defaultIsBinding
                        object.createBinding lastPath, defaultValue, item
                    else
                        if defaultValue is undefined
                            defaultValue = getPropertyDefaultValue object, lastPath
                        object[lastPath] = defaultValue

            return

        runQueue = (target) ->
            classQueue = target._classQueue
            [func, target, classElem] = classQueue
            func target, classElem
            classQueue.shift()
            classQueue.shift()
            classQueue.shift()
            if classQueue.length > 0
                runQueue target
            return

        updateTargetClass = (func, target, classElem) ->
            classQueue = target._classQueue
            classQueue.push func, target, classElem
            if classQueue.length is 3
                runQueue target
            return

## *Object* Class::document

        class ClassChildDocument
            constructor: (parent) ->
                @_ref = parent._ref
                @_parent = parent
                @_multiplicity = 0
                Object.preventExtensions @

        class ClassDocument extends itemUtils.DeepObject
            @__name__ = 'ClassDocument'

## *Signal* Class::onDocumentChange(*Object* document)

            itemUtils.defineProperty
                constructor: Class
                name: 'document'
                valueConstructor: @

            onTargetChange = (oldVal) ->
                if oldVal
                    oldVal.onNodeChange.disconnect @reloadQuery, @
                if val = @_ref._target
                    val.onNodeChange @reloadQuery, @
                if oldVal isnt val
                    @reloadQuery()
                return

            constructor: (ref) ->
                @_query = ''
                @_classesInUse = []
                @_classesPool = []
                @_nodeWatcher = null
                @_priority = 0
                super ref

                ref.onTargetChange onTargetChange, @
                onTargetChange.call @, ref._target

## *Signal* Class::document.onNodeAdd(*Element* node)

            signal.Emitter.createSignal @, 'onNodeAdd'

## *Signal* Class::document.onNodeRemove(*Element* node)

            signal.Emitter.createSignal @, 'onNodeRemove'

## *String* Class::document.query

## *Signal* Class::document.onQueryChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'query'
                defaultValue: ''
                namespace: 'document'
                parentConstructor: ClassDocument
                developmentSetter: (val) ->
                    assert.isString val
                setter: (_super) -> (val) ->
                    assert.notOk @_parent

                    if @_query is val
                        return

                    unless @_query
                        unloadObjects @, @_target

                    _super.call @, val
                    @reloadQuery()

                    # update priority
                    if @_ref._priority < 1
                        # TODO
                        # while calculating selector priority we take only the first query
                        # as a priority for the whole selector;
                        # to fix this we can split selector with multiple queries ('a, b')
                        # into separated class instances
                        cmdLen = TagQuery.getSelectorPriority val, 0, 1
                        oldPriority = @_priority
                        @_priority = cmdLen
                        @_ref._nestingPriority += cmdLen - oldPriority
                        updatePriorities @_ref

                    unless val
                        loadObjects @, @_target
                    return

            getChildClass = (style, parentClass) ->
                for classElem in style._extensions
                    if classElem instanceof Class
                        if classElem._document?._parent is parentClass
                            return classElem
                return

            connectNodeStyle = (style) ->
                # omit duplications
                uid = @_ref._classUid
                for classElem in style._extensions
                    if classElem instanceof Class
                        if classElem isnt @_ref and classElem._classUid is uid and classElem._document instanceof ClassChildDocument
                            classElem._document._multiplicity++
                            return

                # get class
                unless classElem = @_classesPool.pop()
                    classElem = cloneClassWithNoDocument.call @_ref
                    classElem._document = new ClassChildDocument @

                # save
                @_classesInUse.push classElem
                classElem.target = style

                # run if needed
                if not classElem._bindings?.when
                    classElem.enable()
                return

            disconnectNodeStyle = (style) ->
                unless classElem = getChildClass(style, @)
                    return
                if classElem._document._multiplicity > 0
                    classElem._document._multiplicity--
                    return
                classElem.target = null
                utils.remove @_classesInUse, classElem
                @_classesPool.push classElem
                return

            onNodeStyleChange = (oldVal, val) ->
                if oldVal
                    disconnectNodeStyle.call @, oldVal
                if val
                    connectNodeStyle.call @, val
                return

            onNodeAdd = (node) ->
                node.onStyleChange onNodeStyleChange, @
                if style = node._style
                    connectNodeStyle.call @, style
                emitSignal @, 'onNodeAdd', node
                return

            onNodeRemove = (node) ->
                node.onStyleChange.disconnect onNodeStyleChange, @
                if style = node._style
                    disconnectNodeStyle.call @, style
                emitSignal @, 'onNodeRemove', node
                return

            reloadQuery: ->
                # remove old
                @_nodeWatcher?.disconnect()
                @_nodeWatcher = null
                while classElem = @_classesInUse.pop()
                    classElem.target = null
                    @_classesPool.push classElem

                # add new ones
                if (query = @_query) and (target = @_ref.target) and (node = target.node) and node.watch
                    watcher = @_nodeWatcher = node.watch query
                    watcher.onAdd onNodeAdd, @
                    watcher.onRemove onNodeRemove, @
                return

## *List* Item::classes

Classes at the end of the list have the highest priority.

This property has a setter, which accepts a string and an array of strings.

## *Signal* Item::onClassesChange(*String* added, *String* removed)

        normalizeClassesValue = (val) ->
            if typeof val is 'string'
                if val.indexOf(',') isnt -1
                    val = val.split ','
                else
                    val = val.split ' '
            else if val instanceof List
                val = val.items()
            val

        class ClassesList extends List
            constructor: ->
                super()

            utils.defineProperty @::, 'append', null, do (_super = @::append) ->
                -> _super
            , (val) ->
                val = normalizeClassesValue val
                if Array.isArray(val)
                    for name in val
                        if name = name.trim()
                            @append name
                return

            utils.defineProperty @::, 'remove', null, do (_super = @::remove) ->
                -> _super
            , (val) ->
                val = normalizeClassesValue val
                if Array.isArray(val)
                    for name in val
                        if name = name.trim()
                            @remove name
                return

        Renderer.onReady ->
            itemUtils.defineProperty
                constructor: Renderer.Item
                name: 'classes'
                defaultValue: null
                getter: do ->
                    onChange = (oldVal, index) ->
                        val = @_classes.get(index)
                        onPop.call @, oldVal, index
                        onInsert.call @, val, index
                        @onClassesChange.emit val, oldVal
                        return

                    onInsert = (val, index) ->
                        @_classExtensions[val]?.enable()
                        @onClassesChange.emit val
                        return

                    onPop = (oldVal, index) ->
                        unless @_classes.has(oldVal)
                            @_classExtensions[oldVal]?.disable()
                        @onClassesChange.emit null, oldVal
                        return

                    (_super) -> ->
                        unless @_classes
                            @_classExtensions ?= {}
                            list = @_classes = new ClassesList
                            list.onChange onChange, @
                            list.onInsert onInsert, @
                            list.onPop onPop, @

                        _super.call @
                setter: (_super) -> (val) ->
                    val = normalizeClassesValue val
                    {classes} = @

                    classes.clear()
                    if Array.isArray(val)
                        for name in val
                            if name = name.trim()
                                classes.append name
                    return

        Class
