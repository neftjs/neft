'use strict'

assert = require '../assert'
log = require '../log'

immediate = []
pending = 0

exports.lock = ->
    pending += 1

exports.release = ->
    pending -= 1
    assert.ok pending >= 0
    if pending is 0 and immediate.length > 0
        exports.lock()
        while immediate.length > 0
            try
                immediate.shift()()
            catch error
                log.error 'Uncaught error when executing event-loop', error
        exports.release()
    return

exports.callInLock = (func, ctx, args) ->
    error = null
    exports.lock()
    try
        result = func.apply ctx, args
    catch callError
        error = callError
    exports.release()
    if error
        throw error
    result

exports.bindInLock = (func) ->
    ->
        error = null
        exports.lock()
        try
            result = func.apply @, arguments
        catch callError
            error = callError
        exports.release()
        if error
            throw error
        result

# Register a function which will be called when all locks will be released.
# If there is no pending locks, the given function is calling immediately.
exports.setImmediate = (callback) ->
    assert.isFunction callback, """
        eventLoop.setImmediate callback must be a function, but #{callback} given
    """
    if pending is 0
        exports.lock()
        try
            callback()
        catch error
            log.error 'Uncaught error during setImmediate in the event-loop', error
        exports.release()
    else
        immediate.push callback
    return
