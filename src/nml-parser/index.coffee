'use strict'

babel = require 'babel-core'
bundle = require './bundle'
parser = require './parser'
bindingParser = require 'src/binding/parser'
log = require 'src/log'
utils = require 'src/utils'
Renderer = require 'src/renderer'
assert = require 'src/assert'

ATTRIBUTE = 'attribute'

# options
{BINDING_THIS_TO_TARGET_OPTS} = bindingParser

bindingParserOpts =
    modifyBindingPart: (elem) ->
        # Prefix all Renderer.* direct access by the namespace accessible in style file
        if Renderer[elem[0]]
            elem.unshift 'Renderer'
        elem

ids = idsKeys = itemsKeys = extensions = queries = requires = null
itemsDeclarations = afterItemCode = null
fileUid = 0

transformByBabel = (body) ->
    body = "(function(){#{body}})"
    body = babel.transform(body, presets: ['es2015']).code
    body = /{([^]*)}/m.exec(body)?[1]
    body

isAnchor = (obj) ->
    assert obj.type is ATTRIBUTE, "isAnchor: type must be an attribute"

    obj.name is 'anchors' or obj.name.indexOf('anchors.') is 0

isBinding = (obj) ->
    assert obj.type is ATTRIBUTE, "isBinding: type must be an attribute"

    bindingParser.isBinding obj.value

getByTypeDeep = (elem, type, callback) ->
    if elem.type is type
        callback elem

    for child in elem.body
        if child.type is type
            callback child
        if child.body?
            getByTypeDeep child, type, callback
        else if child.value?.body
            getByTypeDeep child.value, type, callback

    return

MODIFIERS_NAMES =
    __proto__: null
    Class: true
    Transition: true
    Animation: true
    PropertyAnimation: true
    NumberAnimation: true
    SequentialAnimation: true
    FontLoader: true
    ResourcesLoader: true

anchorAttributeToString = (obj) ->
    assert obj.type is ATTRIBUTE, "anchorAttributeToString: type must be an attribute"

    if typeof obj.value is 'object'
        return "{}"

    anchor = obj.value.split '.'
    if anchor[0] is 'this'
        anchor.shift()
        anchor[0] = "this.#{anchor[0]}"
    else if anchor[0] is 'null'
        return 'null'

    useBinding = false
    anchor[0] = switch anchor[0]
        when 'this.parent', 'parent'
            "'parent'"
        when 'this.children', 'children'
            "'children'"
        when 'this.nextSibling', 'nextSibling'
            "'nextSibling'"
        when 'this.previousSibling', 'previousSibling'
            "'previousSibling'"
        else
            useBinding = true
            "#{anchor[0]}"
    if anchor.length > 1
        anchor[1] = "'#{anchor[1]}'"
    r = "[#{anchor}]"

    if useBinding
        "[function(){return #{r}}, []]"
    else
        r

isVariableBindingId = (id) ->
    ids.hasOwnProperty(id) or id in ['document', 'app']

isPublicBindingId = (id) ->
    id is 'this' or isVariableBindingId(id) or id is 'windowItem' or Renderer[id]?

bindingAttributeToString = (obj) ->
    binding = bindingParser.parse(
        obj.value, isPublicBindingId, obj._parserOptions, bindingParserOpts, isVariableBindingId
    )
    func = "function(){return #{binding.hash}}"

    "[#{func}, [#{binding.connections}]]"

stringify =
    function: (elem) ->
        # arguments
        args = ''
        if args and String(elem.params)
            args += ","
        args += String(elem.params)

        # body
        body = transformByBabel elem.body
        "function(#{args}){#{body}}"
    object: (elem) ->
        json = {}
        children = []
        postfix = ''

        attrToValue = (body) ->
            {value} = body

            if body.name is 'query' and not MODIFIERS_NAMES[body.parent.name]
                if isBinding(body)
                    throw new Error 'query must be a string'
                if value
                    query = ''
                    tmp = body

                    # get value
                    while tmp = tmp.parent
                        for child in tmp.body
                            if child.name is 'query'
                                query = child.value.replace(/'/g, '') + ' ' + query
                                break
                    query = query.trim()

                    # get ids
                    id = ''
                    if body.parent.parent
                        id = ':' + body.parent.id

                    # save query
                    queries[query] = id
            else if Array.isArray(value)
                r = {}
                for child in value
                    r[child.name] = "`#{attrToValue(child)}`"
                r = JSON.stringify r
                postfix += ", \"#{body.name}\": #{r}"
                return false
            else if value?.type is 'object'
                valueCode = stringify.object value
                value = "(#{valueCode})"
            else if body.type is 'function'
                value = stringify.function body
            else if isAnchor(body)
                value = anchorAttributeToString(body)
            else if isBinding(body)
                value = bindingAttributeToString(body)
            value

        unless elem.id
            json.id = elem.id = "i#{fileUid++}"

        for body in elem.body
            switch body.type
                when 'id'
                    json.id = body.value
                when 'attribute'
                    value = attrToValue body
                    if value isnt false
                        json[body.name] = "`#{value}`"
                when 'function'
                    json[body.name] = "`#{stringify.function body}`"
                when 'object'
                    children.push stringify.object(body)
                when 'property'
                    json.properties ?= []
                    json.properties.push body.name
                when 'signal'
                    json.signals ?= []
                    json.signals.push body.name
                else
                    if stringify[body.type]?
                        children.push stringify[body.type](body)
                    else
                        throw "Unexpected object body type '#{body.type}'"

        if not elem.parent and elem.name is 'Class' and not json.target
            json.target = "`windowItem`"

        itemsKeys.push json.id
        visibleId = json.id

        json = JSON.stringify json, null, 4

        if children.length
            postfix += ", children: ["
            for child, i in children
                if i > 0
                    postfix += ", "
                postfix += child
            postfix += "]"

        if postfix
            if json.length is 2
                postfix = postfix.slice(2)
            json = json.slice 0, -1
            json += postfix
            json += "}"

        json = json.replace /"`(.*?)`"/g, (_, val) ->
            JSON.parse "\"#{val}\""

        rendererCtor = Renderer[elem.name.split('.')[0]]
        if rendererCtor?
            declaration = "Renderer.#{elem.name}.New();\n"
        else
            extName = elem.name[0].toLowerCase() + elem.name.slice(1)
            requires[elem.name] ?= "extensions/#{extName}/renderer/#{extName}"
            declaration = "#{elem.name}.New();\n"
        itemsDeclarations += "var #{visibleId} = #{declaration};\n"
        unless MODIFIERS_NAMES[elem.name]
            afterItemCode += "#{visibleId}.onReady.emit();\n"
        "(Renderer.itemUtils.Object.setOpts(#{visibleId}, #{json}), #{visibleId})\n"
    if: (elem) ->
        changes = []
        body = []

        for child in elem.body
            if child.type in ['attribute', 'function']
                changes.push child
            else
                body.push child

        elem.type = 'object'
        elem.name = 'Class'
        elem.body = [{
            type: 'attribute'
            name: 'when'
            value: elem.condition
            parent: elem
            _parserOptions: BINDING_THIS_TO_TARGET_OPTS
        }, {
            type: 'attribute'
            name: 'changes'
            value: changes
            parent: elem
        }, body...]

        stringify.object elem
    select: (elem) ->
        changes = []
        body = []

        for child in elem.body
            if child.type in ['attribute', 'function']
                changes.push child
            else
                body.push child

        elem.type = 'object'
        elem.name = 'Class'
        elem.body = [{
            type: 'attribute'
            name: 'document.query'
            value: elem.query
            parent: elem
        }, {
            type: 'attribute'
            name: 'changes'
            value: changes
            parent: elem
        }, body...]

        stringify.object elem

getIds = (elem, ids={}) ->
    elems = getByTypeDeep elem, 'id', (attr) ->
        ids[attr.value] = attr.parent
    ids

exports = module.exports = (file, filename, opts) ->
    fileUid = 0
    elems = parser file, filename
    codes = {}
    autoInitCodes = []
    requires = {}
    bootstrap = ''
    firstId = null
    allQueries = {}
    beforeFileCode = ''

    for elem, i in elems
        itemsDeclarations = ''
        afterItemCode = ''
        queries = {}
        id = elem.id
        ids = getIds elem
        idsKeys = Object.keys(ids).filter (id) -> !!id
        itemsKeys = []
        code = 'var _c = {};'
        if elem.type is 'code'
            bootstrap += transformByBabel elem.body
            continue
        if typeof stringify[elem.type] isnt 'function'
            console.error "Unexpected block type '#{elem.type}'"
            continue
        elemCode = stringify[elem.type] elem

        objectsIds = idsKeys.slice()
        for id in itemsKeys
            unless utils.has(objectsIds, id)
                objectsIds.push id
        code += itemsDeclarations

        objects = utils.arrayToObject objectsIds,
            (i, elem) -> elem,
            (i, elem) -> "`#{elem}`"

        code += '_c.item = '
        code += elemCode
        code += "_c.objects = #{JSON.stringify(objects).replace(/\"`|`\"/g, '')}\n"
        code += afterItemCode

        if elem.name is 'Class'
            autoInitCodes.push code
        else
            code += 'return _c\n'
            uid = 'n' + fileUid++
            id ||= uid
            if codes[id]?
                id = uid
            codes[id] = code
            firstId ?= id

        # queries
        for query, val of queries
            val = id + val

            if allQueries[query]?
                throw new Error "query '#{query}' is duplicated"
            allQueries[query] = val

    if not codes._main and firstId
        codes._main = link: firstId

    for name, path of requires
        beforeFileCode += "#{name} = require '#{path}'\n"

    bootstrap: bootstrap
    codes: codes
    autoInitCodes: autoInitCodes
    queries: allQueries
    beforeFileCode: beforeFileCode

exports.bundle = bundle exports
