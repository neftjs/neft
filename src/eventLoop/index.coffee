'use strict'

assert = require 'src/assert'
{tryCall} = require 'src/tryCatch'

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
            tryCall immediate.shift()
        exports.release()
    return

exports.bindInLock = (func) ->
    ->
        exports.lock()
        result = tryCall func, @, arguments
        exports.release()
        result

# Register a function which will be called when all locks will be released.
# If there is no pending locks, the given function is calling immediately.
exports.setImmediate = (callback) ->
    assert.isFunction callback, """
        eventLoop.setImmediate callback must be a function, but #{callback} given
    """
    if pending is 0
        exports.lock()
        tryCall callback
        exports.release()
    else
        immediate.push callback
    return
