'use strict'

{utils} = Neft

describe 'utils', ->
    describe 'is()', ->
        it 'returns true if the given values are the same', ->
            assert.is utils.is('a', 'a'), true
            assert.is utils.is(1, 1), true
            assert.is utils.is(undefined, undefined), true
            assert.is utils.is(null, null), true
            assert.is utils.is(true, true), true
            assert.is utils.is(obj = {}, obj), true
            assert.is utils.is((func = ->), func), true

        it 'returns false if the given values are different', ->
            assert.is utils.is('a', 'b'), false
            assert.is utils.is(1, 2), false
            assert.is utils.is(null, undefined), false
            assert.is utils.is(false, true), false
            assert.is utils.is({}, {}), false
            assert.is utils.is((->), ->), false

        it 'returns true if two NaNs have been given', ->
            assert.is utils.is(NaN, NaN), true

        it 'returns false for negative zero and positive zero comparison', ->
            assert.is utils.is(-0, 0), false

    describe 'isFloat()', ->
        it 'returns true for finite numbers', ->
            assert.is utils.isFloat(10), true
            assert.is utils.isFloat(10.5), true
            assert.is utils.isFloat(-23.12), true
            assert.is utils.isFloat(0), true

        it 'returns false for not infinite numbers', ->
            assert.is utils.isFloat(NaN), false
            assert.is utils.isFloat(Infinity), false
            assert.is utils.isFloat(-Infinity), false

        it 'returns false for not numbers type', ->
            assert.is utils.isFloat(null), false
            assert.is utils.isFloat(true), false
            assert.is utils.isFloat(undefined), false
            assert.is utils.isFloat(->), false
            assert.is utils.isFloat({}), false
            assert.is utils.isFloat(Object(4)), false
            assert.is utils.isFloat('4'), false

    describe 'isInteger()', ->
        it 'returns true for finite numbers with no exponent', ->
            assert.is utils.isInteger(3), true
            assert.is utils.isInteger(-5), true
            assert.is utils.isInteger(0), true

        it 'returns false for not finite numbers', ->
            assert.is utils.isInteger(NaN), false
            assert.is utils.isInteger(Infinity), false
            assert.is utils.isInteger(-Infinity), false

        it 'returns false for numbers with exponent', ->
            assert.is utils.isInteger(3.2), false
            assert.is utils.isInteger(-5.1), false
            assert.is utils.isInteger(0.3), false

        it 'returns false for not numbers type', ->
            assert.is utils.isInteger(null), false
            assert.is utils.isInteger(true), false
            assert.is utils.isInteger(undefined), false
            assert.is utils.isInteger(->), false
            assert.is utils.isInteger({}), false
            assert.is utils.isInteger(Object(4)), false
            assert.is utils.isInteger('4'), false

    describe 'isPrimitive()', ->
        it 'returns true for a null, string, number boolean or an undefined', ->
            assert.is utils.isPrimitive(null), true
            assert.is utils.isPrimitive('a'), true
            assert.is utils.isPrimitive(12.2), true
            assert.is utils.isPrimitive(true), true
            assert.is utils.isPrimitive(undefined), true

        it 'returns false for other types', ->
            assert.is utils.isPrimitive({}), false
            assert.is utils.isPrimitive([]), false
            assert.is utils.isPrimitive(->), false
            assert.is utils.isPrimitive(Object(4)), false

    describe 'isObject()', ->
        it 'returns true if the given value is an array of an object', ->
            assert.is utils.isObject([]), true
            assert.is utils.isObject({}), true
            assert.is utils.isObject(Object.create(null)), true
            assert.is utils.isObject(Object.create({a: 1})), true

        it 'returns false for the given null', ->
            assert.is utils.isObject(null), false

        it 'returns false for types different than object', ->
            assert.is utils.isObject(->), false
            assert.is utils.isObject(false), false
            assert.is utils.isObject(undefined), false
            assert.is utils.isObject('a'), false

    describe 'isPlainObject()', ->
        it 'returns true for the given object with no prototype', ->
            assert.is utils.isPlainObject(Object.create(null)), true

        it 'returns true for the given object with standard prototype', ->
            assert.is utils.isPlainObject({}), true
            assert.is utils.isPlainObject(Object.create(Object.prototype)), true

        it 'returns false for object with custom prototype', ->
            class A
            assert.is utils.isPlainObject(Object.create({a: 1})), false
            assert.is utils.isPlainObject(new A), false

        it 'returns false for the given null', ->
            assert.is utils.isPlainObject(null), false

        it 'returns false for types different than object', ->
            assert.is utils.isPlainObject(->), false
            assert.is utils.isPlainObject(false), false
            assert.is utils.isPlainObject(undefined), false
            assert.is utils.isPlainObject('a'), false

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
        it 'uppercases first character', ->
            assert.is utils.capitalize('abc'), 'Abc'
            assert.is utils.capitalize('abc_def'), 'Abc_def'
            assert.is utils.capitalize('Abc_def'), 'Abc_def'
            assert.is utils.capitalize('1abc'), '1abc'
            assert.is utils.capitalize(''), ''

    describe 'addSlashes()', ->
        # TODO

    describe 'uid()', ->
        # TODO

    describe 'tryFunction()', ->
        # TODO

    describe 'catchError()', ->
        # TODO

    describe 'bindFunctionContext()', ->
        it 'returns bound function', ->
            ctx = null
            args = null
            handleFunc = (localCtx, localArgs...) ->
                ctx = localCtx
                args = localArgs

            boundCtx = a: 2
            wrongCtx = wrong: 1

            test = (func) ->
                funcArgs = []
                for i in [0...func.length] by 1
                    funcArgs.push i

                utils.bindFunctionContext(func, boundCtx).apply wrongCtx, funcArgs
                assert.is ctx, boundCtx
                assert.isEqual args, funcArgs

            test ((a) -> handleFunc(@, arguments...))
            test ((a, b) -> handleFunc(@, arguments...))
            test ((a, b, c) -> handleFunc(@, arguments...))
            test ((a, b, c, d) -> handleFunc(@, arguments...))
            test ((a, b, c, d, e) -> handleFunc(@, arguments...))
            test ((a, b, c, d, e, f) -> handleFunc(@, arguments...))
            test ((a, b, c, d, e, f, g) -> handleFunc(@, arguments...))
            test ((a, b, c, d, e, f, g, h) -> handleFunc(@, arguments...))
            test ((a, b, c, d, e, f, g, h, i) -> handleFunc(@, arguments...))

    describe 'errorToObject()', ->
        it 'returns error name and message', ->
            message = 'random message'
            error = new TypeError message
            object = utils.errorToObject error
            assert.is object.name, 'TypeError'
            assert.is object.message, message

        it 'merges custom error properties', ->
            error = new Error
            error.prop = 'a'
            object = utils.errorToObject error
            assert.is object.prop, 'a'

        it 'returned object can be stringified', ->
            error = new TypeError 'error message'
            error.custom = 2
            object = utils.errorToObject error
            json = JSON.parse JSON.stringify object

            # line and column are optional
            delete json.line
            delete json.column

            assert.isEqual json,
                name: 'TypeError'
                message: 'error message'
                custom: 2

    describe 'getOwnProperties()', ->
        # TODO

    describe 'isEqual()', ->
        it 'returns proper value of two objects given', ->
            assert.is utils.isEqual({a: 1}, {a: 1}), true
            assert.is utils.isEqual({a: 1}, {b: 1}), false
            assert.is utils.isEqual({a: 1}, {a: 2}), false

        it 'returns proper value of two arrays given', ->
            assert.is utils.isEqual([1, 2], [1, 2]), true
            assert.is utils.isEqual([1, 2], [1]), false
            assert.is utils.isEqual([2, 1], [1, 2]), false

        it 'test objects deeply', ->
            assert.is utils.isEqual({a: [{b: 1}]}, {a: [{b: 1}]}), true
            assert.is utils.isEqual({a: [{b: 1}]}, {a: [{b: 2}]}), false

        it 'compareFunction is used to test primitive values', ->
            funcArgs = []
            compareFunction = (args...) -> funcArgs.push args
            utils.isEqual({a: [{b: 1}]}, {a: [{b: 2}]}, compareFunction)
            expected = [[1, 2]]
            assert.is JSON.stringify(funcArgs), JSON.stringify(expected)

        it 'maxDeep specifies how deep objects should be tested', ->
            assert.is utils.isEqual({a: [{b: 1}]}, {a: [{b: 2}]}, 2), true
            assert.is utils.isEqual({a: [{b: 1}]}, {a: [{b: 2}]}, 3), false

    describe 'kebabToCamel()', ->
        it 'returns given string as camel case', ->
            assert.is utils.kebabToCamel('ab-cd-23-efg'), 'abCd23Efg'

    describe 'camelToKebab()', ->
        it 'returns given string as kebab case', ->
            assert.is utils.camelToKebab('abCd23EfgAbc'), 'ab-cd23efg-abc'
