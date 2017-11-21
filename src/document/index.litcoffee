# Document

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'
    log = require 'src/log'
    signal = require 'src/signal'
    eventLoop = require 'src/eventLoop'
    EventLoopDict = require 'src/eventLoop/dict'
    Dict = require 'src/dict'
    List = require 'src/list'
    Schema = require 'src/schema'
    ImmutableInputDict = require './input/immutableDict'

    assert = assert.scope 'View'
    log = log.scope 'View'

    {Emitter} = signal
    {emitSignal} = Emitter

    module.exports = class Document extends Emitter
        files = {}
        pool = Object.create null

        `//<development>`
        @_files = files
        @_pool = pool
        `//</development>`

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
        JSON_PROPS_TO_PARSE = i++
        JSON_COMPONENTS = i++
        JSON_SCRIPTS = i++
        JSON_STATE_CHANGES = i++
        JSON_INPUTS = i++
        JSON_CONDITIONS = i++
        JSON_ITERATORS = i++
        JSON_USES = i++
        JSON_REFS = i++
        JSON_PROPS_TO_SET = i++
        JSON_LOGS = i++
        JSON_STYLES = i++
        JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

        @FILES_PATH = ''
        @SCRIPTS_PATH = ''
        @STYLES_PATH = ''

        @LoadError = class DocumentLoadError extends Error
            constructor: (@path) ->
                @name = 'DocumentLoadError'
                @message = "Cannot load '#{@path}'"
                @stack = (new Error).stack

        signal.create @, 'onCreate'
        signal.create @, 'onError'
        signal.create @, 'onBeforeParse'
        signal.create @, 'onParse'
        signal.create @, 'onStyle'
        signal.create @, 'onScript'

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
        @StateChange = require('./stateChange') @
        @Use = require('./use') @
        @Scripts = require('./scripts') @
        @Input = require('./input') @
        @Condition = require('./condition') @
        @Iterator = require('./iterator') @
        @Log = require('./log') @
        @PropsToSet = require('./propsToSet') @

## *Document* Document.fromHTML(*String* path, *String* html)

        @fromHTML = do ->
            unless process.env.NEFT_PLATFORM is 'node'
                return (path, html) ->
                    throw new Error 'Document.fromHTML is available only on the server'

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

                # propsToParse
                {propsToParse} = obj
                jsonPropsToParse = arr[JSON_PROPS_TO_PARSE]
                for propNode, i in jsonPropsToParse by 2
                    propsToParse.push node.getChildByAccessPath(propNode)
                    propsToParse.push jsonPropsToParse[i+1]

                utils.merge obj.components, arr[JSON_COMPONENTS]
                if (scripts = arr[JSON_SCRIPTS])?
                    obj.scripts = Document.JSON_CTORS[scripts[0]]._fromJSON(obj, scripts)
                parseArray obj, arr[JSON_STATE_CHANGES], obj.stateChanges
                parseArray obj, arr[JSON_INPUTS], obj.inputs
                parseArray obj, arr[JSON_CONDITIONS], obj.conditions
                parseArray obj, arr[JSON_ITERATORS], obj.iterators
                parseArray obj, arr[JSON_USES], obj.uses

                for ref, path of arr[JSON_REFS]
                    obj.refs[ref] = obj.node.getChildByAccessPath path

                parseArray obj, arr[JSON_PROPS_TO_SET], obj.propsToSet

                `//<development>`
                parseArray obj, arr[JSON_LOGS], obj.logs
                `//</development>`

                parseArray obj, arr[JSON_STYLES], obj.styles

                obj

## Document.parse(*Document* file)

        @parse = do ->
            unless process.env.NEFT_PLATFORM is 'node'
                return (file) ->
                    throw new Error "Document.parse() is available only on the server"

            components = require('./file/parse/components') Document
            scripts = require('./file/parse/scripts') Document
            styles = require('./file/parse/styles') Document
            props = require('./file/parse/props') Document
            stateChanges = require('./file/parse/stateChanges') Document
            iterators = require('./file/parse/iterators') Document
            target = require('./file/parse/target') Document
            uses = require('./file/parse/uses') Document
            storage = require('./file/parse/storage') Document
            conditions = require('./file/parse/conditions') Document
            refs = require('./file/parse/refs') Document
            logs = require('./file/parse/logs') Document
            propSetting = require('./file/parse/propSetting') Document

            (file) ->
                assert.instanceOf file, Document
                assert.notOk files[file.path]?

                files[file.path] = file

                # trigger signal
                Document.onBeforeParse.emit file

                # parse
                components file
                styles file
                scripts file
                iterators file
                props file
                stateChanges file
                target file
                uses file
                storage file
                conditions file
                refs file
                propSetting file
                `//<development>`
                logs file
                `//</development>`

                # trigger signal
                Document.onParse.emit file

                file

## *Document* Document.factory(*String* path)

        @factory = (path) ->
            assert.isString path, "path is not a string"
            assert.ok files[path]?, "the given file path '#{path}' doesn't exist"

            # from pool
            if r = getFromPool(path)
                return r

            # clone original
            file = files[path].clone()

            Document.onCreate.emit file

            file

## *Document* Document::constructor(*String* path, *Element* element)

        @emitNodeSignal = emitNodeSignal = (file, propName, prop1, prop2) ->
            if nodeSignal = file.node.props[propName]
                nodeSignal?.call? file, prop1, prop2
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
            @scope = null
            @scripts = null
            @props = null
            @context = null
            @source = null
            @parentUse = null

            @propsToParse = []
            @components = {}
            @stateChanges = []
            @inputs = []
            @conditions = []
            @iterators = []
            @uses = []
            @refs = {}
            @propsToSet = []
            @logs = []
            @styles = []
            @inputRefs = new ImmutableInputDict @, 'refs'
            @inputProps = new ImmutableInputDict @, 'props'
            @inputState = new EventLoopDict
            @inputArgs = [@inputRefs, @inputProps, @inputState]

            @node.onPropsChange @_updateInputPropsKey, @
            for key, val of @node.props
                @_setInputProp key, val

            `//<development>`
            if @constructor is Document
                Object.seal @
            `//</development>`

# *Document* Document::render([*Any* props, *Any* context, *Document* source])

        render: (props, context, source, refs) ->
            unless @isClone
                @clone().render props, context, source, refs
            else
                eventLoop.lock()
                result = @_render(props, context, source, refs)
                eventLoop.release()
                result

        isInternalProp = (prop) ->
            prop[0] is 'n' and prop[1] is '-'

        ###
        Sets or updates component props field.
        Undefined value is omitted.
        Internal props (started with 'n-') are omitted.
        ###
        _setInputProp: (key, val) ->
            if val isnt undefined and not isInternalProp(key)
                @inputProps._set key, val
            return

        _updateInputPropsKey: (key) ->
            {source, props} = @
            viewProps = @node.props

            if source
                val = source.node.props[key]
                if val is undefined and props
                    val = props[key]
                if val is undefined
                    val = viewProps[key]
            else
                if props
                    val = props[key]
                if val is undefined
                    val = viewProps[key]

            if val is undefined
                @inputProps._pop key
            else
                @_setInputProp key, val
            return

        _warnPropSchema: (error) ->
            log.error "Invalid props passed for component #{@path}: #{error.message}"
            return

        validateProps = (doc) ->
            if propsSchema = doc.scope.propsSchema
                if utils.isPlainObject(propsSchema)
                    propsSchema = new Schema propsSchema
                assert.instanceOf propsSchema, Schema, '''
                    propsSchema needs to be an instance of Neft.Schema
                '''
                if error = utils.catchError(propsSchema.validate, propsSchema, [doc.inputProps])
                    doc._warnPropSchema error
            return

        _render: do ->
            renderTarget = require('./file/render/parse/target') Document

            (props = true, context = null, source, refs) ->
                assert.notOk @isRendered

                @props = props
                @source = source
                @context = context

                # @scope can be changed before render;
                # given scope will be used as already rendered;
                # some of fields from external scope will be available
                isScopeRender = @scope?.node is @node

                {inputProps, inputRefs} = @

                if props instanceof Dict
                    props.onChange @_updateInputPropsKey, @

                if source?
                    # props
                    viewProps = @node.props
                    sourceProps = source.node.props
                    source.node.onPropsChange @_updateInputPropsKey, @
                    for prop, val of inputProps
                        if viewProps[prop] is props[prop] is sourceProps[prop] is undefined
                            inputProps._pop prop
                    for prop, val of viewProps
                        if props[prop] is sourceProps[prop] is undefined
                            @_setInputProp prop, val
                    for prop, val of props
                        if sourceProps[prop] is undefined
                            @_setInputProp prop, val
                    for prop, val of sourceProps
                        @_setInputProp prop, val
                else
                    # props
                    viewProps = @node.props
                    for prop, val of inputProps
                        if viewProps[prop] is props[prop] is undefined
                            inputProps._pop prop
                    for prop, val of viewProps
                        if props[prop] is undefined
                            @_setInputProp prop, val
                    for prop, val of props
                        @_setInputProp prop, val

                # refs
                if refs
                    viewRefs = @refs
                    for prop, val of inputRefs
                        if viewRefs[prop] is undefined and refs[prop] is undefined
                            inputRefs._pop prop
                    for prop, val of refs
                        if viewRefs[prop] is undefined
                            inputRefs._set prop, val
                    for prop, val of viewRefs
                        inputRefs._set prop, val

                # propsSchema
                if isScopeRender
                    validateProps @

                Document.onBeforeRender.emit @
                emitNodeSignal @, 'n-onBeforeRender'

                # defaultState
                if isScopeRender and @scope.defaultState isnt undefined
                    assert.isPlainObject @scope.defaultState, '''
                        defaultState needs to be a plain object
                    '''
                    @inputState.extend @scope.defaultState

                # stateChanges
                if isScopeRender
                    for stateChange in @stateChanges
                        stateChange.render()

                # if set scope is original, prepare it
                if isScopeRender
                    emitSignal @scope, 'onBeforeRender'
                else
                    # treat given scope as pointer
                    @inputArgs[2] = @scope.state

                # inputs
                for input in @inputs
                    input.render()

                # conditions
                for condition in @conditions
                    condition.render()

                # uses
                for use in @uses
                    unless use.isRendered
                        use.render()

                # iterators
                for iterator in @iterators
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
                if isScopeRender
                    emitSignal @scope, 'onRender'

                @

## *Document* Document::revert()

        revert: do ->
            target = require('./file/render/revert/target') Document
            ->
                assert.ok @isRendered

                isScopeRender = @scope?.node is @node

                Document.onBeforeRevert.emit @
                emitNodeSignal @, 'n-onBeforeRevert'
                if isScopeRender
                    emitSignal @scope, 'onBeforeRevert'

                if @props instanceof Dict
                    @props.onChange.disconnect @_updateInputPropsKey, @

                # props
                if @source
                    @source.node.onPropsChange.disconnect @_updateInputPropsKey, @

                # parent use
                @parentUse?.detachUsedComponent()

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
                @context = null
                @inputState.clear()

                @isRendered = false

                Document.onRevert.emit @
                emitNodeSignal @, 'n-onRevert'
                if isScopeRender
                    emitSignal @scope, 'onRevert'
                else
                    @inputArgs[2] = @inputState

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

        parseProp = do ->
            cache = Object.create null
            (val) ->
                func = cache[val] ?= new Function 'Dict', 'List', "return #{val}"
                func Dict, List

        _clone: ->
            clone = new Document @path, @node.cloneDeep()
            clone.isClone = true
            clone.components = @components

            if @targetNode
                clone.targetNode = @node.getCopiedElement @targetNode, clone.node

            # propsToParse
            {propsToParse} = @
            for propNode, i in propsToParse by 2
                propNode = @node.getCopiedElement propNode, clone.node
                propName = propsToParse[i + 1]
                propNode.props.set propName, parseProp(propNode.props[propName])

            # stateChanges
            for stateChange in @stateChanges
                clone.stateChanges.push stateChange.clone @, clone

            # refs
            for ref, node of @refs
                clone.refs[ref] = @node.getCopiedElement node, clone.node
            for key, val of clone.refs
                clone.inputRefs._set key, val

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

            # props to set
            for propsToSet in @propsToSet
                clone.propsToSet.push propsToSet.clone @, clone

            # logs
            for log in @logs
                clone.logs.push log.clone @, clone

            # scope
            if @scripts
                clone.scope = @scripts.createCloneScope clone

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
                if @isClone and original = files[@path]
                    return original.toJSON key, arr

                unless arr
                    arr = new Array JSON_ARGS_LENGTH
                    arr[0] = JSON_CTOR_ID
                arr[JSON_PATH] = @path
                arr[JSON_NODE] = @node.toJSON()

                # targetNode
                if @targetNode
                    arr[JSON_TARGET_NODE] = @targetNode.getAccessPath @node

                # propsToParse
                propsToParse = arr[JSON_PROPS_TO_PARSE] = new Array @propsToParse.length
                for propNode, i in @propsToParse by 2
                    propsToParse[i] = propNode.getAccessPath @node
                    propsToParse[i+1] = @propsToParse[i+1]

                arr[JSON_COMPONENTS] = @components
                arr[JSON_SCRIPTS] = @scripts
                arr[JSON_STATE_CHANGES] = @stateChanges.map callToJSON
                arr[JSON_INPUTS] = @inputs.map callToJSON
                arr[JSON_CONDITIONS] = @conditions.map callToJSON
                arr[JSON_ITERATORS] = @iterators.map callToJSON
                arr[JSON_USES] = @uses.map callToJSON

                refs = arr[JSON_REFS] = {}
                for ref, node of @refs
                    refs[ref] = node.getAccessPath @node

                arr[JSON_PROPS_TO_SET] = @propsToSet

                `//<production>`
                arr[JSON_LOGS] = []
                `//</production>`
                `//<development>`
                arr[JSON_LOGS] = @logs.map callToJSON
                `//</development>`

                arr[JSON_STYLES] = @styles.map callToJSON

                arr
