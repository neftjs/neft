{SignalDispatcher, SignalsEmitter} = require './'

onTest = null

beforeEach ->
    onTest = new SignalDispatcher

describe 'connectOnce()', ->
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
        obj = new SignalsEmitter
        SignalsEmitter.createSignal(obj, 'onTest')
        ctx = null
        obj.onTest.connectOnce ->
            ctx = @
        obj.emit 'onTest'
        assert.is ctx, obj

    it 'is called with custom context', ->
        obj = new SignalsEmitter
        SignalsEmitter.createSignal(obj, 'onTest')
        custom = a: 1
        ctx = null
        obj.onTest.connectOnce (-> ctx = @), custom
        obj.emit 'onTest'
        assert.is ctx, custom

    it 'is called with given arguments', ->
        args = null
        onTest.connectOnce (localArgs...) -> args = localArgs
        onTest.emit 'arg1', 'arg2'
        assert.isEqual args, ['arg1', 'arg2']

    it 'works in emitter', ->
        emitter = new SignalsEmitter
        SignalsEmitter.createSignal emitter, 'onTest'
        SignalsEmitter.createSignal emitter, 'onNothing'

        calls = 0
        emitter.onTest.connect -> emitter.emit 'onNothing'
        emitter.onTest.connectOnce -> calls += 1
        emitter.emit('onTest') for i in [1..10]
        assert.is calls, 1

    return

it 'keeps listeners array clean', ->
    func1 = ->
    func2 = ->
    func3 = ->
    func4 = ->
    func5 = ->
    func6 = ->
    onTest.connect func1
    onTest.connectOnce func2
    onTest.connectOnce func3
    onTest.connect func4
    onTest.connectOnce func5
    onTest.connect func6

    # (handler, context) * 2
    assert.is onTest.listeners.length, 12

    onTest.emit()
    assert.isEqual onTest.listeners, [
        func1, null, null, null, null, null, func4, null, null, null, func6, null,
    ]

    onTest.emit()
    assert.isEqual onTest.listeners, [
        func1, null, func4, null, func6, null, null, null, null, null, null, null,
    ]

    onTest.connect func2
    assert.isEqual onTest.listeners, [
        func1, null, func4, null, func6, null, func2, null, null, null, null, null,
    ]
