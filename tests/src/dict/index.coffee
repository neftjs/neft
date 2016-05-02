'use strict'

{Dict, unit, assert} = Neft
{describe, it, beforeEach, afterEach} = unit

describe 'src/dict', ->
    describe 'ctor', ->
        it 'creates new dict', ->
            dict = Dict a: 1
            assert.instanceOf dict, Dict

    it 'values can be accessed by keys', ->
        dict = Dict a: 1
        assert.is dict.a, 1
        assert.is dict.abc, undefined

    it 'only set properties are enumerable', ->
        dict = Dict a: 1
        props = []
        for prop of dict
            props.push prop
        assert.isEqual props, ['a']

    describe 'set()', ->
        it 'set key value', ->
            dict = Dict()
            dict.set 'a', 1
            assert.is dict.a, 1

        it 'overrides keys', ->
            dict = Dict a: 1
            dict.set 'a', 2
            assert.is dict.a, 2

    describe 'length', ->
        it 'returns amount of keys', ->
            dict = Dict a: 1, b: 2
            assert.is dict.length, 2

    describe 'pop()', ->
        it 'removes key', ->
            dict = Dict a: 1
            dict.pop 'a'
            assert.is dict.a, undefined

        it 'removed key is not enumerable', ->
            dict = Dict b: 1, a: 1
            dict.pop 'b'
            props = []
            for prop of dict
                props.push prop
            assert.isEqual props, ['a']

    describe 'keys()', ->
        it 'returns keys as an array', ->
            dict = Dict a: 1, b: 2
            assert.isEqual dict.keys(), ['a', 'b']

        it 'length is const', ->
            dict = Dict a: 1
            keys = dict.keys()
            dict.set 'b', 1
            assert.isEqual keys, ['a']
            assert.isEqual dict.keys(), ['a', 'b']

    describe 'values()', ->
        it 'returns key values as an array', ->
            dict = Dict a: 1, b: 2
            assert.isEqual dict.values(), [1, 2]

        it 'length is const', ->
            dict = Dict a: 1
            values = dict.values()
            dict.set 'b', 2
            assert.isEqual values, [1]
            assert.isEqual dict.values(), [1, 2]

    describe 'items()', ->
        it 'returns an array of key - value pairs', ->
            dict = Dict a: 1, b: 2
            assert.isEqual dict.items(), [['a', 1], ['b', 2]]

        it 'length is const', ->
            dict = Dict a: 1
            items = dict.items()
            dict.set 'b', 2
            assert.isEqual items, [['a', 1]]
            assert.isEqual dict.items(), [['a', 1], ['b', 2]]

    describe 'json stringified', ->
        it 'is a reversed operation', ->
            dict = Dict a: 1, b: 2
            json = JSON.stringify dict
            dict2 = Dict.fromJSON json

            assert.isEqual dict2.items(), dict.items()
            assert.instanceOf dict2, Dict

    describe 'onChange signal', ->
        dict = listener = null
        ok = false
        args = items = null

        beforeEach ->
            ok = false
            args = []

            listener = (_args...) ->
                ok = true
                args.push _args
                items = dict.items()

        afterEach ->
            assert.ok ok
            dict.onChange.disconnect listener

        it 'works with set() on new item', ->
            dict = Dict()
            dict.onChange listener
            dict.set 'a', 1
            assert.isEqual args, [['a', undefined]]
            assert.isEqual items, [['a', 1]]

        it 'works with set() on item change', ->
            dict = Dict a: 1
            dict.onChange listener
            dict.set 'a', 2
            assert.isEqual args, [['a', 1]]
            assert.isEqual items, [['a', 2]]

        it 'works with pop()', ->
            dict = Dict a: 1
            dict.onChange listener
            dict.pop 'a'
            assert.isEqual args, [['a', 1]]
            assert.isEqual items, []
