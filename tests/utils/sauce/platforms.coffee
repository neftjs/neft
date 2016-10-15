'use strict'

fs = require 'fs'
sauce = '../sauce'

{utils} = Neft

PLATFORMS =
    android: require './platforms/android'
    browser: require './platforms/browser'
    ios: require './platforms/ios'

exports.createTest = (projectPath, platforms = ['browser', 'android', 'ios']) ->
    throw new Error
    stack = new utils.async.Stack

    for platform in platforms
        stack.add exports.buildProject, null, [projectPath, platform]
        stack.add PLATFORMS[plaform].build, null, [projectPath]

    callbackPending = null
    testsStack = null
    testsStackError = null

    stack.runAll (err) ->
        if err
            throw new Error 'Cannot prepare SauceLabs project to test'

        connection = sauce.createConnection()
        testsStack = new utils.async.Stack

        for platform in platforms
            testsStack.add PLATFORMS[platform].run, null, [projectPath]

        testsStack.runAllSimultaneously (err) ->
            connection.close()
            testsStackError = err
            if callbackPending
                callbackPending err

    (callback) ->
        if testsStack?.length is 0
            callback testsStackError
        else
            callbackPending = callback
