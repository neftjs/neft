'use strict'

{util, Renderer} = require '@neft/core'
bindingParser = require '@neft/compiler-binding'
nmlAst = require './nmlAst'

PRIMITIVE_TYPE = 'primitive'

PUBLIC_BINDING_VARIABLES =
    __proto__: null
    Renderer: true

RENDERER_KEYS = new Set Object.keys(Renderer)

RESERVED_MAIN_IDS =
    __proto__: null
    New: true

IDS_PREFIXED_BY_DEFAULT = new Set [
    'parent',
    'nextSibling',
    'previousSibling',
    'target'
]

bindingPrefixIdBy = (id) ->
    if RENDERER_KEYS.has(id)
        return 'Renderer'
    if IDS_PREFIXED_BY_DEFAULT.has(id)
        return 'this'

class Stringifier
    constructor: (@ast, @path, lastUID = 0) ->
        @lastUID = lastUID
        @objects = nmlAst.forEachLeaf
            ast: @ast, onlyType: nmlAst.OBJECT_TYPE, includeGiven: true,
            includeValues: true, deeply: true, omitDeepTypes: new Set([nmlAst.NESTING_TYPE])
        @ids = @objects.map (elem) -> elem.id
        @publicIds = @ids.filter (elem) -> elem[0] isnt '_'

    getNextUID: ->
        "_r#{@lastUID++}"

    isBindingPublicVariable: (id) =>
        PUBLIC_BINDING_VARIABLES[id] or util.has(@publicIds, id)

    stringifyObject: (ast) ->
        ids = []
        attributes = []
        functions = []
        children = []
        nesting = []

        for child in ast.body
            switch child.type
                when nmlAst.ID_TYPE
                    ids.push child
                when nmlAst.ATTRIBUTE_TYPE
                    attributes.push child
                when nmlAst.FUNCTION_TYPE
                    functions.push child
                when nmlAst.OBJECT_TYPE, nmlAst.CONDITION_TYPE, nmlAst.SELECT_TYPE
                    children.push child
                when nmlAst.NESTING_TYPE
                    nesting.push child.body...
                when nmlAst.PROPERTY_TYPE, nmlAst.SIGNAL_TYPE
                    null
                else
                    throw new Error "Unknown object type '#{child.type}'"

        opts = []

        for elem in ids
            opts.push
                type: PRIMITIVE_TYPE
                name: 'id'
                value: "\"#{elem.value}\""
        unless util.isEmpty(attributes)
            opts.push attributes...
        unless util.isEmpty(functions)
            opts.push functions...
        unless util.isEmpty(children)
            opts.push
                type: nmlAst.ATTRIBUTE_TYPE
                name: 'children'
                value: children
        unless util.isEmpty(nesting)
            nestingType =
                type: nmlAst.NESTING_TYPE
                body: nesting
            nestingStringifier = new Stringifier nestingType, @path, @lastUID * 10
            opts.push
                type: nmlAst.ATTRIBUTE_TYPE
                name: 'nesting'
                value:
                    type: nmlAst.FUNCTION_TYPE
                    params: []
                    code: "\n#{nestingStringifier.stringify()}"
        if util.isEmpty(opts)
            ast.id
        else
            "_RendererObject.setOpts(#{ast.id}, #{@stringifyOpts opts})"

    stringifyAttribute: (ast) ->
        {value} = ast
        if Array.isArray(value)
            @stringifyAttributeListValue value
        else if value?.type
            @stringifyAnyObject value
        else if @isAnchor(ast)
            @anchorToString value
        else if @isReference(value)
            @referenceToString value
        else if bindingParser.isBinding(value)
            @bindingToString value
        else
            value

    stringifyAttributeListValue: (values) ->
        types = values.map (value) -> value.type

        useObject = util.has types, nmlAst.ATTRIBUTE_TYPE
        useObject ||= util.has types, nmlAst.FUNCTION_TYPE
        useObject ||= util.has types, PRIMITIVE_TYPE
        if useObject
            @stringifyOpts values
        else
            children = (@stringifyAnyObject child for child in values)
            "[#{children.join ', '}]"

    stringifyFunction: (ast) ->
        # arguments
        args = ''
        if args and String(ast.params)
            args += ","
        args += String(ast.params)

        # code
        "function(#{args}){#{ast.code}}"

    createClass: (ast) ->
        changes = []
        body = []

        for child in ast.body
            switch child.type
                when nmlAst.ATTRIBUTE_TYPE, nmlAst.FUNCTION_TYPE
                    changes.push child
                else
                    body.push child

        object =
            type: nmlAst.OBJECT_TYPE
            name: 'Class'
            id: @getNextUID()
            body: [
                {
                    type: nmlAst.ATTRIBUTE_TYPE
                    name: 'changes'
                    value: changes
                },
                body...
            ]

        @objects.push object
        @ids.push object.id

        object

    stringifyCondition: (ast) ->
        object = @createClass ast
        object.body.unshift
            type: nmlAst.ATTRIBUTE_TYPE
            name: 'running'
            value:
                type: PRIMITIVE_TYPE
                value: @bindingToString ast.condition, suffixThisByTarget: true
        @stringifyObject object

    stringifySelect: (ast) ->
        object = @createClass ast
        object.body.unshift
            type: nmlAst.ATTRIBUTE_TYPE
            name: 'document.queryElements'
            value: '__elements'
        object.body.unshift
            type: nmlAst.ATTRIBUTE_TYPE
            name: 'document.query'
            value: ast.query
        @stringifyObject object

    stringifyNesting: (ast) ->
        return "return #{@stringifyAttributeListValue(ast.body)}"

    stringifyPrimitiveType: (ast) ->
        ast.value

    stringifyAnyObject: (ast) ->
        switch ast.type
            when nmlAst.ATTRIBUTE_TYPE
                @stringifyAttribute ast
            when nmlAst.FUNCTION_TYPE
                @stringifyFunction ast
            when nmlAst.OBJECT_TYPE
                @stringifyObject ast
            when nmlAst.CONDITION_TYPE
                @stringifyCondition ast
            when nmlAst.SELECT_TYPE
                @stringifySelect ast
            when nmlAst.NESTING_TYPE
                @stringifyNesting ast
            when PRIMITIVE_TYPE
                @stringifyPrimitiveType ast
            else
                throw new Error "Unknown NML object '#{ast.type}'"

    bindingToString: (value, {suffixThisByTarget} = {}) ->
        binding = bindingParser.parse value,
            shouldUseIdInConnections: @isBindingPublicVariable
            isHeadIdConnectionPublic: @isBindingPublicVariable
            suffixThisByTarget: suffixThisByTarget
            prefixBy: bindingPrefixIdBy
        func = "function(){return #{binding.hash}}"
        "[#{func}, #{binding.connections}]"

    isAnchor: (ast) ->
        ast.name.indexOf('anchors.') is 0

    anchorToString: (value) ->
        JSON.stringify value.split '.'

    isReference: (value) ->
        typeof value is 'string' and util.has(@publicIds, value)

    referenceToString: (value) ->
        value

    getIdsObject: (ast) ->
        elems = []
        for key in @ids
            elems.push "\"#{key}\": #{key}"
        "{#{elems.join ', '}}"

    stringifyOpts: (opts) ->
        results = ("\"#{opt.name}\": #{@stringifyAnyObject opt}" for opt in opts)
        "{#{results.join ', '}}"

    getItemsCreator: ->
        result = ""
        for child in @objects
            result += "const #{child.id} = #{child.name}.New()\n"
            if process.env.NODE_ENV isnt 'production' and @path
                result += "#{child.id}._path = \"#{@path}\"\n"
        result

    getItemsProperties: ->
        result = ""
        for child in @objects
            properties = nmlAst.forEachLeaf ast: child, onlyType: nmlAst.PROPERTY_TYPE
            for property in properties
                result += "_RendererObject.createProperty(#{child.id}, \"#{property.name}\")\n"
        result

    getItemsSignals: ->
        result = ""
        for child in @objects
            signals = nmlAst.forEachLeaf ast: child, onlyType: nmlAst.SIGNAL_TYPE
            for signal in signals
                result += "_RendererObject.createSignal(#{child.id}, \"#{signal.name}\")\n"
        result

    stringify: ->
        if RESERVED_MAIN_IDS[@ast.id]
            throw new Error "Reserved NML id '#{@ast.id}'"

        result = ""
        itemCode = @stringifyAnyObject @ast

        # create items
        result += @getItemsCreator()
        result += @getItemsProperties()
        result += @getItemsSignals()

        # put main item
        if itemCode
            result += "#{itemCode}\n"

        if @ast.type is nmlAst.NESTING_TYPE
            return result

        # return
        result += "return { objects: #{@getIdsObject @ast}"
        if @ast.id
            result += ", item: #{@ast.id}"
        else
            result += ", select: #{@ids[0]}"
        result += ' }'
        result

exports.stringify = (ast, path) ->
    new Stringifier(ast, path).stringify()
