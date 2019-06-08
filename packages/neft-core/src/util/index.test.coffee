'use strict'

util = require './'

describe 'is()', ->
    it 'returns true if the given values are the same', ->
        assert.is util.is('a', 'a'), true
        assert.is util.is(1, 1), true
        assert.is util.is(undefined, undefined), true
        assert.is util.is(null, null), true
        assert.is util.is(true, true), true
        assert.is util.is(obj = {}, obj), true
        assert.is util.is((func = ->), func), true

    it 'returns false if the given values are different', ->
        assert.is util.is('a', 'b'), false
        assert.is util.is(1, 2), false
        assert.is util.is(null, undefined), false
        assert.is util.is(false, true), false
        assert.is util.is({}, {}), false
        assert.is util.is((->), ->), false

    it 'returns true if two NaNs have been given', ->
        assert.is util.is(NaN, NaN), true

    it 'returns false for negative zero and positive zero comparison', ->
        assert.is util.is(-0, 0), false

    return

describe 'isFloat()', ->
    it 'returns true for finite numbers', ->
        assert.is util.isFloat(10), true
        assert.is util.isFloat(10.5), true
        assert.is util.isFloat(-23.12), true
        assert.is util.isFloat(0), true

    it 'returns false for not infinite numbers', ->
        assert.is util.isFloat(NaN), false
        assert.is util.isFloat(Infinity), false
        assert.is util.isFloat(-Infinity), false

    it 'returns false for not numbers type', ->
        assert.is util.isFloat(null), false
        assert.is util.isFloat(true), false
        assert.is util.isFloat(undefined), false
        assert.is util.isFloat(->), false
        assert.is util.isFloat({}), false
        assert.is util.isFloat(Object(4)), false
        assert.is util.isFloat('4'), false

    return

describe 'isInteger()', ->
    it 'returns true for finite numbers with no exponent', ->
        assert.is util.isInteger(3), true
        assert.is util.isInteger(-5), true
        assert.is util.isInteger(0), true

    it 'returns false for not finite numbers', ->
        assert.is util.isInteger(NaN), false
        assert.is util.isInteger(Infinity), false
        assert.is util.isInteger(-Infinity), false

    it 'returns false for numbers with exponent', ->
        assert.is util.isInteger(3.2), false
        assert.is util.isInteger(-5.1), false
        assert.is util.isInteger(0.3), false

    it 'returns false for not numbers type', ->
        assert.is util.isInteger(null), false
        assert.is util.isInteger(true), false
        assert.is util.isInteger(undefined), false
        assert.is util.isInteger(->), false
        assert.is util.isInteger({}), false
        assert.is util.isInteger(Object(4)), false
        assert.is util.isInteger('4'), false

    return

describe 'isPrimitive()', ->
    it 'returns true for a null, string, number boolean or an undefined', ->
        assert.is util.isPrimitive(null), true
        assert.is util.isPrimitive('a'), true
        assert.is util.isPrimitive(12.2), true
        assert.is util.isPrimitive(true), true
        assert.is util.isPrimitive(undefined), true

    it 'returns false for other types', ->
        assert.is util.isPrimitive({}), false
        assert.is util.isPrimitive([]), false
        assert.is util.isPrimitive(->), false
        assert.is util.isPrimitive(Object(4)), false

    return

describe 'isObject()', ->
    it 'returns true if the given value is an array of an object', ->
        assert.is util.isObject([]), true
        assert.is util.isObject({}), true
        assert.is util.isObject(Object.create(null)), true
        assert.is util.isObject(Object.create({a: 1})), true

    it 'returns false for the given null', ->
        assert.is util.isObject(null), false

    it 'returns false for types different than object', ->
        assert.is util.isObject(->), false
        assert.is util.isObject(false), false
        assert.is util.isObject(undefined), false
        assert.is util.isObject('a'), false

    return

describe 'isPlainObject()', ->
    it 'returns true for the given object with no prototype', ->
        assert.is util.isPlainObject(Object.create(null)), true

    it 'returns true for the given object with standard prototype', ->
        assert.is util.isPlainObject({}), true
        assert.is util.isPlainObject(Object.create(Object.prototype)), true

    it 'returns false for object with custom prototype', ->
        class A
        assert.is util.isPlainObject(Object.create({a: 1})), false
        assert.is util.isPlainObject(new A), false

    it 'returns false for the given null', ->
        assert.is util.isPlainObject(null), false

    it 'returns false for types different than object', ->
        assert.is util.isPlainObject(->), false
        assert.is util.isPlainObject(false), false
        assert.is util.isPlainObject(undefined), false
        assert.is util.isPlainObject('a'), false

    return

describe 'isArguments()', ->
    # TODO

describe 'merge()', ->
    # TODO

describe 'mergeAll()', ->
    # TODO

describe 'mergeDeep()', ->
    it 'merges objects deeply', ->
        source = {a: {aa: '', ac: 0}, c: 4}
        obj = {a: {aa: 1, ab: 2}, b: 3}
        expected = {a: {aa: 1, ab: 2, ac: 0}, b: 3, c: 4}
        assert.isEqual util.mergeDeep(source, obj), expected

    it 'merges lists', ->
        source = [1, 2]
        obj = [3]
        expected = [1, 2, 3]
        assert.isEqual util.mergeDeep(source, obj), expected

    it 'merges lists deeply', ->
        source = {a: [1, 2]}
        obj = {a: [3]}
        expected = {a: [1, 2, 3]}
        assert.isEqual util.mergeDeep(source, obj), expected

    return

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
        assert.is util.capitalize('abc'), 'Abc'
        assert.is util.capitalize('abc_def'), 'Abc_def'
        assert.is util.capitalize('Abc_def'), 'Abc_def'
        assert.is util.capitalize('1abc'), '1abc'
        assert.is util.capitalize(''), ''

    return

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

            util.bindFunctionContext(func, boundCtx).apply wrongCtx, funcArgs
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

    return

describe 'errorToObject()', ->
    it 'returns error name and message', ->
        message = 'random message'
        error = new TypeError message
        object = util.errorToObject error
        assert.is object.name, 'TypeError'
        assert.is object.message, message

    it 'merges custom error properties', ->
        error = new Error
        error.prop = 'a'
        object = util.errorToObject error
        assert.is object.prop, 'a'

    it 'returned object can be stringified', ->
        error = new TypeError 'error message'
        error.custom = 2
        object = util.errorToObject error
        json = JSON.parse JSON.stringify object

        # line and column are optional
        delete json.line
        delete json.column

        assert.isEqual json,
            name: 'TypeError'
            message: 'error message'
            custom: 2

    return

describe 'getOwnProperties()', ->
    # TODO

describe 'isEqual()', ->
    it 'returns proper value of two objects given', ->
        assert.is util.isEqual({a: 1}, {a: 1}), true
        assert.is util.isEqual({a: 1}, {b: 1}), false
        assert.is util.isEqual({a: 1}, {a: 2}), false

    it 'returns proper value of two arrays given', ->
        assert.is util.isEqual([1, 2], [1, 2]), true
        assert.is util.isEqual([1, 2], [1]), false
        assert.is util.isEqual([2, 1], [1, 2]), false

    it 'test objects deeply', ->
        assert.is util.isEqual({a: [{b: 1}]}, {a: [{b: 1}]}), true
        assert.is util.isEqual({a: [{b: 1}]}, {a: [{b: 2}]}), false

    it 'compareFunction is used to test primitive values', ->
        funcArgs = []
        compareFunction = (args...) -> funcArgs.push args
        util.isEqual({a: [{b: 1}]}, {a: [{b: 2}]}, compareFunction)
        expected = [[1, 2]]
        assert.is JSON.stringify(funcArgs), JSON.stringify(expected)

    it 'maxDeep specifies how deep objects should be tested', ->
        assert.is util.isEqual({a: [{b: 1}]}, {a: [{b: 2}]}, 2), true
        assert.is util.isEqual({a: [{b: 1}]}, {a: [{b: 2}]}, 3), false

    return

describe 'snakeToCamel()', ->
    it 'returns given string as camel case', ->
        assert.is util.snakeToCamel('ab_cd_23_efg'), 'abCd23Efg'

    return

describe 'kebabToCamel()', ->
    it 'returns given string as camel case', ->
        assert.is util.kebabToCamel('ab-cd-23-efg'), 'abCd23Efg'

    return

describe 'camelToKebab()', ->
    it 'returns given string as kebab case', ->
        assert.is util.camelToKebab('abCd23EfgAbc'), 'ab-cd23efg-abc'

    return
