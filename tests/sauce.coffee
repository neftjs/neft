# coffeelint: disable=no_debugger

'use strict'

sauceConnectLauncher = require 'sauce-connect-launcher'
wd = require 'wd'

{TRAVIS_JOB_NUMBER, SAUCE_USERNAME, SAUCE_ACCESS_KEY} = process.env

SAUCE_HOST = 'ondemand.saucelabs.com'
SAUCE_PORT = 80
TIMEOUT = 120 * 1000

exports.connect = (callback) ->
    callbackCalled = false
    timeoutId = setTimeout ->
        callbackCalled = true
        callback new Error 'Connection time out'
    , TIMEOUT
    sauceConnectLauncher
        username: SAUCE_USERNAME
        accessKey: SAUCE_ACCESS_KEY
        verbose: true
        tunnelIdentifier: TRAVIS_JOB_NUMBER
    , (err, sauceProcess) ->
        if callbackCalled
            return

        driver = wd.remote(
            SAUCE_HOST, SAUCE_PORT,
            SAUCE_USERNAME, SAUCE_ACCESS_KEY
        )

        clearTimeout timeoutId
        callbackCalled = true
        callback null, sauceProcess, driver
