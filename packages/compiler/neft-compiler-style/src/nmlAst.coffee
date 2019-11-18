'use strict'

exports.ID_TYPE = 'id'
exports.ATTRIBUTE_TYPE = 'attribute'
exports.FUNCTION_TYPE = 'function'
exports.OBJECT_TYPE = 'object'
exports.PROPERTY_TYPE = 'property'
exports.SIGNAL_TYPE = 'signal'
exports.CONDITION_TYPE = 'condition'
exports.SELECT_TYPE = 'select'
exports.NESTING_TYPE = 'nesting'

forEachLeaf = ({
    ast,
    onlyType,
    omitTypes,
    omitDeepTypes,
    includeGiven = false,
    includeValues = false,
    deeply = false,
    parent = null,
}, callback) ->
    unless callback
        result = []
        callback = (elem) -> result.push elem
    config =
        ast: ast.value
        onlyType: onlyType
        omitTypes: omitTypes
        omitDeepTypes: omitDeepTypes
        deeply: deeply
        includeValues: includeValues
    isOk = (type) ->
        ok = not onlyType or type is onlyType
        ok and= not omitTypes or not omitTypes.has(type)
        ok
    if includeGiven
        if isOk(ast.type)
            callback ast, parent
    if includeValues and ast.value?.type
        forEachLeaf Object.assign({}, config, {
            ast: ast.value
            includeGiven: true
            includeValues: includeValues and deeply
            parent: ast
        }), callback
    if includeValues and Array.isArray(ast.value)
        for elem in ast.value
            forEachLeaf Object.assign({}, config, {
                ast:
                    value: elem
                parent: ast
            }), callback
    if deeply
        ast.body?.forEach (elem) ->
            if not omitDeepTypes or not omitDeepTypes.has(elem.type)
                forEachLeaf Object.assign({}, config, {
                    ast: elem
                    includeGiven: true
                    parent: ast
                }), callback
    else
        ast.body?.forEach (elem) ->
            if isOk(elem.type)
                callback elem, ast
    result

exports.forEachLeaf = forEachLeaf
