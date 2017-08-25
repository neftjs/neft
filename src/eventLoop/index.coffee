'use strict'

assert = require 'src/assert'

immediate = []
pending = 0

exports.lock = ->
    pending += 1

exports.release = ->
    pending -= 1
    if pending is 0 and immediate.length > 0
        exports.lock()
        while immediate.length > 0
            immediate.shift()()
        exports.release()
    return

# Register a function which will be called when all locks will be released.
# If there is no pending locks, the given function is calling immediately.
exports.setImmediate = (callback) ->
    assert.isFunction callback, """
        eventLoop.setImmediate callback must be a function, but #{callback} given
    """
    if pending is 0
        callback()
    else
        immediate.push callback
    return
