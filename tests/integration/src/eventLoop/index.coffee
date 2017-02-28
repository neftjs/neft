eventLoop = require 'src/eventLoop'

describe 'src/eventLoop', ->
    it 'calls setImmediate callback when all locks will be released', ->
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
