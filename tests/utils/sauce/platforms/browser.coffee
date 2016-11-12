'use strict'

appManager = require 'tests/utils/appManager'
sauceConnection = require '../connection'
sauceDriver = require '../driver'

{utils, log} = Neft
log = log.scope 'platform'

APP_URL = "http://localhost:#{appManager.APP_PORT}"
CHECK_STATUS_MAX_TRIES = 50
CHECK_STATUS_TIMEOUT = 1000

runTest = (appPath, desired, callback) ->
    driver = sauceDriver.getDriver()

    driver.run 'init', [desired]
    driver.run 'get', [APP_URL]

    lastLogs = ''
    checkStatus = ->
        driver.run 'execute', ['''
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
            lastLogs = logs
            if running
                return checkTestsFinished()
            unless success
                throw new Error "Client tests failed; #{logs}"

    tries = 0
    checkTestsFinished = ->
        if tries++ >= CHECK_STATUS_MAX_TRIES
            throw new Error "SauceLabs tests status check timeout; last logs: #{lastLogs}"
        if tries > 1
            log 'waiting for tests status'
            setTimeout checkStatus, CHECK_STATUS_TIMEOUT
        else
            checkStatus()

    checkTestsFinished()

    # wait for node server to run
    # TODO: detect instead of setting timeout
    setTimeout ->
        driver.fulfil callback
    , 5000

exports.testApp = (appPath, desired, callback) ->
    appManager.runAppServer appPath, (err, appServer) ->
        if err then return callback err
        callback = do (_super = callback) -> ->
            appServer.close()
            _super arguments...
        appManager.onAppBuilt appPath, 'browser', (err) ->
            if err then return callback err
            sauceConnection.getSauceProcess (err, sauceProcess) ->
                if err then return callback err
                runTest appPath, desired, callback

exports.prepareBuild = (appPath, callback) ->
    callback null
