'use strict'

glob = require 'glob'
fs = require 'fs'
cp = require 'child_process'
pathUtils = require 'path'

{unit, assert} = Neft
{describe, it} = unit

NEFT_BIN_PATH = pathUtils.join(fs.realpathSync('./'), 'bin/neft.js')
NEFT_UNIT_BIN_PATH = pathUtils.join(fs.realpathSync('./'), 'bin/neft-unit.js')

examples = glob.sync './examples/*'

fork = (path, args, options, callback) ->
    child = cp.fork path, args, options
    child.on 'exit', callback

buildApp = (absPath, callback) ->
    cp.execSync "cd #{absPath} && npm install"
    fork NEFT_BIN_PATH, ['build', 'node'], cwd: absPath, (code) ->
        callback if code is 1 then new Error else null

testApp = (absPath, callback) ->
    fork NEFT_UNIT_BIN_PATH, ['tests/**/*.js'], cwd: absPath, (code) ->
        callback if code is 1 then new Error else null

for example in examples
    absPath = fs.realpathSync example
    describe example, ->
        it 'should pass tests', (callback) ->
            buildApp absPath, (err) ->
                if err
                    return callback err
                testApp absPath, callback
