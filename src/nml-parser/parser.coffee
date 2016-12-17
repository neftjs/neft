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
        line = error.line - 1

        msg = '\n'
        msg += lines[line - 1] + '\n' if error.line > 1
        msg += lines[line] + '\n' if line isnt lines.length
        msg += lines[line + 1] + '\n' if line < lines.length
        msg += "\nLine #{error.line}, column #{error.column}: #{error.message}\n"
        if filename
            msg += "at #{filename}\n"
        msg

    # parse and report error
    try
        result = parser.parse(file)
    catch error
        throw Error getErrorMessage error

    # log warnings
    for warning in result.warnings
        log.warn getErrorMessage warning

    result
