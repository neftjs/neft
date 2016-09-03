# coffeelint: disable=no_debugger

'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
Module = require 'module'

process = require './process'
bundle = require './bundle'
release = require './release'
minify = require './minify'

module.exports = (opts, callback) ->
    opts.path = pathUtils.resolve fs.realpathSync('.'), opts.path
    process opts, (err, data) ->
        return callback err if err?
        bundle data, opts, (err, file) ->
            return callback err if err?
            release file, opts, (err, file) ->
                return callback err if err?
                minify file, opts, callback
    return
