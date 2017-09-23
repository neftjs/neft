'use strict'

babel = require 'babel-core'
utils = require 'src/utils'
bindingParser = require 'src/binding/parser'
Renderer = require 'src/renderer'
nmlAst = require './nmlAst'

PRIMITIVE_TYPE = 'primitive'

PUBLIC_BINDING_VARIABLES =
    __proto__: null
    document: true
    app: true

PUBLIC_BINDING_IDS =
    __proto__: null
    windowItem: true

{BINDING_THIS_TO_TARGET_OPTS} = bindingParser

BINDING_PARSER_OPTS =
    modifyBindingPart: (elem) ->
        # Prefix all Renderer.* direct access by the namespace accessible in style file
        if Renderer[elem[0]]
            elem.unshift 'Neft', 'Renderer'
        elem

transformByBabel = (body) ->
    body = "(function(){#{body}})"
    body = babel.transform(body, presets: ['es2015']).code
    body = /{([^]*)}/m.exec(body)?[1]
    body

class Stringifier
    constructor: (@ast, @path) ->
        @lastUID = 0
        @objects = nmlAst.forEachLeaf
            ast: @ast, onlyType: nmlAst.OBJECT_TYPE, includeGiven: true,
            includeValues: true, deeply: true
        @ids = @objects.map (elem) -> elem.id
        @publicIds = @ids.filter (elem) -> elem[0] isnt '_'

    getNextUID: ->
        "_r#{@lastUID++}"

    isBindingPublicVariable: (id) =>
        PUBLIC_BINDING_VARIABLES[id] or utils.has(@publicIds, id)

    isBindingPublicId: (id) =>
        id is 'this' or PUBLIC_BINDING_IDS[id] or
        @isBindingPublicVariable(id) or Renderer[id]?

    stringifyObject: (ast) ->
        opts = @getObjectOpts ast
        opts or ast.id

    stringifyAttribute: (ast) ->
        {value} = ast
        if Array.isArray(value)
            @stringifyAttributeListValue value
        else if value?.type
            @stringifyAnyObject value
        else if @isAnchor(ast)
            @anchorToString value
        else if bindingParser.isBinding(value)
            @bindingToString value
        else
            value

    stringifyAttributeListValue: (values) ->
        types = values.map (value) -> value.type

        useObject = utils.has types, nmlAst.ATTRIBUTE_TYPE
        useObject ||= utils.has types, nmlAst.FUNCTION_TYPE
        useObject ||= utils.has types, PRIMITIVE_TYPE
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
        code = transformByBabel ast.code
        "`function(#{args}){#{code}}`"

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
            name: 'when'
            value:
                type: PRIMITIVE_TYPE
                value: @bindingToString ast.condition, BINDING_THIS_TO_TARGET_OPTS
        @stringifyObject object

    stringifySelect: (ast) ->
        object = @createClass ast
        object.body.unshift
            type: nmlAst.ATTRIBUTE_TYPE
            name: 'document.query'
            value: ast.query
        @stringifyObject object

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
            when PRIMITIVE_TYPE
                @stringifyPrimitiveType ast
            else
                throw new Error "Unknown NML object '#{ast.type}'"

    getObjectOpts: (ast) ->
        ids = []
        properties = []
        signals = []
        attributes = []
        functions = []
        children = []

        for child in ast.body
            switch child.type
                when nmlAst.ID_TYPE
                    ids.push child
                when nmlAst.PROPERTY_TYPE
                    properties.push child
                when nmlAst.SIGNAL_TYPE
                    signals.push child
                when nmlAst.ATTRIBUTE_TYPE
                    attributes.push child
                when nmlAst.FUNCTION_TYPE
                    functions.push child
                when nmlAst.OBJECT_TYPE, nmlAst.CONDITION_TYPE, nmlAst.SELECT_TYPE
                    children.push child
                else
                    throw new Error "Unknown object type '#{child.type}'"

        opts = []

        for elem in ids
            opts.push
                type: PRIMITIVE_TYPE
                name: 'id'
                value: "\"#{elem.value}\""
        unless utils.isEmpty(properties)
            opts.push
                type: PRIMITIVE_TYPE
                name: 'properties'
                value: JSON.stringify properties.map (elem) -> elem.name
        unless utils.isEmpty(signals)
            opts.push
                type: PRIMITIVE_TYPE
                name: 'signals'
                value: JSON.stringify signals.map (elem) -> elem.name
        unless utils.isEmpty(attributes)
            opts.push attributes...
        unless utils.isEmpty(functions)
            opts.push functions...
        unless utils.isEmpty(children)
            opts.push
                type: nmlAst.ATTRIBUTE_TYPE
                name: 'children'
                value: children

        unless utils.isEmpty(opts)
            "_setOpts(#{ast.id}, #{@stringifyOpts opts})"

    bindingToString: (value, opts = 0) ->
        binding = bindingParser.parse value, @isBindingPublicId, opts,
            BINDING_PARSER_OPTS, @isBindingPublicVariable
        func = "`function(){return #{binding.hash}}`"
        "[#{func}, [#{binding.connections}]]"

    isAnchor: (ast) ->
        ast.name.indexOf('anchors.') is 0

    anchorToString: (value) ->
        JSON.stringify value.split '.'

    getIdsObject: (ast) ->
        elems = []
        for key in @ids
            elems.push "\"#{key}\": #{key}"
        "{#{elems.join ', '}}"

    stringifyOpts: (opts) ->
        results = ("\"#{opt.name}\": #{@stringifyAnyObject opt}" for opt in opts)
        "{#{results.join ', '}}"

    stringify: ->
        result = ""
        itemCode = @getObjectOpts @ast

        # create items
        for child in @objects
            result += "#{child.id} = #{child.name}.New()\n"
            if @path
                result += "#{child.id}._path = \"#{@path}\"\n"

        # put main item
        if itemCode
            result += "#{itemCode}\n"

        # call onReady
        for child in @objects
            if not Renderer[child.name] or 'onReady' of Renderer[child.name]::
                result += "#{child.id}.onReady.emit()\n"

        # return
        result += "objects: #{@getIdsObject @ast}\n"
        result += "item: #{@ast.id}"
        result

exports.stringify = (ast, path) ->
    new Stringifier(ast, path).stringify()
