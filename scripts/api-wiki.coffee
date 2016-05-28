'use strict'

utils = require 'src/utils'
fs = require 'fs'
files = require './api-wiki/files'
git =  require './api-wiki/git'

INPUT = './src/**/*.litcoffee'
REPO = 'wiki'

stack = new utils.async.Stack
parsedFiles = null

# parse literate files
stack.add ((callback) ->
    files.parseAll INPUT, REPO, (err, _files) ->
        parsedFiles = _files
        callback err
), null

stack.runAll (err) ->
    if err
        throw new Error err

    # save files into wiki
    files.saveFiles parsedFiles, (err) ->
        if err
            throw err

        # push changes into wiki git repo
        git.push ->
