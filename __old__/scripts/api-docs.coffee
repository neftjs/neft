'use strict'

utils = require 'src/utils'
fs = require 'fs-extra'
pathUtils = require 'path'
files = require './api-docs/files'

INPUT = './src/**/*.litcoffee'
REPO = 'docs'

stack = new utils.async.Stack
parsedFiles = null

# parse literate files
stack.add ((callback) ->
    fs.emptyDirSync pathUtils.join REPO, 'api'
    files.parseAll INPUT, REPO, (err, _files) ->
        parsedFiles = _files
        callback err
), null

stack.runAll (err) ->
    if err
        throw new Error err

    # save files into docs
    files.saveFiles parsedFiles, (err) ->
        if err
            throw err
