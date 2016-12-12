'use strict'

describe 'lib/unit', ->
    describe 'it()', ->
        it '', ->
            @a = 1

        it 'has his own context', ->
            assert.isEqual @, {}

    describe 'beforeEach()', ->
        beforeEach ->
            assert.isEqual @, {}
            @a = 1

        beforeEach ->
            assert.isEqual @, {a: 1}
            @b = 1

        it 'context is available in tests', ->
            assert.isEqual @, {a: 1, b: 1}

        it 'context is available in async tests', (callback) ->
            assert.isEqual @, {a: 1, b: 1}
            callback()

        describe 'nested', ->
            beforeEach ->
                assert.isEqual @, {a: 1, b: 1}
                @c = 1

            it 'shares context', ->
                assert.isEqual @, {a: 1, b: 1, c: 1}

    describe 'afterEach()', ->
        afterEach ->
            assert.isEqual @, {a: 1}

        it 'context is shared with tests', ->
            @a = 1
