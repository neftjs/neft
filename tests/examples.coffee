# coffeelint: disable=no_debugger

'use strict'

glob = require 'glob'
fs = require 'fs'
cp = require 'child_process'
pathUtils = require 'path'
sauce = require './sauce'

{unit, assert, utils} = Neft
{describe, it} = unit

APP_URL = 'localhost:3000'
NEFT_BIN_PATH = pathUtils.join(fs.realpathSync('./'), 'bin/neft.js')
NEFT_UNIT_BIN_PATH = pathUtils.join(fs.realpathSync('./'), 'bin/neft-unit.js')

examples = glob.sync './examples/*'

fork = (path, args, options, callback) ->
    child = cp.fork path, args, options
    child.on 'exit', callback

buildApp = (absPath, args, callback) ->
    cp.execSync "cd #{absPath} && npm install"
    fork NEFT_BIN_PATH, ['build', args...], cwd: absPath, (code) ->
        callback if code is 1 then new Error else null

testApp = (absPath, callback) ->
    fork NEFT_UNIT_BIN_PATH, ['tests/**/*.js'], cwd: absPath, (code) ->
        callback if code is 1 then new Error else null

runApp = (absPath, callback) ->
    options = utils.mergeAll {}, options, silent: true
    child = cp.fork NEFT_BIN_PATH, ['run', 'node'], cwd: absPath, silent: true
    stdout = ''
    callbackCalled = false
    child.stdout.on 'data', (data) ->
        stdout += data
        console.log "SERVER: #{data}"
        if not callbackCalled and utils.has(stdout, 'Start as')
            callbackCalled = true
            callback null
    stderr = ''
    child.stderr.on 'data', (data) ->
        stderr += data
        console.log "SERVER: #{data}"
    child.on 'exit', (code) ->
        console.log "SERVER EXIT WITH CODE #{code}"
        unless callbackCalled
            callbackCalled = true
            callback code, stdout, stderr
    child

testSauceApp = (driver, callback) ->
    desired =
        name: 'Neft'
        tags: ['examples']
        browserName: 'chrome'
        platform: 'Windows 7'
        version: '48.0'
        'tunnel-identifier': process.env.TRAVIS_JOB_NUMBER

    callbackCalled = false

    stack = new utils.async.Stack

    run = (func, args, onResult = utils.NOP) ->
        if typeof args is 'function'
            callback = args
            args = null

        stack.add func, driver, args
        if callback
            stack.add (result, callback) ->
                try
                    onResult result
                catch err
                    return callback err
                callback()

        return

    run driver.init, [desired]
    run driver.get, [APP_URL]

    checkTestsFinished = ->
        run driver.execute, ['''
            if (neftUnitLogItem.$.running) {
                return { running: true };
            } else {
                return {
                    running: false,
                    success: neftUnitLogItem.$.success,
                    logs: neftUnitLogItem.text
                };
            }
        '''],
        ({running, success, logs}) ->
            if running
                return checkTestsFinished()
            console.log logs
            unless success
                throw new Error 'Client tests failed'

    checkTestsFinished()

    stack.runAll (err) ->
        driver.sauceJobStatus not err, ->
            callback err

    return

for example in examples
    absPath = fs.realpathSync example
    describe example, ->
        it 'should pass tests', (callback) ->
            buildApp absPath, ['node'], (err) ->
                if err
                    return callback err
                testApp absPath, callback

        if process.env.NEFT_TEST_BROWSER
            it 'should pass tests on browser', (callback) ->
                stack = new utils.async.Stack
                appChild = null
                sauceProcess = null
                sauceDriver = null

                sauceConnectAndSave = (callback) ->
                    sauce.connect (err, process, driver) ->
                        sauceProcess = process
                        sauceDriver = driver
                        callback err, driver

                runAndSaveApp = (absPath, callback) ->
                    appChild = runApp absPath, callback

                stack.add buildApp, null, [absPath, ['browser', '--with-tests']]
                stack.add sauceConnectAndSave
                stack.add runAndSaveApp, null, [absPath]
                stack.add (callback) ->
                    testSauceApp sauceDriver, callback

                stack.runAll (err1) ->
                    appChild?.send 'terminate'
                    closeStack = new utils.async.Stack
                    if sauceDriver?
                        closeStack.add sauceDriver.quit, sauceDriver
                    if sauceProcess?
                        closeStack.add sauceProcess.close, sauceDriver
                    closeStack.runAllSimultaneously (err2) ->
                        callback err1 or err2
