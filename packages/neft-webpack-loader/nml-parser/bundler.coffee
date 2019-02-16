'use strict'

utils = require '@neft/core/src/util'
pathUtils = require 'path'
fs = require 'fs'

PADDING = '  '

getImportValue = (cfg) ->
    if cfg.ref
        return cfg.ref
    if cfg.path
        return "require(\"#{cfg.path}\")"
    throw new Error "Unsupported import config object '#{cfg}'"

getImports = (imports) ->
    result = ""
    for importConfig in imports
        value = getImportValue importConfig
        result += "const #{importConfig.name} = #{value}\n"
    result

getConstants = (constants) ->
    result = ""
    for constant in constants
        result += "const #{constant.name} = #{constant.value}\n"
    result

getObjectsCode = (objects, objectCodes) ->
    result = ""
    for objectCode, i in objectCodes
        code = PADDING + objectCode.code.replace /\n/g, '\n' + PADDING
        if objects[i].type is 'select'
            result += "exports.selects.push(() => {\n#{code}\n})\n"
        else
            result += "exports.#{objectCode.id} = () => {\n#{code}\n}\n"
    result

getFileMeta = (path) ->
    relPath = path
    if pathUtils.isAbsolute(path)
        relPath = pathUtils.relative fs.realpathSync('.'), path
    "exports._path = \"#{relPath}\"\n"

exports.bundle = ({path, imports, constants, objects, objectCodes, queries}) ->
    hasSelect = objects.find (obj) -> obj.type is 'select'

    result = '''
    const exports = {}\n
    const Renderer = require('@neft/core/src/renderer')
    const _RendererObject = Renderer.itemUtils.Object\n
    '''
    result += getImports imports
    result += getConstants constants
    if hasSelect
        result += 'exports.selects = []\n'
    result += getObjectsCode objects, objectCodes
    if path
        result += getFileMeta path
    result += 'return exports'
    result
