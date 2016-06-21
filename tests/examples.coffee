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

testSauceApp = (platform, callback) ->
    driver = sauce.getDriver()
    desired = utils.merge
        name: 'Neft'
        tags: ['examples']
        'tunnel-identifier': process.env.TRAVIS_JOB_NUMBER
    , platform

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
            driver.quit()
            callback err

    return

runSauceTest = (type, callback) ->
    stack = new utils.async.Stack
    appChild = null
    sauceProcess = null

    sauceConnectAndSave = (callback) ->
        sauce.connect (err, process) ->
            sauceProcess = process
            callback err

    runAndSaveApp = (absPath, callback) ->
        appChild = runApp absPath, callback

    stack.add buildApp, null, [absPath, ['browser', '--with-tests']]
    stack.add sauceConnectAndSave
    stack.add runAndSaveApp, null, [absPath]
    stack.add (callback) ->
        platformsStack = new utils.async.Stack
        platforms = sauce.getPlatforms type
        for platform in platforms
            platformsStack.add testSauceApp, null, [platform]
        platformsStack.runAllSimultaneously callback

    stack.runAll (err1) ->
        appChild?.send 'terminate'
        closeStack = new utils.async.Stack
        if sauceProcess?
            closeStack.add sauceProcess.close, sauceProcess
        closeStack.runAll (err2) ->
            callback err1 or err2

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
                runSauceTest 'browser', callback
