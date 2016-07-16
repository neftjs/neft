'use strict'

pathUtils = require 'path'

module.exports = (nmlParser) -> (file) ->
    data = file.data
    name = file.filename

    # prepare scope name
    parts = name.split '/'
    for part, i in parts
        parts[i] = part[0].toUpperCase() + part.slice(1)

    scopeItemName = parts.join ''
    scopeName = scopeItemName[0].toLowerCase() + scopeItemName.slice(1)

    # bootstrap code
    code = ''

    # scope types
    code += "Renderer = require('neft-renderer')\n"
    code += "onReady = require('neft-signal').create()\n"
    code += '{Image, Device, Navigator, Screen, RotationSensor} = Renderer\n'
    code += 'view = app = null\n'

    # parse NML
    if pathUtils.extname(file.path) not in ['.js', '.nml']
        return new Error 'No js files are not supported'

    data = nmlParser file.data, file.filename

    if data.bootstrap
        code += "`#{data.bootstrap}`\n"

    for fileId, val of data.codes
        if typeof val?.link is 'string'
            code += "exports.#{fileId} = exports.#{val.link}\n"
        else
            code += "exports.#{fileId} = `(function(){ #{val} }())`\n"

    code += 'exports._init = (opts) -> \n'
    code += '   {view, app} = opts\n'
    code += '   onReady.emit app\n'
    for autoInitCode in data.autoInitCodes
        code += "   `(function(){#{autoInitCode}}())`\n"

    file.name = scopeItemName
    file.data = code
    file.queries = data.queries
    file.codes = data.codes
