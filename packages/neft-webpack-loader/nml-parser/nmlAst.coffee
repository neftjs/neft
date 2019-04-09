'use strict'

exports.ID_TYPE = 'id'
exports.ATTRIBUTE_TYPE = 'attribute'
exports.FUNCTION_TYPE = 'function'
exports.OBJECT_TYPE = 'object'
exports.PROPERTY_TYPE = 'property'
exports.SIGNAL_TYPE = 'signal'
exports.CONDITION_TYPE = 'condition'
exports.SELECT_TYPE = 'select'

exports.forEachLeaf = ({
    ast,
    onlyType,
    includeGiven = false,
    includeValues = false,
    deeply = false,
    parent = null,
}, callback) ->
    unless callback
        result = []
        callback = (elem) -> result.push elem
    if includeGiven
        if not onlyType or ast.type is onlyType
            callback ast, parent
    if includeValues and ast.value?.type
        exports.forEachLeaf
            ast: ast.value, onlyType: onlyType, includeGiven: true,
            includeValues: includeValues and deeply,
            deeply: deeply, parent: ast, callback
    if deeply
        ast.body?.forEach (elem) ->
            exports.forEachLeaf
                ast: elem, onlyType: onlyType, includeGiven: true,
                includeValues: includeValues,
                deeply: deeply, parent: ast,
                callback
    else
        ast.body?.forEach (elem) ->
            if not onlyType or elem.type is onlyType
                callback elem, ast
    result
