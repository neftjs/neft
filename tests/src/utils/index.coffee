'use strict'

{unit, assert, utils} = Neft
{describe, it} = unit

describe 'src/utils', ->
    describe 'is()', ->
        it 'returns true if the given values are the same', ->
            assert.ok utils.is 'a', 'a'
            assert.ok utils.is 1, 1
            assert.ok utils.is undefined, undefined
            assert.ok utils.is null, null
            assert.ok utils.is true, true
            assert.ok utils.is obj = {}, obj
            assert.ok utils.is (func = ->), func

        it 'returns false if the given values are different', ->
            assert.notOk utils.is 'a', 'b'
            assert.notOk utils.is 1, 2
            assert.notOk utils.is null, undefined
            assert.notOk utils.is false, true
            assert.notOk utils.is {}, {}
            assert.notOk utils.is (->), ->

        it 'returns true if two NaNs have been given', ->
            assert.ok utils.is NaN, NaN

        it 'returns false for negative zero and positive zero comparison', ->
            assert.notOk utils.is -0, 0

    describe 'isFloat()', ->
        it 'returns true for finite numbers', ->
            assert.ok utils.isFloat 10
            assert.ok utils.isFloat 10.5
            assert.ok utils.isFloat -23.12
            assert.ok utils.isFloat 0

        it 'returns false for not infinite numbers', ->
            assert.notOk utils.isFloat NaN
            assert.notOk utils.isFloat Infinity
            assert.notOk utils.isFloat -Infinity

        it 'returns false for not numbers type', ->
            assert.notOk utils.isFloat null
            assert.notOk utils.isFloat true
            assert.notOk utils.isFloat undefined
            assert.notOk utils.isFloat ->
            assert.notOk utils.isFloat {}
            assert.notOk utils.isFloat Object(4)
            assert.notOk utils.isFloat '4'

    describe 'isInteger()', ->
        it 'returns true for finite numbers with no exponent', ->
            assert.ok utils.isInteger 3
            assert.ok utils.isInteger -5
            assert.ok utils.isInteger 0

        it 'returns false for not finite numbers', ->
            assert.notOk utils.isInteger NaN
            assert.notOk utils.isInteger Infinity
            assert.notOk utils.isInteger -Infinity

        it 'returns false for numbers with exponent', ->
            assert.notOk utils.isInteger 3.2
            assert.notOk utils.isInteger -5.1
            assert.notOk utils.isInteger 0.3

        it 'returns false for not numbers type', ->
            assert.notOk utils.isInteger null
            assert.notOk utils.isInteger true
            assert.notOk utils.isInteger undefined
            assert.notOk utils.isInteger ->
            assert.notOk utils.isInteger {}
            assert.notOk utils.isInteger Object(4)
            assert.notOk utils.isInteger '4'

    describe 'isPrimitive()', ->
        it 'returns true for a null, string, number boolean or an undefined', ->
            assert.ok utils.isPrimitive null
            assert.ok utils.isPrimitive 'a'
            assert.ok utils.isPrimitive 12.2
            assert.ok utils.isPrimitive true
            assert.ok utils.isPrimitive undefined

        it 'returns false for other types', ->
            assert.notOk utils.isPrimitive {}
            assert.notOk utils.isPrimitive []
            assert.notOk utils.isPrimitive ->
            assert.notOk utils.isPrimitive Object(4)

    describe 'isObject()', ->
        it 'returns true if the given value is an array of an object', ->
            assert.ok utils.isObject []
            assert.ok utils.isObject {}
            assert.ok utils.isObject Object.create(null)
            assert.ok utils.isObject Object.create({a: 1})

        it 'returns false for the given null', ->
            assert.notOk utils.isObject null

        it 'returns false for types different than object', ->
            assert.notOk utils.isObject ->
            assert.notOk utils.isObject false
            assert.notOk utils.isObject undefined
            assert.notOk utils.isObject 'a'

    describe 'isPlainObject()', ->
        it 'returns true for the given object with no prototype', ->
            assert.ok utils.isPlainObject Object.create(null)

        it 'returns true for the given object with standard prototype', ->
            assert.ok utils.isPlainObject {}
            assert.ok utils.isPlainObject Object.create(Object.prototype)

        it 'returns false for object with custom prototype', ->
            class A
            assert.notOk utils.isPlainObject Object.create({a: 1})
            assert.notOk utils.isPlainObject new A

        it 'returns false for the given null', ->
            assert.notOk utils.isPlainObject null

        it 'returns false for types different than object', ->
            assert.notOk utils.isPlainObject ->
            assert.notOk utils.isPlainObject false
            assert.notOk utils.isPlainObject undefined
            assert.notOk utils.isPlainObject 'a'

    describe 'isArguments()', ->
        # TODO

    describe 'merge()', ->
        # TODO

    describe 'mergeAll()', ->
        # TODO

    describe 'mergeDeep()', ->
        # TODO

    describe 'fill()', ->
        # TODO

    describe 'remove()', ->
        # TODO

    describe 'removeFromUnorderedArray()', ->
        # TODO

    describe 'getPropertyDescriptor()', ->
        # TODO

    describe 'lookupGetter()', ->
        # TODO

    describe 'lookupSetter()', ->
        # TODO

    describe 'defineProperty()', ->
        # TODO

    describe 'overrideProperty()', ->
        # TODO

    describe 'clone()', ->
        # TODO

    describe 'cloneDeep()', ->
        # TODO

    describe 'isEmpty()', ->
        # TODO

    describe 'last()', ->
        # TODO

    describe 'clear()', ->
        # TODO

    describe 'setPrototypeOf()', ->
        # TODO

    describe 'has()', ->
        # TODO

    describe 'objectToArray()', ->
        # TODO

    describe 'arrayToObject()', ->
        # TODO

    describe 'capitalize()', ->
        # TODO

    describe 'addSlashes()', ->
        # TODO

    describe 'uid()', ->
        # TODO

    describe 'tryFunction()', ->
        # TODO

    describe 'catchError()', ->
        # TODO

    describe 'bindFunctionContext()', ->
        # TODO

    describe 'errorToObject()', ->
        # TODO

    describe 'getOwnProperties()', ->
        # TODO

    describe 'isEqual()', ->
        it 'returns proper value of two objects given', ->
            assert.ok utils.isEqual {a: 1}, {a: 1}
            assert.notOk utils.isEqual {a: 1}, {b: 1}
            assert.notOk utils.isEqual {a: 1}, {a: 2}

        it 'returns proper value of two arrays given', ->
            assert.ok utils.isEqual [1, 2], [1, 2]
            assert.notOk utils.isEqual [1, 2], [1]
            assert.notOk utils.isEqual [2, 1], [1, 2]

        it 'test objects deeply', ->
            assert.ok utils.isEqual {a: [{b: 1}]}, {a: [{b: 1}]}
            assert.notOk utils.isEqual {a: [{b: 1}]}, {a: [{b: 2}]}

        it 'compareFunction is used to test primitive values', ->
            funcArgs = []
            compareFunction = (args...) -> funcArgs.push args
            utils.isEqual {a: [{b: 1}]}, {a: [{b: 2}]}, compareFunction
            expected = [[1, 2]]
            assert.is JSON.stringify(funcArgs), JSON.stringify(expected)

        it 'maxDeep specifies how deep objects should be tested', ->
            assert.ok utils.isEqual {a: [{b: 1}]}, {a: [{b: 2}]}, 2
            assert.notOk utils.isEqual {a: [{b: 1}]}, {a: [{b: 2}]}, 3
