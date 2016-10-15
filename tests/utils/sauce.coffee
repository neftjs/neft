'use strict'

appManager = require './appManager'
browserPlatform = require './sauce/platforms/browser'
sauceConnection = require './sauce/connection'

{unit, utils} = Neft
{it, after} = unit

{NEFT_TEST_BROWSER, NEFT_TEST_ANDROID, NEFT_TEST_IOS, TRAVIS_JOB_NUMBER} = process.env

BUILD_NUMBER = process.env.TRAVIS_BUILD_NUMBER
BUILD_NUMBER ||= process.env.APPVEYOR_BUILD_NUMBER
BUILD_NUMBER ||= "custom-#{utils.uid()}"

platforms =
    browser: require './sauce/platforms/browser'
    android: require './sauce/platforms/android'
    ios: require './sauce/platforms/ios'

exports.prepareDesired = (desired, label) ->
    utils.merge
        name: "#{label} on build #{BUILD_NUMBER}"
        build: BUILD_NUMBER
        'tunnel-identifier': TRAVIS_JOB_NUMBER
    , desired

exports.createDesiredLabel = (platform, desired) ->
    switch platform
        when 'browser'
            "#{desired.platform} #{desired.browserName} #{desired.version}"
        else
            "#{desired.deviceName} #{desired.platformName} #{desired.platformVersion}"

exports.createTestCases = (appPath, platform, config) ->
    for desired in config
        label = exports.createDesiredLabel platform, desired
        desired = exports.prepareDesired desired, label
        it label, do (desired) -> (callback) ->
            platforms[platform].testApp appPath, desired, callback
    return

exports.createDefaultTestCases = (appPath) ->
    running = false

    if NEFT_TEST_BROWSER
        running = true
        appManager.buildApp appPath, 'browser', platforms.browser.prepareBuild
        config = require './sauce/config/browser.yml'
        exports.createTestCases appPath, 'browser', config

    if NEFT_TEST_ANDROID
        running = true
        appManager.buildApp appPath, 'android', platforms.android.prepareBuild
        config = require './sauce/config/android.yml'
        exports.createTestCases appPath, 'android', config

    if NEFT_TEST_IOS
        running = true
        appManager.buildApp appPath, 'ios', platforms.ios.prepareBuild
        config = require './sauce/config/ios.yml'
        exports.createTestCases appPath, 'ios', config

    if running
        connection = sauceConnection.createConnection()
        it '', ->
            connection.close()

    return
