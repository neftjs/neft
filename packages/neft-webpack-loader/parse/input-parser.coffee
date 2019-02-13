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

    str = ''
    hash = ''
    connections = []
    isString = isBlock = false
    blocks = 0
    innerBlocks = 0
    i = 0
    n = text.length
    while i < n
        charStr = text[i]
        if charStr is '{'
            isBlock = true
            blocks += 1
            if str isnt '' or blocks > 1
                hash += '"'+str+'" + '
            str = ''
        else if charStr is '{'
            innerBlocks += 1
            str += charStr
        else if charStr is '}'
            if innerBlocks > 0
                innerBlocks -= 1
                str += charStr
            else if isBlock
                parsed = bindingParser.parse str, isPublicId, PARSER_FLAGS, PARSER_OPTS
                hash += "(#{parsed.hash}) + "
                connections.push eval(parsed.connections)
                str = ''
            else
                log.error "Interpolated string parse error: '#{text}'"
                return
        else
            str += charStr
        i++

    if str is ''
        hash = hash.slice 0, -3
    else
        hash += '"'+str+'"'

    funcBody = "return #{hash}"

    try
        new Function funcBody
    catch err
        log.error "Can't parse string literal:\n#{text}\n#{err.message}"
        return null

    body: funcBody
    connections: connections
