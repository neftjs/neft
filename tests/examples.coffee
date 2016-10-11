# coffeelint: disable=no_debugger

'use strict'

tests = require './init'
unless tests.shouldTest.examples
    return

glob = require 'glob'
fs = require 'fs-extra'
cp = require 'child_process'
pathUtils = require 'path'
os = require 'os'
sauce = require './sauce'

{unit, assert, utils, log} = Neft
{describe, it} = unit

APP_URL = 'localhost:3000'
GAME_APP_URL = 'localhost:3000/neft-type=game/'
NEFT_BIN_PATH = pathUtils.join(fs.realpathSync('./'), 'bin/neft.js')
NEFT_UNIT_BIN_PATH = pathUtils.join(fs.realpathSync('./'), 'bin/neft-unit.js')
ANDROID_APK = 'build/android/app/build/outputs/apk/app-universal-debug.apk'
IOS_APP = 'build/ios/build/Release-iphonesimulator/Neft.app'
APPIUM_VERSION = '1.5.3'

BUILD_NUMBER = process.env.TRAVIS_BUILD_NUMBER
BUILD_NUMBER ||= process.env.APPVEYOR_BUILD_NUMBER
BUILD_NUMBER ||= "custom-#{utils.uid()}"

examples = glob.sync './examples/*'

fork = (path, args, options, callback) ->
    child = cp.fork path, args, options
    child.on 'exit', callback

buildApp = (absPath, args, callback) ->
    fs.removeSync pathUtils.join(absPath, '/build')
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

logCommand = (cmd) ->
    log.info "$ #{cmd}"
    log.info cp.execSync(cmd) + '\n'

testSauceAppOnDriver = (desired, opts, callback) ->
    driver = sauce.getDriver()
    stack = new utils.async.Stack

    run = (func, args, onResult = utils.NOP) ->
        stack.add func, driver, args
        stack.add (result, callback) ->
            try
                onResult result
            catch err
                return callback err
            callback()

        return

    run driver.init, [desired]

    switch opts.platform
        when 'browser'
            url = if opts.type is 'game' then GAME_APP_URL else APP_URL
            run driver.get, [url]
            logType = 'browser'
        when 'android'
            logType = 'logcat'
        else
            logType = 'syslog'

    if desired.browserName
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
    else
        checkTestsFinished = ->
            run driver.log, [logType],
            (logs) ->
                running = true
                success = true

                for log in logs
                    if log.message.indexOf('Neft tests ended') >= 0
                        running = false
                        break

                if running
                    stack.add (callback) ->
                        setTimeout ->
                            checkTestsFinished()
                            callback()
                        , 500
                    return

                for log in logs
                    if /Unit\ (LOG|OK|ERROR)/.test(log.message)
                        console.log log.message
                    else if log.message.indexOf('Neft tests failed') >= 0
                        success = false

                unless success
                    throw new Error 'Client tests failed'

    checkTestsFinished()

    stack.runAll (err) ->
        console.log 'SAUCE TEST ENDED'
        console.log desired
        driver.sauceJobStatus not err, ->
            driver.quit()
            callback err

    return

testSauceApp = (absPath, opts, callback) ->
    platforms = utils.cloneDeep sauce.getPlatforms opts.platform

    runTests = (config) ->
        platformsStack = new utils.async.Stack
        for platform in platforms
            desired = utils.mergeAll
                name: 'Neft'
                tags: ['examples']
                build: BUILD_NUMBER
                'tunnel-identifier': process.env.TRAVIS_JOB_NUMBER
            , config, platform
            platformsStack.add testSauceAppOnDriver, null, [desired, opts]
        platformsStack.runAllSimultaneously callback

    switch opts.platform
        when 'android'
            apkLocal = pathUtils.join absPath, ANDROID_APK
            apkFilename = "#{utils.uid()}.apk"
            sauce.sendFile apkLocal, apkFilename, (err) ->
                if err
                    return callback err
                runTests
                    appiumVersion: APPIUM_VERSION
                    app: "sauce-storage:#{apkFilename}"
        when 'ios'
            zipLocal = pathUtils.join os.tmpdir(), 'Neft.zip'
            projectLocal = pathUtils.join absPath, 'build/ios'
            appLocal = pathUtils.join absPath, IOS_APP

            prepareDesired = (desired, callback) ->
                logCommand 'xcodebuild -version'
                logCommand 'xcodebuild -showsdks'

                {NEFT_IOS_VERSION} = process.env
                xcode = 'xcodebuild -sdk iphonesimulator'
                xcode += NEFT_IOS_VERSION
                cp.execSync xcode, cwd: projectLocal
                cp.execSync "zip -r #{zipLocal} #{appLocal}"

                zipFilename = "#{utils.uid()}.zip"
                sauce.sendFile zipLocal, zipFilename, (err) ->
                    if err
                        return callback err
                    desired.app = "sauce-storage:#{zipFilename}"
                    callback null

            iosStack = new utils.async.Stack
            for platform in platforms
                iosStack.add prepareDesired, null, [platform]
            iosStack.runAll (err) ->
                if err
                    return callback err
                runTests
                    appiumVersion: APPIUM_VERSION
        else
            runTests()

    return

runSauceTest = (opts, callback) ->
    stack = new utils.async.Stack
    appChild = null
    sauceProcess = null

    sauceConnectAndSave = (callback) ->
        sauce.connect (err, process) ->
            sauceProcess = process
            callback err

    runAndSaveApp = (absPath, callback) ->
        appChild = runApp absPath, callback

    stack.add buildApp, null, [absPath, [opts.platform, '--with-tests']]
    stack.add sauceConnectAndSave
    stack.add runAndSaveApp, null, [absPath]
    stack.add testSauceApp, null, [absPath, opts]

    stack.runAll (err1) ->
        appChild?.send 'terminate'
        closeStack = new utils.async.Stack
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
                runSauceTest {platform: 'browser'}, callback

            it 'should pass tests on browser as a game', (callback) ->
                runSauceTest {platform: 'browser', type: 'game'}, callback

        if process.env.NEFT_TEST_ANDROID
            it 'should pass tests on android', (callback) ->
                runSauceTest {platform: 'android'}, callback

        if process.env.NEFT_TEST_IOS
            it 'should pass tests on ios', (callback) ->
                runSauceTest {platform: 'ios'}, callback
