{ SELECT_TYPE, OBJECT_TYPE, CONDITION_TYPE, NESTING_TYPE, forEachLeaf } = require './nmlAst'

OBJECT_TYPES = [SELECT_TYPE, OBJECT_TYPE, CONDITION_TYPE]

addNesting = (elem) ->
    nesting = []
    elem.body.forEach (child) ->
        if child.type in OBJECT_TYPES
            nesting.push child
    elem.body = elem.body.filter (child) -> child.type not in OBJECT_TYPES
    if nesting.length > 0
        elem.body.push
            type: NESTING_TYPE
            body: nesting
    return

exports.transform = (ast) ->
    forEachLeaf
        ast: ast
        includeGiven: true
        includeValues: true
        deeply: true
    , (elem, parent) ->
        nest = elem.type is SELECT_TYPE
        nest or= elem.type is CONDITION_TYPE
        nest or= elem.type is OBJECT_TYPE and elem.name is 'Class'
        if nest
            addNesting elem
    return
