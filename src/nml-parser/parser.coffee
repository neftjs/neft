'use strict'

fs = require 'fs'
pathUtils = require 'path'
PEG = require 'pegjs'
grammar = require './grammar.pegjs'
log = require 'src/log'
parser = PEG.buildParser grammar,
    optimize: 'speed'

log = log.scope 'NML'

module.exports = (file, filename) ->
    getErrorMessage = (error) ->
        lines = file.split '\n'
        {start, end} = error.location

        msg = 'Code: '
        for i in [start.line - 1..end.line - 1]
            msg += lines[i] + '\n'
        msg += """
            Error: \
            Line #{start.line}, \
            column #{start.column}: \
            #{error.message}
        """
        msg

    # parse and report error
    try
        result = parser.parse(file)
    catch error
        throw Error getErrorMessage error

    # log warnings
    for warning in result.warnings
        log.warn warning.message

    result
