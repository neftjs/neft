# coffeelint: disable=no_debugger

'use strict'

stack = require './stack'
errorUtils = require './error'

exports.TEST_START = '[TEST_START] '
exports.TEST = '[TEST] '
exports.ERROR_TEST = '[ERROR_TEST] '
exports.ERROR = '[ERROR] '
exports.START = 'Tests are starting'
exports.SUCCESS = 'Tests success'
exports.FAILURE = 'Tests failed'

exports.onTestsStart = ->
    console.log "#{exports.START} #{stack.testsAmount} in total"

exports.onTestsEnd = ->
    # log result
    if stack.errors.length
        console.log exports.FAILURE
    else
        console.log exports.SUCCESS
    return

exports.onScopeStart = (scope) ->

exports.onScopeEnd = (scope) ->

exports.onTestStart = (test) ->
    console.log exports.TEST_START + test.getFullMessage()

exports.onTestError = (test, error) ->
    if test.message
        console.log exports.ERROR_TEST + test.getFullMessage()
    msg = "Error in test: #{test.getFullMessage()}\n"
    msg += errorUtils.toString(error)
    console.log exports.ERROR + encodeURIComponent(msg)
    return

exports.onTestEnd = (test) ->
    if test.message and test.fulfilled
        console.log exports.TEST + test.getFullMessage()
    return
