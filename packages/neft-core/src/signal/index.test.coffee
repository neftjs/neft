signal = require './'

{Emitter} = signal

describe 'connectOnce()', ->
    onTest = null

    beforeEach ->
        onTest = signal.create()

    it 'is called only once', ->
        calls = 0
        onTest.connectOnce -> calls += 1
        onTest.emit() for i in [1..10]
        assert.is calls, 1

    it 'is called with global context', ->
        ctx = null
        onTest.connectOnce -> ctx = @
        onTest.emit()
        assert.is ctx, global

    it 'is called with default context', ->
        obj = {}
        onTest = signal.create obj
        ctx = null
        onTest.connectOnce -> ctx = @
        onTest.emit()
        assert.is ctx, obj

    it 'is called with custom context', ->
        obj = custom: 1
        onTest = signal.create {}
        ctx = null
        onTest.connectOnce (-> ctx = @), obj
        onTest.emit()
        assert.is ctx, obj

    it 'is called with given arguments', ->
        args = null
        onTest.connectOnce (localArgs...) -> args = localArgs
        onTest.emit 'arg1', 'arg2'
        assert.isEqual args, ['arg1', 'arg2']

    it 'works in emitter', ->
        emitter = new Emitter
        Emitter.createSignalOnObject emitter, 'onTest'
        Emitter.createSignalOnObject emitter, 'onNothing'

        calls = 0
        emitter.onTest.connect -> emitter.onNothing.emit()
        emitter.onTest.connectOnce -> calls += 1
        emitter.onTest.emit() for i in [1..10]
        assert.is calls, 1
