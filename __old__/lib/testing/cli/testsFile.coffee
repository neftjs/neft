'use strict'

glob = require 'glob'
pathUtils = require 'path'
fs = require 'fs-extra'
cliUtils = require 'cli/utils'
slash = require 'slash'

INIT_FILES =
    './tests/init.js': true
    './tests/init.coffee': true
TESTS_FILE_PATH = './build/tests.js'

exports.saveBuildTestsFile = (target, callback) ->
    indexFile = ''

    glob './tests/**/*.?(js|coffee)', ignore: './tests/node_modules/**/*', (err, files) ->
        files.sort (a, b) ->
            if INIT_FILES[a] then -1 else 0

        if err
            return callback err
        for file in files
            unless cliUtils.isPlatformFilePath(target, file)
                continue
            filePath = slash pathUtils.join '../', file
            indexFile += "require('#{filePath}');\n"
        fs.outputFile TESTS_FILE_PATH, indexFile, callback
