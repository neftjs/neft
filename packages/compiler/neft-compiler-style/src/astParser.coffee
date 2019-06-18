'use strict'

fs = require 'fs'
PEG = require 'pegjs'

grammar = fs.readFileSync(__dirname + '/grammar.pegjs', 'utf-8')
pegParser = PEG.generate grammar

getErrorMessage = (nml, error) ->
    unless error.location
        return error

    lines = nml.split '\n'
    {start, end} = error.location

    msg = '\n'
    for i in [start.line - 1..end.line - 1]
        msg += '    ' + lines[i] + '\n'
    msg += """
        Line: #{start.line}\n
        Column: #{start.column}\n
        #{error.message}
    """
    msg

exports.parse = (nml, parser) ->
    # parse and report error
    warnings = []
    try
        result = pegParser.parse nml,
            warnings: warnings,
            ids: {}
            lastUid: 0
    catch error
        throw Error getErrorMessage nml, error

    # log warnings
    for warning in warnings
        parser.warning warning.message

    result
