eventLoop = require './'

describe 'src/eventLoop', ->
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
