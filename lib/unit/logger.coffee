'use strict'

{utils} = Neft

stack = require './stack'
errorUtils = require './error'
log = switch true
    when utils.isNode
        require './loggers/node'
    when utils.isBrowser
        require './loggers/browser'
    else
        require './loggers/native'

SCOPE_PAD = '    '
MIN_TIME_WARN = 100

pad = ''
testStartTime = 0

exports.onTestsStart = ->
    log.onTestsStart()

exports.onTestsEnd = ->
    for error in stack.errors
        errorString = errorUtils.toString error
        errorString = errorString.replace /^/gm, SCOPE_PAD
        msg = '\n'
        if error.test
            msg += "#{error.test.getFullMessage()}\n"
        msg += errorString
        log.error msg
    log.onTestsEnd()
    return

exports.onScopeStart = (scope) ->
    {message} = scope
    if message is ''
        return

    log.log pad + scope.message
    pad += SCOPE_PAD
    return

exports.onScopeEnd = (scope) ->
    {message} = scope
    if message is ''
        return

    pad = pad.slice SCOPE_PAD.length
    return

exports.onTestStart = (test) ->
    testStartTime = Date.now()
    return

exports.onTestEnd = (test) ->
    msg = pad + test.message

    duration = Date.now() - testStartTime
    if duration > MIN_TIME_WARN
        ms = duration.toFixed(2)
        msg += " (#{ms} ms)"

    if test.fulfilled
        log.ok msg
    else
        log.error msg
    return
