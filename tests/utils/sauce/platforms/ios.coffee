'use strict'

pathUtils = require 'path'
cp = require 'child_process'
os = require 'os'
appManager = require 'tests/utils/appManager'
sauceHttp = require '../http'
sauceConnection = require '../connection'
sauceDriver = require '../driver'

{utils} = Neft

APPIUM_VERSION = '1.5.3'
IOS_APP = 'build/ios/build/Release-iphonesimulator/Neft.app'
CHECK_STATUS_MAX_TRIES = 50
CHECK_STATUS_TIMEOUT = 1000
{NEFT_IOS_VERSION} = process.env

runTest = (appPath, customData, desired, callback) ->
    desired.appiumVersion = APPIUM_VERSION
    desired.app = "sauce-storage:#{customData.zipFilename}"

    driver = sauceDriver.getDriver()
    driver.run 'init', [desired]

    lastLogs = ''
    checkStatus = ->
        driver.run 'log', ['syslog'],
        (logs) ->
            lastLogs = JSON.stringify logs

            running = true
            success = true

            for appLog in logs
                if appLog.message.indexOf('Neft tests ended') >= 0
                    running = false
                    break

            if running
                checkTestsFinished()
                return

            for appLog in logs
                if /Unit\ (LOG|OK|ERROR)/.test(appLog.message)
                    log appLog.message
                else if appLog.message.indexOf('Neft tests failed') >= 0
                    success = false

            unless success
                throw new Error "Client tests failed; #{lastLogs}"

    tries = 0
    checkTestsFinished = ->
        if tries++ >= CHECK_STATUS_MAX_TRIES
            throw new Error "SauceLabs tests status check timeout; last logs: #{lastLogs}"
        if tries > 1
            log 'waiting for tests status'
            driver.wait CHECK_STATUS_TIMEOUT
        checkStatus()

    checkTestsFinished()

    driver.fulfil callback

exports.testApp = (appPath, desired, callback) ->
    appManager.onAppBuilt appPath, 'ios', (err, builtApp) ->
        if err then return callback err
        sauceConnection.getSauceProcess (err, sauceProcess) ->
            if err then return callback err
            runTest appPath, builtApp.ios, desired, callback

exports.prepareBuild = (appPath, callback) ->
    zipLocal = pathUtils.join os.tmpdir(), 'Neft.zip'
    projectLocal = pathUtils.join appPath, 'build/ios'
    appLocal = pathUtils.join appPath, IOS_APP

    xcode = 'xcodebuild -sdk iphonesimulator'
    xcode += NEFT_IOS_VERSION
    cp.execSync xcode, cwd: projectLocal
    cp.execSync "zip -r #{zipLocal} #{appLocal}"

    zipFilename = "#{utils.uid()}.zip"
    sauceHttp.sendFile zipLocal, zipFilename, (err) ->
        if err then return callback err
        callback err,
            zipFilename: zipFilename
