'use strict'

childProcess = require 'child_process'
pathUtils = require 'path'
fs = require 'fs-extra'
os = require 'os'

{utils} = Neft
{NODE_CP_EXEC_PREFIX} = process.env

describe "'neft test' command", ->
    beforeEach ->
        @name = utils.uid()
        @path = pathUtils.join os.tmpdir(), @name
        childProcess.execSync "neft create #{@path}"

    it 'runs test files', (callback) ->
        logMsg = utils.uid()
        testFile = "console.log('#{logMsg}');"
        fs.outputFileSync pathUtils.join(@path, '/tests/test1.js'), testFile
        cmd = NODE_CP_EXEC_PREFIX + 'neft test'
        childProcess.exec cmd, cwd: @path, (err, stdout, stderr) ->
            if not stdout or stdout.toString().indexOf(logMsg) is -1
                return callback new Error 'Test file not logged\n' + stderr
            callback err
