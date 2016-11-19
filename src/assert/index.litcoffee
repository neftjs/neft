# Assertions

Access it with:
```javascript
const { assert } = Neft;
```

    'use strict'

    utils = require 'src/utils'

# assert(*Boolean* expression, [*String* message])

Throws *AssertionError* if the given *expression* is falsy.

    assert = module.exports = (expr, msg) ->
        unless expr
            assert.fail expr, true, msg, '==', assert

## **Class** assert.AssertionError()

Access it with:
```javascript
const { AssertionError } = Neft.assert;
```

    assert.AssertionError = class AssertionError extends Error
        @generateMessage = (error, msg) ->
            standardMsg = "#{error.actual} #{error.operator} #{error.expected}"

            if ///\.\.\.$///.test msg
                msgDef = msg.slice(0, -3).split(' ')

                msgDef[2] ?= ''
                msgDef[2] += ''

                where = "#{error.scope}#{msgDef[0]}"

                "#{standardMsg}\n" +
                "  #{where} #{msgDef[1]}#{msgDef[2]} (got `#{error.actual}`, type #{typeof error.actual})" +
                ", but `#{error.operator} #{error.expected}` asserted;\n" +
                "  Documentation: http://neft.io/docs/#{where}\n"
            else if msg
                msg
            else
                standardMsg

        constructor: (opts) ->
            @name = 'AssertionError'
            @actual = opts.actual
            @expected = opts.expected
            @operator = opts.operator
            @scope = opts.scope
            @message = AssertionError.generateMessage @, opts.message

            Error.captureStackTrace? @, opts.stackStartFunction

            # TODO: fix this issues in platform runtimes
            if utils.isAndroid
                console.error @stack or @message
            else if utils.isQt
                console.trace()

    createFailFunction = (assert) ->
        func = (actual, expected, msg, operator, stackStartFunction) ->
            throw new assert.AssertionError
                actual: actual
                expected: expected
                message: msg
                operator: operator
                scope: assert._scope
                stackStartFunction: stackStartFunction or func

## *assert* assert.scope(*String* message)

Returns new assert namespace where all failues are prefixed by the given *message*.

    assert.scope = (msg) ->
        msg = "#{@_scope}#{msg}"

        func = (expr, msg) ->
            assert expr, msg
        utils.merge func, assert
        func.fail = createFailFunction func
        func._scope = msg
        func

    assert.fail = createFailFunction assert

    assert._scope = ''

## assert.ok(*Boolean* expression, [*String* message])

Link to the main assert function.

Throws an error if the given *expression* is falsy.

    assert.ok = assert

## assert.notOk(*Boolean* expression, [*String* message])

Throws an error if the given *expression* is truthy.

    assert.notOk = (expr, msg) ->
        if expr
            @fail expr, true, msg, '!=', assert.notOk

## assert.is(*Any* actual, *Any* expected, [*String* message])

Throws an error if the given *actual* is not the same as *expected*.

Strict comparison operator is used in this operation (`===`).
Types needs to be the same.
Read more about [comparison operators in JavaScript](https://developer.mozilla.org/en-US/docs
/Web/JavaScript/Reference/Operators/Comparison_Operators).

    assert.is = (actual, expected, msg) ->
        unless utils.is actual, expected
            @fail actual, expected, msg, '===', assert.is

## assert.isNot(*Any* actual, *Any* expected, [*String* message])

Throws an error if the given *actual* is the same as *expected*.

Strict comparison operator is used in this operation (`===`).

    assert.isNot = (actual, expected, msg) ->
        if utils.is actual, expected
            @fail actual, expected, msg, '!==', assert.isNot

## assert.isDefined(*Any* value, [*String* message])

Throws an error if the given *value* is `null` or `undefined`.

    assert.isDefined = (val, msg) ->
        unless val?
            @fail val, null, msg, '!=', assert.isDefined

## assert.isNotDefined(*Any* value, [*String* message])

Throws an error if the given *value* is not `null` or `undefined`.

    assert.isNotDefined = (val, msg) ->
        if val?
            @fail val, null, msg, '==', assert.isNotDefined

## assert.isPrimitive(*Any* value, [*String* message])

Throws an error if the given *value* is not a primitive value.

Primitive value must be `null`, string, number, boolean or `undefined`.

    assert.isPrimitive = (val, msg) ->
        unless utils.isPrimitive val
            @fail val, 'primitive', msg, 'is', assert.isPrimitive

## assert.isNotPrimitive(*Any* value, [*String* message])

Throws an error if the given *value* if a primitive value.

Primitive value must be `null`, string, number, boolean or `undefined`.

    assert.isNotPrimitive = (val, msg) ->
        if utils.isPrimitive val
            @fail val, 'primitive', msg, 'isn\'t', assert.isNotPrimitive

## assert.isString(*String* value, [*String* message])

Throws an error if the given *value* is not a string.

    assert.isString = (val, msg) ->
        if typeof val isnt 'string'
            @fail val, 'string', msg, 'is', assert.isString

## assert.isNotString(*Any* value, [*String* message])

Throws an error if the given *value* is a string.

    assert.isNotString = (val, msg) ->
        if typeof val is 'string'
            @fail val, 'string', msg, 'isn\'t', assert.isNotString

## assert.isFloat(*Float* value, [*String* message])

Throws an error if the given *value* is not a float number.

Float number needs to be finite and may be an integer.

    assert.isFloat = (val, msg) ->
        unless utils.isFloat val
            @fail val, 'float', msg, 'is', assert.isFloat

## assert.isNotFloat(*Any* value, [*String* message])

Throws an error if the given *value* is a float number.

Float number needs to be finite and may be an integer.

    assert.isNotFloat = (val, msg) ->
        if utils.isFloat val
            @fail val, 'float', msg, 'isn\'t', assert.isNotFloat

## assert.isInteger(*Integer* value, [*String* message])

Throws an error if the given *value* is not an integer.

    assert.isInteger = (val, msg) ->
        unless utils.isInteger val
            @fail val, 'integer', msg, 'is', assert.isInteger

## assert.isNotInteger(*Any* value, [*String* message])

Throws an error if the given *value* is an integer.

    assert.isNotInteger = (val, msg) ->
        if utils.isInteger val
            @fail val, 'integer', msg, 'isn\'t', assert.isNotInteger

## assert.isBoolean(*Boolean* value, [*String* message])

Throws an error if the given *value* is not a boolean.

    assert.isBoolean = (val, msg) ->
        if typeof val isnt 'boolean'
            @fail val, 'boolean', msg, 'is', assert.isBoolean

## assert.isNotBoolean(*Any* value, [*String* message])

Throws an error if the given *value* is a boolean.

    assert.isNotBoolean = (val, msg) ->
        if typeof val is 'boolean'
            @fail val, 'boolean', msg, 'isn\'t', assert.isNotBoolean

## assert.isFunction(*Function* value, [*String* message])

Throws an error if the given *value* is not a function.

    assert.isFunction = (val, msg) ->
        if typeof val isnt 'function'
            @fail val, 'function', msg, 'is', assert.isFunction

## assert.isNotFunction(*Any* value, [*String* message])

Throws an error if the given *value* is a function.

    assert.isNotFunction = (val, msg) ->
        if typeof val is 'function'
            @fail val, 'function', msg, 'isn\'t', assert.isNotFunction

## assert.isObject(*Object* value, [*String* message])

Throws an error if the given *value* is not an object.

Arrays are objects.

`null` is not an object.

    assert.isObject = (val, msg) ->
        if val is null or typeof val isnt 'object'
            @fail val, 'object', msg, 'is', assert.isObject

## assert.isNotObject(*Any* value, [*String* message])

Throws an error if the given *value* is an object.

Arrays are objects.

`null` is not an object.

    assert.isNotObject = (val, msg) ->
        if val isnt null and typeof val is 'object'
            @fail val, 'object', msg, 'isn\'t', assert.isNotObject

## assert.isPlainObject(*PlainObject* value, [*String* message])

Throws an error if the given *value* is not a plain object.

Plain object in an object with no prototype or direct standard `Object` prototype.

Arrays and instances of classes are not plain objects.

    assert.isPlainObject = (val, msg) ->
        unless utils.isPlainObject val
            @fail val, 'plain object', msg, 'is', assert.isPlainObject

## assert.isNotPlainObject(*Any* value, [*String* message])

Throws an error if the given *value* is a plain object.

Plain object in an object with no prototype or direct standard `Object` prototype.

Arrays and instances of classes are not plain objects.

    assert.isNotPlainObject = (val, msg) ->
        if utils.isPlainObject val
            @fail val, 'plain object', msg, 'isn\'t', assert.isNotPlainObject

## assert.isArray(*Array* value, [*String* message])

Throws an error if the given *value* is not an array.

Typed arrays are not arrays.

    assert.isArray = (val, msg) ->
        unless Array.isArray val
            @fail val, 'array', msg, 'is', assert.isArray

## assert.isNotArray(*Any* value, [*String* message])

Throws an error if the given *value* is an array.

    assert.isNotArray = (val, msg) ->
        if Array.isArray val
            @fail val, 'array', msg, 'isn\'t', assert.isNotArray

## assert.isEqual(*Any* value1, *Any* value2, [*String* message, *Object* options])

Throws an error if the given values are not equal.

Objects and arrays are tested recursively.

Maximum deepness may be specified by *options.maxDeep*.
Default value is `Infinity`.

    assert.isEqual = (val1, val2, msg, opts) ->
        if typeof msg is 'object'
            opts = msg
            msg = undefined
        unless utils.isEqual val1, val2, opts?.maxDeep
            @fail val1, val2, msg, 'equal', assert.isEqual

## assert.isNotEqual(*Any* value1, *Any* value2, [*String* message, *Object* options])

Throws an error if the given values are equal.

    assert.isNotEqual = (val1, val2, msg, opts) ->
        if typeof msg is 'object'
            opts = msg
            msg = undefined
        if utils.isEqual val1, val2, opts?.maxDeep
            @fail val1, val2, msg, 'isn\'t equal', assert.isNotEqual

## assert.instanceOf(*Object* object, *Function* constructor, [*String* message])

Throws an error if the given *object* is not an instance of the given *constructor*.

    assert.instanceOf = (val, ctor, msg) ->
        unless val instanceof ctor
            ctorName = ctor.__path__ or ctor.__name__ or ctor.name or ctor
            @fail val, ctorName, msg, 'instanceof', assert.instanceOf

## assert.notInstanceOf(*Any* object, *Function* constructor, [*String* message])

Throws an error if the given *object* is an instance of the given *constructor*.

    assert.notInstanceOf = (val, ctor, msg) ->
        if val instanceof ctor
            ctorName = ctor.__path__ or ctor.__name__ or ctor.name or ctor
            @fail val, ctorName, msg, 'instanceof', assert.notInstanceOf

## assert.lengthOf(*Any* value, *Integer* length, [*String* message])

Throws an error if the given *value* object `length` is not equal the given *length*.

    assert.lengthOf = (val, length, msg) ->
        unless val?.length is length
            @fail val, length, msg, '.length ===', assert.lengthOf

## assert.notLengthOf(*Any* value, *Integer* length, [*String* message])

Throws an error if the given *value* object `length` is equal the given *length*.

    assert.notLengthOf = (val, length, msg) ->
        if val?.length is length
            @fail val, length, msg, '.length !==', assert.notLengthOf

## assert.operator(*Any* value1, *String* operator, *Any* value2, [*String* message])

Throws an error if the given *operator* comparison is falsy on the given values.

*operator* is a string as follow: `>`, `>=`, `<`, or `<=`.
*TypeError* is thrown if unexpected *operator* has been given.

Example:

```javascript
assert.operator(2, '>', 1); // true
assert.operator(2, '<=', 1); // AssertionError
```

    assert.operator = (val1, operator, val2, msg) ->
        pass = switch operator
            when '>'
                val1 > val2
            when '>='
                val1 >= val2
            when '<'
                val1 < val2
            when '<='
                val1 <= val2
            else
                throw new TypeError "Unexpected operator `#{operator}`"

        unless pass
            @fail val1, val2, msg, operator, assert.operator

## assert.match(*Any* value, *RegExp* regexp, [*String* message])

Throws an error if the given *regexp* does not test on the given *value*.

Example:

```javascript
assert.match('12', /[0-9]+/); // true
```

    assert.match = (val, regexp, msg) ->
        unless regexp.test val
            @fail val, regexp, msg, 'match', assert.match

## assert.notMatch(*Any* value, *RegExp* regexp, [*String* message])

Throws an error if the given *regexp* tests on the given *value*.

    assert.notMatch = (val, regexp, msg) ->
        if regexp.test val
            @fail val, regexp, msg, 'not match', assert.match

# Glossary

- [assert](#assert)
- [AssertionError](#assert.AssertionError)
