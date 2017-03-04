# coffeelint: disable=no_debugger

'use strict'

stack = require './stack'
errorUtils = require './error'

exports.TEST = '[TEST] '
exports.SCOPE = '[SCOPE] '
exports.ERROR_TEST = '[ERROR_TEST] '
exports.ERROR = '[ERROR] '
exports.SUCCESS = 'Tests success'
exports.FAILURE = 'Tests failure'

scopeDeepness = 0

getDeepnessPrefix = ->
    r = ''
    for i in [0...scopeDeepness] by 1
        r += '   '
    r

exports.onTestsStart = ->

exports.onTestsEnd = ->
    # log result
    if stack.errors.length
        console.log exports.FAILURE
    else
        console.log exports.SUCCESS
    return

exports.onScopeStart = (scope) ->
    if scope.message
        console.log exports.SCOPE + getDeepnessPrefix() + scope.message
        scopeDeepness += 1
    return

exports.onScopeEnd = (scope) ->
    if scope.message
        scopeDeepness -= 1
    return

exports.onTestStart = (test) ->

exports.onTestError = (test, error) ->
    if test.message
        console.log exports.ERROR_TEST + getDeepnessPrefix() + test.message
    msg = "Error in test: #{test.getFullMessage()}\n"
    msg += errorUtils.toString(error)
    console.log exports.ERROR + encodeURIComponent(msg)
    return

exports.onTestEnd = (test) ->
    if test.message
        console.log exports.TEST + getDeepnessPrefix() + test.message
    return
