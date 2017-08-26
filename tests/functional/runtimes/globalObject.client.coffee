'use strict'

describe 'global object', ->
    it 'is accessible', ->
        assert.is typeof global, 'object'

    it 'is writable', ->
        global.abc = 123
        assert.is global.abc, 123
        delete global.abc

    it 'accesses properties directly', ->
        global.abc = 123
        assert.is abc, 123
        delete global.abc

    it 'contains Neft object', ->
        assert.is typeof global.Neft.utils.NOP, 'function'

    it 'contains Neft object directly', ->
        assert.is typeof Neft.utils.NOP, 'function'
