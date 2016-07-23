# Document

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    log = require 'src/log'
    signal = require 'src/signal'
    Dict = require 'src/dict'
    List = require 'src/list'

    assert = assert.scope 'View'
    log = log.scope 'View'

    {Emitter} = signal
    {emitSignal} = Emitter

# **Class** Document

    module.exports = class Document extends Emitter
        files = @_files = {}
        pool = Object.create null

        getFromPool = (path) ->
            pool[path]?.pop()

        @__name__ = 'Document'
        @__path__ = 'Document'

        @JSON_CTORS = []
        JSON_CTOR_ID = @JSON_CTOR_ID = @JSON_CTORS.push(Document) - 1

        i = 1
        JSON_PATH = i++
        JSON_NODE = i++
        JSON_TARGET_NODE = i++
        JSON_ATTRS_TO_PARSE = i++
        JSON_FRAGMENTS = i++
        JSON_SCRIPTS = i++
        JSON_ATTR_CHANGES = i++
        JSON_INPUTS = i++
        JSON_CONDITIONS = i++
        JSON_ITERATORS = i++
        JSON_USES = i++
        JSON_IDS = i++
        JSON_ATTRS_TO_SET = i++
        JSON_LOGS = i++
        JSON_STYLES = i++
        JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

        @FILES_PATH = ''

        signal.create @, 'onCreate'
        signal.create @, 'onError'
        signal.create @, 'onBeforeParse'
        signal.create @, 'onParse'
        signal.create @, 'onStyle'

## *Signal* Document.onBeforeRender(*Document* file)

Corresponding node handler: *n-onBeforeRender=""*.

        signal.create @, 'onBeforeRender'

## *Signal* Document.onRender(*Document* file)

Corresponding node handler: *n-onRender=""*.

        signal.create @, 'onRender'

## *Signal* Document.onBeforeRevert(*Document* file)

Corresponding node handler: *n-onBeforeRevert=""*.

        signal.create @, 'onBeforeRevert'

## *Signal* Document.onRevert(*Document* file)

Corresponding node handler: *n-onRevert=""*.

        signal.create @, 'onRevert'

        @Element = require('./element/index')
        @AttrChange = require('./attrChange') @
        @Use = require('./use') @
        @Scripts = require('./scripts') @
        @Input = require('./input') @
        @Condition = require('./condition') @
        @Iterator = require('./iterator') @
        @Log = require('./log') @
        @AttrsToSet = require('./attrsToSet') @

## *Document* Document.fromHTML(*String* path, *String* html)

        @fromHTML = do ->
            unless utils.isNode
                return (path, html) ->
                    throw new Error "Document.fromHTML is available only on the server"

            clear = require('./file/clear') Document

            (path, html) ->
                assert.isString path
                assert.notLengthOf path, 0
                assert.notOk files[path]?
                assert.isString html

                if html is ''
                    html = '<html></html>'

                # get node
                node = Document.Element.fromHTML html

                # clear
                clear node

                # create file
                Document.fromElement path, node

## *Document* Document.fromElement(*String* path, *Element* element)

        @fromElement = (path, node) ->
            assert.isString path
            assert.notLengthOf path, 0
            assert.instanceOf node, Document.Element
            assert.notOk files[path]?

            # create
            file = new Document path, node

## *Document* Document.fromJSON(*String*|*Object* json)

        @fromJSON = (json) ->
            # parse json
            if typeof json is 'string'
                json = utils.tryFunction JSON.parse, null, [json], json

            assert.isArray json

            if file = files[json[JSON_PATH]]
                return file

            file = Document.JSON_CTORS[json[0]]._fromJSON json
            assert.notOk files[file.path]?

            # save to storage
            files[file.path] = file

            file

        @_fromJSON = do ->
            parseObject = (file, obj, target) ->
                for key, val of obj
                    target[key] = Document.JSON_CTORS[val[0]]._fromJSON file, val
                return

            parseArray = (file, arr, target) ->
                for val in arr
                    target.push Document.JSON_CTORS[val[0]]._fromJSON file, val
                return

            (arr, obj) ->
                unless obj
                    node = Document.Element.fromJSON arr[JSON_NODE]
                    obj = new Document arr[JSON_PATH], node

                # targetNode
                if arr[JSON_TARGET_NODE]
                    obj.targetNode = node.getChildByAccessPath arr[JSON_TARGET_NODE]

                # attrsToParse
                {attrsToParse} = obj
                jsonAttrsToParse = arr[JSON_ATTRS_TO_PARSE]
                for attrNode, i in jsonAttrsToParse by 2
                    attrsToParse.push node.getChildByAccessPath(attrNode)
                    attrsToParse.push jsonAttrsToParse[i+1]

                utils.merge obj.fragments, arr[JSON_FRAGMENTS]
                if (scripts = arr[JSON_SCRIPTS])?
                    obj.scripts = Document.JSON_CTORS[scripts[0]]._fromJSON(obj, scripts)
                parseArray obj, arr[JSON_ATTR_CHANGES], obj.attrChanges
                parseArray obj, arr[JSON_INPUTS], obj.inputs
                parseArray obj, arr[JSON_CONDITIONS], obj.conditions
                parseArray obj, arr[JSON_ITERATORS], obj.iterators
                parseArray obj, arr[JSON_USES], obj.uses

                for id, path of arr[JSON_IDS]
                    obj.ids[id] = obj.node.getChildByAccessPath path

                parseArray obj, arr[JSON_ATTRS_TO_SET], obj.attrsToSet

                `//<development>`
                parseArray obj, arr[JSON_LOGS], obj.logs
                `//</development>`

                parseArray obj, arr[JSON_STYLES], obj.styles

                obj

## Document.parse(*Document* file)

        @parse = do ->
            unless utils.isNode
                return (file) ->
                    throw new Error "Document.parse() is available only on the server"

            rules = require('./file/parse/rules') Document
            fragments = require('./file/parse/fragments') Document
            scripts = require('./file/parse/scripts') Document
            styles = require('./file/parse/styles') Document
            attrs = require('./file/parse/attrs') Document
            attrChanges = require('./file/parse/attrChanges') Document
            iterators = require('./file/parse/iterators') Document
            target = require('./file/parse/target') Document
            uses = require('./file/parse/uses') Document
            storage = require('./file/parse/storage') Document
            conditions = require('./file/parse/conditions') Document
            ids = require('./file/parse/ids') Document
            logs = require('./file/parse/logs') Document
            attrSetting = require('./file/parse/attrSetting') Document

            (file) ->
                assert.instanceOf file, Document
                assert.notOk files[file.path]?

                files[file.path] = file

                # trigger signal
                Document.onBeforeParse.emit file

                # parse
                styles file
                rules file
                fragments file
                scripts file
                iterators file
                attrs file
                attrChanges file
                target file
                uses file
                storage file
                conditions file
                ids file
                attrSetting file
                `//<development>`
                logs file
                `//</development>`

                # trigger signal
                Document.onParse.emit file

                file

## *Document* Document.factory(*String* path)

        @factory = (path) ->
            unless files.hasOwnProperty path
                # TODO: trigger here instance of `LoadError` class
                Document.onError.emit path

            assert.isString path, "path is not a string"
            assert.ok files[path]?, "the given file path '#{path}' doesn't exist"

            # from pool
            if r = getFromPool(path)
                return r

            # clone original
            file = files[path].clone()

            Document.onCreate.emit file

            file

## Document::constructor(*String* path, *Element* element)

        @emitNodeSignal = emitNodeSignal = (file, attrName, attr1, attr2) ->
            if nodeSignal = file.node.attrs[attrName]
                nodeSignal?.call? file, attr1, attr2
            return

        constructor: (@path, @node) ->
            assert.isString @path
            assert.notLengthOf @path, 0
            assert.instanceOf @node, Document.Element

            super()

            @isClone = false
            @uid = utils.uid()
            @isRendered = false
            @targetNode = null
            @parent = null
            @context = null
            @scripts = null
            @props = null
            @root = null
            @source = null
            @parentUse = null

            @attrsToParse = []
            @fragments = {}
            @attrChanges = []
            @inputs = []
            @conditions = []
            @iterators = []
            @uses = []
            @ids = {}
            @attrsToSet = []
            @logs = []
            @styles = []
            @inputIds = new Dict
            @inputProps = new Dict
            @inputState = new Dict
            @inputArgs = [@inputIds, @inputProps, @inputState]

            @node.onAttrsChange @_updateInputAttrsKey, @
            @inputProps.extend @node.attrs

            `//<development>`
            if @constructor is Document
                Object.preventExtensions @
            `//</development>`

# *Document* Document::render([*Any* props, *Any* root, *Document* source])

        render: (props, root, source) ->
            unless @isClone
                @clone().render props, root, source
            else
                @_render(props, root, source)

        _updateInputAttrsKey: (key) ->
            {inputProps, source, props} = @
            viewAttrs = @node.attrs

            if source
                val = source.node.attrs[key]
                if val is undefined and props
                    val = props[key]
                if val is undefined
                    val = viewAttrs[key]
            else
                if props
                    val = props[key]
                if val is undefined
                    val = viewAttrs[key]

            if val is undefined
                inputProps.pop key
            else
                inputProps.set key, val
            return

        _render: do ->
            renderTarget = require('./file/render/parse/target') Document

            (props=true, root=null, source) ->
                assert.notOk @isRendered

                @props = props
                @source = source
                @root = root

                {inputProps, inputIds} = @

                if props instanceof Dict
                    props.onChange @_updateInputAttrsKey, @

                if source?
                    # props
                    viewAttrs = @node.attrs
                    sourceAttrs = source.node.attrs
                    source.node.onAttrsChange @_updateInputAttrsKey, @
                    for prop, val of inputProps
                        if viewAttrs[prop] is props[prop] is sourceAttrs[prop] is undefined
                            inputProps.pop prop
                    for prop, val of viewAttrs
                        if props[prop] is sourceAttrs[prop] is undefined
                            if val isnt undefined
                                inputProps.set prop, val
                    for prop, val of props
                        if sourceAttrs[prop] is undefined
                            if val isnt undefined
                                inputProps.set prop, val
                    for prop, val of sourceAttrs
                        if val isnt undefined
                            inputProps.set prop, val

                    # ids
                    viewIds = @ids
                    sourceIds = source.file.inputIds
                    for prop, val of inputIds
                        if viewIds[prop] is undefined and sourceIds[prop] is undefined
                            inputIds.pop prop
                    for prop, val of sourceIds
                        if viewIds[prop] is undefined
                            inputIds.set prop, val
                    for prop, val of viewIds
                        inputIds.set prop, val
                else
                    # props
                    viewAttrs = @node.attrs
                    for prop, val of inputProps
                        if viewAttrs[prop] is props[prop] is undefined
                            inputProps.pop prop
                    for prop, val of viewAttrs
                        if props[prop] is undefined
                            if val isnt undefined
                                inputProps.set prop, val
                    for prop, val of props
                        if val isnt undefined
                            inputProps.set prop, val

                Document.onBeforeRender.emit @
                emitNodeSignal @, 'n-onBeforeRender'
                if @context?.node is @node
                    @context.state = @inputState
                    emitSignal @context, 'onBeforeRender'

                # inputs
                for input, i in @inputs
                    input.render()

                # conditions
                for condition, i in @conditions
                    condition.render()

                # uses
                for use in @uses
                    unless use.isRendered
                        use.render()

                # iterators
                for iterator, i in @iterators
                    iterator.render()

                # source
                renderTarget @, source

                # logs
                `//<development>`
                for log in @logs
                    log.render()
                `//</development>`

                @isRendered = true
                Document.onRender.emit @
                emitNodeSignal @, 'n-onRender'
                if @context?.node is @node
                    emitSignal @context, 'onRender'

                @

## *Document* Document::revert()

        revert: do ->
            target = require('./file/render/revert/target') Document
            ->
                assert.ok @isRendered

                @isRendered = false
                Document.onBeforeRevert.emit @
                emitNodeSignal @, 'n-onBeforeRevert'
                if @context?.node is @node
                    emitSignal @context, 'onBeforeRevert'

                if @props instanceof Dict
                    @props.onChange.disconnect @_updateInputAttrsKey, @

                # props
                if @source
                    @source.node.onAttrsChange.disconnect @_updateInputAttrsKey, @

                # parent use
                @parentUse?.detachUsedFragment()

                # inputs
                if @inputs
                    for input, i in @inputs
                        input.revert()

                # uses
                if @uses
                    for use in @uses
                        use.revert()

                # iterators
                if @iterators
                    for iterator, i in @iterators
                        iterator.revert()

                # target
                target @, @source

                @props = null
                @source = null
                @root = null
                @inputState.clear()

                Document.onRevert.emit @
                emitNodeSignal @, 'n-onRevert'
                if @context?.node is @node
                    @context.state = null
                    emitSignal @context, 'onRevert'

                @

## *Document* Document::use(*String* useName, [*Document* document])

        use: (useName, view) ->
            if @uses
                for use in @uses
                    if use.name is useName
                        elem = use
                        break

            if elem
                elem.render view
            else
                log.warn "'#{@path}' view doesn't have '#{useName}' use"

            @

## *Signal* Document::onReplaceByUse(*Document.Use* use)

Corresponding node handler: *n-onReplaceByUse=""*.

        Emitter.createSignal @, 'onReplaceByUse'

## *Document* Document::clone()

        clone: ->
            # from pool
            if r = getFromPool(@path)
                r
            else
                if @isClone and (original = files[@path])
                    original._clone()
                else
                    @_clone()

        parseAttr = do ->
            cache = Object.create null
            (val) ->
                func = cache[val] ?= new Function 'Dict', 'List', "return #{val}"
                func Dict, List

        _clone: ->
            clone = new Document @path, @node.cloneDeep()
            clone.isClone = true
            clone.fragments = @fragments

            if @targetNode
                clone.targetNode = @node.getCopiedElement @targetNode, clone.node

            # attrsToParse
            {attrsToParse} = @
            for attrNode, i in attrsToParse by 2
                attrNode = @node.getCopiedElement attrNode, clone.node
                attrName = attrsToParse[i+1]
                attrNode.attrs.set attrName, parseAttr(attrNode.attrs[attrName])

            # attrChanges
            for attrChange in @attrChanges
                clone.attrChanges.push attrChange.clone @, clone

            # ids
            for id, node of @ids
                clone.ids[id] = @node.getCopiedElement node, clone.node
            clone.inputIds.extend clone.ids

            # inputs
            for input in @inputs
                clone.inputs.push input.clone @, clone

            # conditions
            for condition in @conditions
                clone.conditions.push condition.clone @, clone

            # iterators
            for iterator in @iterators
                clone.iterators.push iterator.clone @, clone

            # uses
            for use in @uses
                clone.uses.push use.clone @, clone

            # attrs to set
            for attrsToSet in @attrsToSet
                clone.attrsToSet.push attrsToSet.clone @, clone

            # logs
            for log in @logs
                clone.logs.push log.clone @, clone

            # context
            if @scripts
                clone.context = @scripts.createCloneContext clone

            clone

## Document::destroy()

        destroy: ->
            if @isRendered
                @revert()

            pathPool = pool[@path] ?= []
            assert.notOk utils.has(pathPool, @)

            pathPool.push @
            return

## *Object* Document::toJSON()

        toJSON: do ->
            callToJSON = (elem) ->
                elem.toJSON()

            (key, arr) ->
                if @isClone and original = Document._files[@path]
                    return original.toJSON key, arr

                unless arr
                    arr = new Array JSON_ARGS_LENGTH
                    arr[0] = JSON_CTOR_ID
                arr[JSON_PATH] = @path
                arr[JSON_NODE] = @node.toJSON()

                # targetNode
                if @targetNode
                    arr[JSON_TARGET_NODE] = @targetNode.getAccessPath @node

                # attrsToParse
                attrsToParse = arr[JSON_ATTRS_TO_PARSE] = new Array @attrsToParse.length
                for attrNode, i in @attrsToParse by 2
                    attrsToParse[i] = attrNode.getAccessPath @node
                    attrsToParse[i+1] = @attrsToParse[i+1]

                arr[JSON_FRAGMENTS] = @fragments
                arr[JSON_SCRIPTS] = @scripts
                arr[JSON_ATTR_CHANGES] = @attrChanges.map callToJSON
                arr[JSON_INPUTS] = @inputs.map callToJSON
                arr[JSON_CONDITIONS] = @conditions.map callToJSON
                arr[JSON_ITERATORS] = @iterators.map callToJSON
                arr[JSON_USES] = @uses.map callToJSON

                ids = arr[JSON_IDS] = {}
                for id, node of @ids
                    ids[id] = node.getAccessPath @node

                arr[JSON_ATTRS_TO_SET] = @attrsToSet

                `//<development>`
                arr[JSON_LOGS] = @logs.map callToJSON
                `//</development>`
                `//<production>`
                arr[JSON_LOGS] = []
                `//</production>`

                arr[JSON_STYLES] = @styles.map callToJSON

                arr

# Glossary

- [Document](#class-document)
