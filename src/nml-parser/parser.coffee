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
        line = error.location.start.line

        msg = '\n'
        for i in [error.location.start.line..error.location.end.line]
            msg += lines[i] + '\n'
        msg += """
            \nLine #{error.location.start.line}, \
            column #{error.location.start.column}: \
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
