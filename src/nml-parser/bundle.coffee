'use strict'

pathUtils = require 'path'

module.exports = (nmlParser) -> (file) ->
    data = file.data
    name = file.filename

    # prepare scope name
    parts = name.split '/'
    for part, i in parts when part
        parts[i] = part[0].toUpperCase() + part.slice(1)

    scopeItemName = parts.join ''

    # bootstrap code
    code = ''

    # scope types
    code += '{Renderer} = Neft\n'
    code += '{Image, Device, Navigator, Screen, RotationSensor} = Renderer\n'
    code += 'view = null\n'

    # parse NML
    if pathUtils.extname(file.path) not in ['.js', '.nml']
        return new Error 'No js files are not supported'

    data = nmlParser file.data, file.filename
    code += data.beforeFileCode

    if data.bootstrap
        code += "`#{data.bootstrap}`\n"

    for fileId, val of data.codes
        if typeof val?.link is 'string'
            code += "exports.#{fileId} = exports.#{val.link}\n"
        else
            code += "exports.#{fileId} = `function(__opts){ var document = __opts && __opts.document; #{val} }`\n"

    code += 'exports._init = (opts) -> \n'
    code += '   {view} = opts\n'
    for autoInitCode in data.autoInitCodes
        code += "   `(function(){#{autoInitCode}}())`\n"

    code += "exports._queries = #{JSON.stringify(data.queries)}\n"

    if mainLink = data.codes._main?.link
        code += "exports._mainLink = '#{mainLink}'\n"

    file.name = scopeItemName
    file.data = code
    file.queries = data.queries
    file.codes = data.codes
