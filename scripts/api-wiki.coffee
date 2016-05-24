'use strict'

utils = require 'src/utils'
fs = require 'fs'
files = require './api-wiki/files'
git =  require './api-wiki/git'

INPUT = './src/**/*.litcoffee'
WIKI_URL = process.env.npm_package_config_wiki_url

stack = new utils.async.Stack
repo = ''
parsedFiles = null

# clone wiki git repo
stack.add ((callback) -> repo = git.clone WIKI_URL, callback), null

# parse literate files
stack.add ((callback) ->
    files.parseAll INPUT, repo, (err, _files) ->
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
        git.push repo, ->
