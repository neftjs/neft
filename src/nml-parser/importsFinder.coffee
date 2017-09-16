'use strict'

utils = require 'src/utils'
Renderer = require 'src/renderer'
nmlAst = require './nmlAst'

class ImportsFinder
    constructor: (@imports, @objects) ->
        @usedTypes = @getUsedTypes()

    getUsedTypes: ->
        used =
            __proto__: null
            Class: true
        for object in @objects
            nmlAst.forEachLeaf
                ast: object, onlyType: nmlAst.OBJECT_TYPE, includeGiven: true,
                includeValues: true, deeply: true,
                (elem) -> used[elem.name] = true
        Object.keys used

    getCustomImports: ->
        result = []
        for importPath in @imports
            switch importPath[0]
                when 'Styles'
                    name = importPath[importPath.length - 1]
                    path = importPath[1...].join '/'
                    result.push
                        name: name
                        value: "require \"styles/#{path}\""
                when 'Modules'
                    if importPath.length > 2
                        throw new Error "Cannot import '#{importPath.join '.'}' (too much elements)"
                    name = importPath[importPath.length - 1]
                    path = "neft-" + utils.camelToKebab importPath[1...].join '/'
                    extName = name[0].toLowerCase() + name.slice(1)
                    result.push
                        name: name
                        value: "require \"node-modules/#{path}/renderer/#{extName}\""
                when 'Neft'
                    if importPath[1] isnt 'Extensions'
                        throw new Error """
                            Expected 'Neft.Extensions', but given '#{importPath[...2].join '.'}'
                        """
                    if importPath.length > 3
                        throw new Error "Cannot import '#{importPath.join '.'}' (too much elements)"
                    name = importPath[importPath.length - 1]
                    extName = name[0].toLowerCase() + name.slice(1)
                    result.push
                        name: name
                        value: "require \"extensions/#{extName}/renderer/#{extName}\""
                when 'Extensions'
                    if importPath.length > 2
                        throw new Error "Cannot import '#{importPath.join '.'}' (too much elements)"
                    name = importPath[importPath.length - 1]
                    extName = name[0].toLowerCase() + name.slice(1)
                    result.push
                        name: name
                        value: "require \"extensions/#{extName}/renderer/#{extName}\""
                else
                    throw new Error """
                        Unknown NML import namespace '#{importPath[0]}'; \
                        expected Neft.Extensions, Styles, Extensions or Modules.
                    """
        result

    getDefaultImports: ->
        result = []
        for key in @usedTypes
            if Renderer[key]?
                result.push
                    name: key
                    value: "Neft.Renderer.#{key}"
        result

    validateNoMissedImports: (importedList) ->
        imported = utils.arrayToObject importedList,
            (index, elem) -> elem.name.split('.')[0],
            -> true
        for type in @usedTypes
            unless imported[type]
                throw new Error "Not imported type '#{type}'"
        return

    findAll: ->
        result = @getCustomImports()
        result.push @getDefaultImports()...
        @validateNoMissedImports result
        result

exports.getImports = ({imports, objects}) ->
    new ImportsFinder(imports, objects).findAll()
