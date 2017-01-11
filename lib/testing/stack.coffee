'use strict'

{utils, log} = Neft

exports.onlyScopes = 0
exports.onlyTests = 0
exports.currentScope = null
exports.currentTest = null
exports.testsAmount = 0
exports.messages = []
exports.errors = []

window?.onerror = (msg, url, line, column, error) ->
    exports.fail error

exports.fail = (err) ->
    {errors, currentTest} = exports

    if currentTest?.fulfilled is false
        return

    unless err instanceof Error
        errMsg = try JSON.stringify err
        err = new Error errMsg or err

    errObj = utils.errorToObject err
    errObj.stack = err.stack
    utils.defineProperty errObj, 'currentTest', 0, currentTest
    errors.push errObj
    if currentTest?
        currentTest.fulfilled = false
        unless currentTest._callbackCalled
            currentTest.onEnd errObj
    return

exports.callFunction = (func, context, args) ->
    try
        func.apply context, args
        true
    catch err
        exports.fail err
        false
