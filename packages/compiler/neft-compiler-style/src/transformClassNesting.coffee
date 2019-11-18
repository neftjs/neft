{
    SELECT_TYPE, OBJECT_TYPE, CONDITION_TYPE, NESTING_TYPE, ATTRIBUTE_TYPE,
    forEachLeaf
} = require './nmlAst'

OBJECT_TYPES = [SELECT_TYPE, OBJECT_TYPE, CONDITION_TYPE]

getChangesNesting = (elem) ->
    nesting =
        changes: []
        children: []
    elem.body.forEach (child) ->
        if child.type is ATTRIBUTE_TYPE and child.value.type is OBJECT_TYPE
            nesting.changes.push child
            nesting.children.push
                type: OBJECT_TYPE
                id: child.value.id
                body: []
    elem.body = elem.body.filter (child) -> child not in nesting.changes
    nesting

getChildrenNesting = (elem) ->
    nesting =
        children: []
    elem.body.forEach (child) ->
        if child.type in OBJECT_TYPES
            nesting.children.push child
    elem.body = elem.body.filter (child) -> child not in nesting.children
    nesting

addNesting = (elem, types) ->
    body = []
    nesting =
        changes: types.changes.changes
        children: [types.changes.children..., types.children.children...]
    for type of nesting when nesting[type].length > 0
        body.push
            type: ATTRIBUTE_TYPE
            name: type
            value: nesting[type]

    if body.length > 0
        elem.body.push
            type: NESTING_TYPE
            body: body

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
            changes = getChangesNesting elem
            children = getChildrenNesting elem
            addNesting elem, {changes, children}
    return
