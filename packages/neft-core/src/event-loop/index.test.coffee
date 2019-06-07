eventLoop = require './'

it 'calls setImmediate callback when all locks are released', ->
    called = false
    callback = -> called = true
    eventLoop.lock()

    eventLoop.setImmediate callback
    assert.notOk called

    eventLoop.lock()
    assert.notOk called

    eventLoop.release()
    assert.notOk called

    eventLoop.release()
    assert.ok called

it 'calls setImmediate callback when loop is not locked', ->
    called = false
    callback = -> called = true
    eventLoop.setImmediate callback
    assert.ok called

it 'locks automatically called callback', ->
    order = []
    callback1 = ->
        eventLoop.setImmediate callback2
        order.push 1
    callback2 = -> order.push 2
    eventLoop.setImmediate callback1
    assert.isEqual order, [1, 2]

it 'handles thrown errors in released callback', ->
    eventLoop.lock()
    eventLoop.setImmediate -> throw new Error
    eventLoop.release()

    called = false

    eventLoop.lock()
    eventLoop.setImmediate -> called = true
    eventLoop.release()

    assert.ok called

it 'handles thrown errors in callback called on not locked loop', ->
    eventLoop.setImmediate -> throw new Error
    called = false
    eventLoop.setImmediate -> called = true
    assert.ok called

describe 'callInLock()', ->
    it 'calls given function properly', ->
        called = []
        func = (args...) -> called.push [@, args]
        eventLoop.callInLock func, ['ctx'], [1, 2]
        assert.isEqual called, [[['ctx'], [1, 2]]]

    it 'calls given function in a lock', ->
        called = []
        eventLoop.callInLock ->
            eventLoop.setImmediate -> called.push 'immediate'
            called.push 'inLock'
        assert.isEqual called, ['inLock', 'immediate']

    it 'rethrows thrown error but heep loop released', ->
        errorToThrow = new Error
        error = null
        try
            eventLoop.callInLock -> throw errorToThrow
        catch callError
            error = callError
        assert.is error, errorToThrow

        called = false
        eventLoop.setImmediate -> called = true
        assert.ok called

describe 'bindInLock()', ->
    it 'calls given function properly', ->
        called = []
        func = (args...) -> called.push [@, args]
        bindFunc = eventLoop.bindInLock func
        bindFunc.call ['ctx'], 1, 2
        assert.isEqual called, [[['ctx'], [1, 2]]]

    it 'calls given function in a lock', ->
        called = []
        bindFunc = eventLoop.bindInLock ->
            eventLoop.setImmediate -> called.push 'immediate'
            called.push 'inLock'
        bindFunc()
        assert.isEqual called, ['inLock', 'immediate']

    it 'rethrows thrown error but heep loop released', ->
        errorToThrow = new Error
        error = null
        try
            bindFunc = eventLoop.bindInLock -> throw errorToThrow
            bindFunc()
        catch callError
            error = callError
        assert.is error, errorToThrow

        called = false
        eventLoop.setImmediate -> called = true
        assert.ok called

