'use strict'

utils = require '@neft/core/src/util'
log = require '@neft/core/src/log'
bindingParser = require '../binding-parser'

PARSER_FLAGS = bindingParser.BINDING_THIS_TO_SELF_OPTS
PARSER_OPTS =
    shouldPrefixByThis: (key) ->
        key not in ['this', 'global', 'Neft', 'typeof', 'true', 'false', 'null', 'undefined'] and not (key of global)

isPublicId = (id) ->
    id in ['this']

shouldBeUpdatedOnCreate = (connection) ->
    [key] = connection
    if Array.isArray(key)
        shouldBeUpdatedOnCreate key
    else
        not (key in ['this', 'context'])

module.exports = (text, scopeProps) ->
    text = text.replace(/[\t\n]/gm, '')
    func = ""

    str = ''
    func = ''
    isString = isBlock = false
    blocks = 0
    innerBlocks = 0
    i = 0
    n = text.length
    while i < n
        charStr = text[i]
        if charStr is '$' and text[i+1] is '{'
            isBlock = true
            blocks += 1
            if str isnt '' or blocks > 1
                func += '"'+str+'" + '
            str = ''
            i++
        else if charStr is '{'
            innerBlocks += 1
            str += charStr
        else if charStr is '}'
            if innerBlocks > 0
                innerBlocks -= 1
                str += charStr
            else if isBlock
                func += "(#{str}) + "
                str = ''
            else
                log.error "Interpolated string parse error: '#{text}'"
                return
        else
            str += charStr
        i++

    if str is ''
        func = func.slice 0, -3
    else
        func += '"'+str+'"'

    parsed = bindingParser.parse func, isPublicId, PARSER_FLAGS, PARSER_OPTS

    funcBody = "return #{parsed.hash}"

    try
        new Function funcBody
    catch err
        log.error "Can't parse string literal:\n#{text}\n#{err.message}"

    connections = eval "[#{parsed.connections}]"

    func: null
    tree: null
    body: funcBody
    connections: connections
