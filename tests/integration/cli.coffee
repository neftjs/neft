'use strict'

os = require 'os'
cp = require 'child_process'
pathUtils = require 'path'
fs = require 'fs-extra'
appManager = require 'tests/utils/appManager'

{utils, assert, unit, log} = Neft
{describe, it} = unit

log = log.scope 'cli'
isWin32 = os.platform() is 'win32'

NEFT_BIN_PATH = pathUtils.join(fs.realpathSync('./'), 'bin/neft.js')

forkSilent = (path, args, options, callback, onChild) ->
    options = utils.mergeAll {}, options, silent: true
    appManager.runCustomCliTask (innerCallback) ->
        child = cp.fork path, args, options
        stdout = ''
        child.stdout.on 'data', (data) ->
            stdout += data
        stderr = ''
        child.stderr.on 'data', (data) ->
            stderr += data
        child.on 'exit', (code) ->
            setImmediate ->
                innerCallback null
                callback code, stdout, stderr
        onChild? child

createApp = (callback) ->
    path = pathUtils.join os.tmpdir(), 'neft-project'
    fs.removeSync path
    forkSilent NEFT_BIN_PATH, ['create', path], null, callback
    path

describe 'CLI', ->
    describe 'neft create', ->
        it 'creates new project at the given path', (done) ->
            createApp (err, stdout, stderr) ->
                if not err and not stderr
                    log stdout
                    assert.match stdout, /Project created/
                done err or stderr

    describe 'neft build', ->
        buildApp = (target, callback) ->
            path = createApp (err, _, stderr) ->
                forkSilent NEFT_BIN_PATH, ['build', target], cwd: path, callback

        describe 'node', ->
            BUNDLE_FILE = 'build/app-node-develop.js'
            it 'creates bundle', (done) ->
                path = buildApp 'node', (err, _, stderr) ->
                    appPath = pathUtils.join path, BUNDLE_FILE
                    assert.ok fs.existsSync appPath
                    done err or stderr

        describe 'browser', ->
            BUNDLE_FILE = 'build/app-browser-develop.js'
            it 'creates bundle', (done) ->
                path = buildApp 'browser', (err, _, stderr) ->
                    appPath = pathUtils.join path, BUNDLE_FILE
                    assert.ok fs.existsSync appPath
                    done err or stderr

    describe 'neft run', ->
        describe 'node', ->
            it 'starts node server', (done) ->
                path = createApp (err, _, stderr) ->
                    forkSilent(
                        NEFT_BIN_PATH,
                        ['run', 'node'],
                        cwd: path,
                        (err, _, stderr) ->
                            done err or stderr
                        (child) ->
                            child.stdout.on 'data', (msg) ->
                                if utils.has(String(msg), 'Start as')
                                    child.send 'terminate'
                                    setTimeout done
                    )
