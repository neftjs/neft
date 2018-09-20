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

getObjectsCode = (objects) ->
    result = ""
    for object in objects
        code = PADDING + object.code.replace /\n/g, '\n' + PADDING
        result += "exports.#{object.id} = () => {\n#{code}\n}\n"
    result

getFileMeta = (path) ->
    relPath = path
    if pathUtils.isAbsolute(path)
        relPath = pathUtils.relative fs.realpathSync('.'), path
    "exports._path = \"#{relPath}\"\n"

exports.bundle = ({path, imports, constants, objects, objectCodes, queries}) ->
    result = '''
    const exports = {}\n
    const Renderer = require('@neft/core/src/renderer')
    const _RendererObject = Renderer.itemUtils.Object\n
    '''
    result += getImports imports
    result += getConstants constants
    result += getObjectsCode objectCodes
    if path
        result += getFileMeta path
    result += 'return exports'
    result
