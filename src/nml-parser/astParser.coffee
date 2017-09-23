'use strict'

PEG = require 'pegjs'
log = require 'src/log'
assert = require 'src/assert'
grammar = require './grammar.pegjs'
parser = PEG.generate grammar

log = log.scope 'NML'

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

exports.parse = (nml) ->
    assert.isString nml, "NML to parse needs to be a string, but '#{nml}' given"

    # parse and report error
    warnings = []
    try
        result = parser.parse nml,
            warnings: warnings,
            ids: {}
            lastUid: 0
    catch error
        throw Error getErrorMessage nml, error

    # log warnings
    for warning in warnings
        log.warn warning.message

    result
