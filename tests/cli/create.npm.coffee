'use strict'

childProcess = require 'child_process'
pathUtils = require 'path'
fs = require 'fs'
os = require 'os'

{utils} = Neft
{NODE_CP_EXEC_PREFIX} = process.env

describe "'neft create' command", ->
    it 'creates folder with given name', (callback) ->
        name = utils.uid()
        path = pathUtils.join os.tmpdir(), name
        childProcess.exec NODE_CP_EXEC_PREFIX + "neft create #{path}", (err1) ->
            fs.exists path, (exists) ->
                callback err1 or not exists
