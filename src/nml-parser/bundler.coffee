'use strict'

utils = require 'src/utils'

GLOBAL_VARIABLES = ['windowItem']
OBJECT_VARIABLES = ['document']
PADDING = '    '

getImports = (imports) ->
    result = ""
    for importConfig in imports
        result += "#{importConfig.name} = #{importConfig.value}\n"
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

getQueries = (queries) ->
    "exports._queries = #{JSON.stringify queries}"

exports.bundle = ({imports, constants, objects, objectCodes, queries}) ->
    result = '''
    _RendererObject = Neft.Renderer.itemUtils.Object\n
    '''
    result += getImports imports
    result += getConstants constants
    result += getGlobalVariablesCode()
    result += getObjectsCode objectCodes
    result += getInitFunctionCode()
    result += getMainObject objectCodes
    result += getQueries queries
    result
