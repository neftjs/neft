'use strict'

utils = require 'src/utils'
pathUtils = require 'path'
fs = require 'fs'

GLOBAL_VARIABLES = ['windowItem']
OBJECT_VARIABLES = ['document']
PADDING = '    '

getImportValue = (cfg) ->
    if cfg.ref
        return cfg.ref
    if cfg.path
        return "require \"#{cfg.path}\""
    throw new Error "Unsupported import config object '#{cfg}'"

getImports = (imports) ->
    result = ""
    for importConfig in imports
        value = getImportValue importConfig
        result += "#{importConfig.name} = #{value}\n"
    result

getConstants = (constants) ->
    result = ""
    for constant in constants
        result += "#{constant.name} = `#{constant.value}`\n"
    result

getGlobalVariablesCode = ->
    result = ""
    for variable in GLOBAL_VARIABLES
        result += "#{variable} = undefined\n"
    result

getObjectsCode = (objects) ->
    result = ""
    for object in objects
        code = PADDING + object.code.replace /\n/g, '\n' + PADDING
        result += "exports.#{object.id} = ({#{OBJECT_VARIABLES}}) ->\n#{code}\n"
    result

getInitFunctionCode = ->
    result = 'exports._init = (opts) ->\n'
    for variable in GLOBAL_VARIABLES
        result += "#{PADDING}#{variable} = opts.#{variable}\n"
    result += "#{PADDING}return\n"
    result

getMainObject = (objects) ->
    if utils.isEmpty(objects)
        return ''
    """
    exports._main = exports.#{objects[0].id}
    exports._mainLink = '#{objects[0].id}'
    exports.New = () -> exports._main({}).item\n
    """

getQueriesDict = (queries) ->
    "exports._queries = #{JSON.stringify queries}\n"

getImportsDict = (imports) ->
    paths = {}
    for {path} in imports
        paths[path] = true if path?
    "exports._imports = #{JSON.stringify paths}\n"

getFileMeta = (path) ->
    relPath = path
    if pathUtils.isAbsolute(path)
        relPath = pathUtils.relative fs.realpathSync('.'), path
    "exports._path = \"#{relPath}\"\n"

exports.bundle = ({path, imports, constants, objects, objectCodes, queries}) ->
    result = '''
    _RendererObject = Neft.Renderer.itemUtils.Object\n
    '''
    result += getImports imports
    result += getConstants constants
    result += getGlobalVariablesCode()
    result += getObjectsCode objectCodes
    result += getInitFunctionCode()
    result += getMainObject objectCodes
    result += getQueriesDict queries
    result += getImportsDict imports
    if path
        result += getFileMeta path
    result
