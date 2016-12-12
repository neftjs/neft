# coffeelint: disable=no_debugger

'use strict'

stack = require './stack'
errorUtils = require './error'

exports.PREFIX = '[TEST] '
exports.ERROR = '[ERROR] '
exports.SUCCESS = 'Tests success'
exports.FAILURE = 'Tests failure'

log = (msg) ->
    console.log exports.PREFIX + msg

logError = (error) ->
    msg = ''
    if error.currentTest
        msg += "#{error.currentTest.getFullMessage()}\n"
    msg += errorUtils.toString error
    log exports.ERROR + encodeURIComponent(msg)

exports.onTestsStart = ->

exports.onTestsEnd = ->
    # log all errors
    for error in stack.errors
        logError error

    # log result
    if stack.errors.length
        log exports.FAILURE
    else
        log exports.SUCCESS
    return

exports.onScopeStart = (scope) ->
    return

exports.onScopeEnd = (scope) ->
    return

exports.onTestStart = (test) ->
    log test.getFullMessage()
    return

exports.onTestError = (test, error) ->
    logError error

exports.onTestEnd = (test) ->
