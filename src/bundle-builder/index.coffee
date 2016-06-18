# coffeelint: disable=no_debugger

'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
Module = require 'module'
cp = require 'child_process'

{utils, log, assert} = Neft

release = require './release'
minify = require './minify'
bundle = require './bundle'

module.exports = (opts, callback) ->
    assert.isPlainObject opts
    assert.isString opts.platform
    assert.isString opts.path
    assert.isFunction callback

    unless opts.verbose
        log.enabled = log.ERROR

    logtime = log.time 'Resolve bundle modules'

    # stringify opts into JSON
    processOpts = JSON.stringify opts, (key, val) ->
        if typeof val is 'function'
            {_function: String(val)}
        else
            val
    processOptsBase64 = new Buffer(processOpts).toString('base64')

    # run process file
    running = true
    processPath = pathUtils.join __dirname, './process.js'
    cmd = 'node'
    childProcess = cp.spawn cmd,
        ['--harmony', processPath, processOptsBase64],
        stdio: ['ipc']

    if opts.logProcessStdout
        childProcess.stdout.on 'data', (data) ->
            console.log String(data)

    stderr = ''
    childProcess.stderr.on 'data', (data) ->
        stderr += data

    childProcess.on 'exit', ->
        if running
            running = false
            log.end logtime
            return callback stderr or 'Internal error; no message has been sent'

    childProcess.on 'message', (result) ->
        running = false
        childProcess.send 'terminate'
        log.end logtime
        if stderr
            return callback stderr
        processData = JSON.parse result
        stack = new utils.async.Stack

        stack.add bundle, null, [processData, opts]
        stack.add release, null, [undefined, opts]
        stack.add minify, null, [undefined, opts]

        stack.runAll callback

# support for custom objects used to lookup for modules
moduleNamespaces = []
Module._load = do (_super = Module._load) -> (req, parent, isMain) ->
    for obj in moduleNamespaces
        if obj[req]
            return obj[req]
    _super.call @, req, parent, isMain

module.exports.addModulesNamespace = (obj) ->
    moduleNamespaces.push obj
    return

module.exports.removeModulesNamespace = (obj) ->
    index = moduleNamespaces.indexOf obj
    if index isnt -1
        moduleNamespaces.splice index, 1
    return
