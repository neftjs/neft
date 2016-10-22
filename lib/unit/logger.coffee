'use strict'

{utils, log} = Neft
Log = log.constructor

stack = require './stack'
errorUtils = require './error'
logger = switch true
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
currentTest = null
currentTestLogged = false

log.constructor::_write = do (_super = log.constructor::_write) -> ->
    if currentTest and not currentTestLogged
        currentTestLogged = true
        decreaseLogPad()
        log.info currentTest.message
        increaseLogPad()
    _super.apply @, arguments

increaseLogPad = ->
    pad += SCOPE_PAD
    Log.setGlobalLinesPrefix pad

decreaseLogPad = ->
    pad = pad.slice SCOPE_PAD.length
    Log.setGlobalLinesPrefix pad

exports.onTestsStart = ->
    logger.onTestsStart()

exports.onTestsEnd = ->
    for error in stack.errors
        errorString = errorUtils.toString error
        errorString = errorString.replace /^/gm, SCOPE_PAD
        msg = '\n'
        if error.test
            msg += "#{error.test.getFullMessage()}\n"
        msg += errorString
        log.error msg
    logger.onTestsEnd()
    return

exports.onScopeStart = (scope) ->
    {message} = scope
    if message is ''
        return

    log scope.message
    increaseLogPad()
    return

exports.onScopeEnd = (scope) ->
    {message} = scope
    if message is ''
        return

    decreaseLogPad()
    return

exports.onTestStart = (test) ->
    testStartTime = Date.now()
    currentTest = test
    currentTestLogged = false
    increaseLogPad()
    return

exports.onTestEnd = (test) ->
    decreaseLogPad()

    currentTestLogged = true
    msg = test.message

    duration = Date.now() - testStartTime
    if duration > MIN_TIME_WARN
        ms = duration.toFixed(2)
        msg += " (#{ms} ms)"

    if test.fulfilled
        log.ok msg
    else
        log.error msg
    return
