'use strict'

utils = require '@neft/core/src/util'
Renderer = require '@neft/core/src/renderer'
nmlAst = require './nmlAst'

class ImportsFinder
    constructor: (@objects) ->
        @usedTypes = @getUsedTypes()

    getUsedTypes: ->
        used =
            __proto__: null
            Class: true
            Device: true
            Navigator: true
            Screen: true
        for object in @objects
            nmlAst.forEachLeaf
                ast: object, onlyType: nmlAst.OBJECT_TYPE, includeGiven: true,
                includeValues: true, deeply: true,
                (elem) -> used[elem.name] = true
        Object.keys used

    getDefaultImports: ->
        result = []
        for key in @usedTypes
            if Renderer[key]?
                result.push
                    name: key
                    ref: "Renderer.#{key}"
        result

    validateNoMissedImports: (importedList) ->
        imported = utils.arrayToObject importedList,
            (index, elem) -> elem.name.split('.')[0],
            -> true
        for type in @usedTypes
            typeNs = type.split('.')[0]
            unless imported[typeNs]
                throw new Error "Not imported type '#{typeNs}'"
        return

    findAll: ->
        result = @getDefaultImports()
        @validateNoMissedImports result
        result

exports.getImports = ({objects}) ->
    new ImportsFinder(objects).findAll()
