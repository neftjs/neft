'use strict'

pathUtils = require 'path'
appManager = require 'tests/utils/appManager'
sauceHttp = require '../http'
sauceConnection = require '../connection'
sauceDriver = require '../driver'

{utils, log} = Neft
log = log.scope 'android'

APPIUM_VERSION = '1.5.3'
ANDROID_APK = 'build/android/app/build/outputs/apk/app-universal-debug.apk'
CHECK_STATUS_MAX_TRIES = 50
CHECK_STATUS_TIMEOUT = 1000

runTest = (appPath, customData, desired, callback) ->
    desired.appiumVersion = APPIUM_VERSION
    desired.app = "sauce-storage:#{customData.apkFilename}"

    driver = sauceDriver.getDriver()
    driver.run 'init', [desired]

    lastLogs = ''
    checkStatus = ->
        driver.run 'log', ['logcat'],
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
    appManager.onAppBuilt appPath, 'android', (err, builtApp) ->
        if err then return callback err
        sauceConnection.getSauceProcess (err, sauceProcess) ->
            if err then return callback err
            runTest appPath, builtApp.android, desired, callback

exports.prepareBuild = (appPath, callback) ->
    apkLocal = pathUtils.join appPath, ANDROID_APK
    apkFilename = "#{utils.uid()}.apk"
    sauceHttp.sendFile apkLocal, apkFilename, (err) ->
        callback err,
            apkFilename: apkFilename
