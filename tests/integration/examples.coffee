'use strict'

glob = require 'glob'
fs = require 'fs-extra'
cp = require 'child_process'
pathUtils = require 'path'
os = require 'os'
sauce = require 'tests/utils/sauce'
appManager = require 'tests/utils/appManager'

{unit, assert, utils, log} = Neft
{describe, it} = unit

NEFT_UNIT_BIN_PATH = pathUtils.join(fs.realpathSync('./'), 'bin/neft-unit.js')

fork = (path, args, options, callback) ->
    child = cp.fork path, args, options
    child.on 'exit', callback

testApp = (absPath, callback) ->
    appManager.runCustomCliTask (innerCallback) ->
        fork NEFT_UNIT_BIN_PATH, ['tests/**/*.js'], cwd: absPath, (code) ->
            callback if code is 1 then new Error else null
            innerCallback null

glob.sync('./examples/*').forEach (example) ->
    absPath = fs.realpathSync example
    unless fs.existsSync(pathUtils.join(absPath, 'tests'))
        return
    describe example, ->
        describe 'should pass tests on', ->
            appManager.buildApp absPath, 'node'

            it 'Node', do (absPath) -> (callback) ->
                appManager.onAppBuilt absPath, 'node', (err) ->
                    if err then return callback err
                    testApp absPath, callback

            sauce.createDefaultTestCases absPath
