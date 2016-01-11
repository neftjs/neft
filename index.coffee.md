Assert @library
======

**JavaScript so dynamic**

This module is used to write tests.

Access it with:
```
var assert = require('assert');
```

	'use strict'

	utils = require 'utils'

assert(*Boolean* expression, [*String* message])
------------------------------------------------

	assert = module.exports = (expr, msg) ->
		unless expr
			assert.fail expr, true, msg, '==', assert

*AssertionError* AssertionError()
---------------------------------

Access it with:
```
var assert = require('assert');
var AssertionError = assert.AssertionError;
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

*assert* assert.scope(*String* message)
---------------------------------------

This function returns standard *assert* function with all features.

All fail messages will be prefixed by given *message*.

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

assert.ok(*Boolean* expression, [*String* message])
---------------------------------------------------

	assert.ok = assert

assert.notOk(*Boolean* expression, [*String* message])
------------------------------------------------------

	assert.notOk = (expr, msg) ->
		if expr
			@fail expr, true, msg, '!=', assert.notOk

assert.is(*Any* actual, *Any* expected, [*String* message])
-----------------------------------------------------------

	assert.is = (actual, expected, msg) ->
		unless utils.is actual, expected
			@fail actual, expected, msg, '===', assert.is

assert.isNot(*Any* actual, *Any* expected, [*String* message])
--------------------------------------------------------------

	assert.isNot = (actual, expected, msg) ->
		if utils.is actual, expected
			@fail actual, expected, msg, '!==', assert.isNot

assert.isDefined(*Any* value, [*String* message])
-------------------------------------------------

This function checks whether given *value* is *undefined* or *null*.

	assert.isDefined = (val, msg) ->
		unless val?
			@fail val, null, msg, '!=', assert.isDefined

assert.isNotDefined(*Any* value, [*String* message])
----------------------------------------------------

	assert.isNotDefined = (val, msg) ->
		if val?
			@fail val, null, msg, '==', assert.isNotDefined

assert.isPrimitive(*Any* value, [*String* message])
---------------------------------------------------

This function checks whether given value is a primitive value.

Check [utils.isPrimitive()][] for details.

	assert.isPrimitive = (val, msg) ->
		unless utils.isPrimitive val
			@fail val, 'primitive', msg, 'is', assert.isPrimitive

assert.isNotPrimitive(*Any* value, [*String* message])
------------------------------------------------------

	assert.isNotPrimitive = (val, msg) ->
		if utils.isPrimitive val
			@fail val, 'primitive', msg, 'isn\'t', assert.isNotPrimitive

assert.isString(*String* value, [*String* message])
---------------------------------------------------

	assert.isString = (val, msg) ->
		if typeof val isnt 'string'
			@fail val, 'string', msg, 'is', assert.isString

assert.isNotString(*Any* value, [*String* message])
------------------------------------------------------

	assert.isNotString = (val, msg) ->
		if typeof val is 'string'
			@fail val, 'string', msg, 'isn\'t', assert.isNotString

assert.isFloat(*Float* value, [*String* message])
-------------------------------------------------

	assert.isFloat = (val, msg) ->
		unless utils.isFloat val
			@fail val, 'float', msg, 'is', assert.isFloat

assert.isNotFloat(*Any* value, [*String* message])
----------------------------------------------------

	assert.isNotFloat = (val, msg) ->
		if utils.isFloat val
			@fail val, 'float', msg, 'isn\'t', assert.isNotFloat

assert.isInteger(*Integer* value, [*String* message])
-----------------------------------------------------

	assert.isInteger = (val, msg) ->
		unless utils.isInteger val
			@fail val, 'integer', msg, 'is', assert.isInteger

assert.isNotInteger(*Any* value, [*String* message])
--------------------------------------------------------

	assert.isNotInteger = (val, msg) ->
		if utils.isInteger val
			@fail val, 'integer', msg, 'isn\'t', assert.isNotInteger

assert.isBoolean(*Boolean* value, [*String* message])
-----------------------------------------------------

	assert.isBoolean = (val, msg) ->
		if typeof val isnt 'boolean'
			@fail val, 'boolean', msg, 'is', assert.isBoolean

assert.isNotBoolean(*Any* value, [*String* message])
-----------------------------------------------------

	assert.isNotBoolean = (val, msg) ->
		if typeof val is 'boolean'
			@fail val, 'boolean', msg, 'isn\'t', assert.isNotBoolean

assert.isFunction(*Function* value, [*String* message])
-------------------------------------------------------

	assert.isFunction = (val, msg) ->
		if typeof val isnt 'function'
			@fail val, 'function', msg, 'is', assert.isFunction

assert.isFunction(*Any* value, [*String* message])
--------------------------------------------------

	assert.isNotFunction = (val, msg) ->
		if typeof val is 'function'
			@fail val, 'function', msg, 'isn\'t', assert.isNotFunction

assert.isObject(*Object* value, [*String* message])
---------------------------------------------------

	assert.isObject = (val, msg) ->
		if val is null or typeof val isnt 'object'
			@fail val, 'object', msg, 'is', assert.isObject

assert.isNotObject(*Any* value, [*String* message])
---------------------------------------------------

	assert.isNotObject = (val, msg) ->
		if val isnt null and typeof val is 'object'
			@fail val, 'object', msg, 'isn\'t', assert.isNotObject

assert.isPlainObject(*PlainObject* value, [*String* message])
-------------------------------------------------------------

This function checks whether given value is a plain object.

Check [utils.isPlainObject()][] for details.

	assert.isPlainObject = (val, msg) ->
		unless utils.isPlainObject val
			@fail val, 'plain object', msg, 'is', assert.isPlainObject

assert.isNotPlainObject(*Any* value, [*String* message])
--------------------------------------------------------

	assert.isNotPlainObject = (val, msg) ->
		if utils.isPlainObject val
			@fail val, 'plain object', msg, 'isn\'t', assert.isNotPlainObject

assert.isArray(*Array* value, [*String* message])
-------------------------------------------------

	assert.isArray = (val, msg) ->
		unless Array.isArray val
			@fail val, 'array', msg, 'is', assert.isArray

assert.isNotArray(*Any* value, [*String* message])
--------------------------------------------------

	assert.isNotArray = (val, msg) ->
		if Array.isArray val
			@fail val, 'array', msg, 'isn\'t', assert.isNotArray

assert.isEqual(*Any* value1, *Any* value2, [*String* message, *Object* options])
--------------------------------------------------------------------------------

This function checks whether given values are equal.

Check [utils.isEqual()][] for details.

**options** accepts:
 - *Integer* maxDeep.

	assert.isEqual = (val1, val2, msg, opts) ->
		if typeof msg is 'object'
			opts = msg
			msg = undefined
		unless utils.isEqual val1, val2, opts?.maxDeep
			@fail val1, val2, msg, 'equal', assert.isEqual

assert.isNotEqual(*Any* value1, *Any* value2, [*String* message, *Object* options])
-----------------------------------------------------------------------------------

	assert.isNotEqual = (val1, val2, msg, opts) ->
		if typeof msg is 'object'
			opts = msg
			msg = undefined
		if utils.isEqual val1, val2, opts?.maxDeep
			@fail val1, val2, msg, 'isn\'t equal', assert.isNotEqual

assert.instanceOf(*Object* object, *Function* constructor, [*String* message])
------------------------------------------------------------------------------

	assert.instanceOf = (val, ctor, msg) ->
		unless val instanceof ctor
			ctorName = ctor.__path__ or ctor.__name__ or ctor.name or ctor
			@fail val, ctorName, msg, 'instanceof', assert.instanceOf

assert.notInstanceOf(*Any* object, *Function* constructor, [*String* message])
------------------------------------------------------------------------------

	assert.notInstanceOf = (val, ctor, msg) ->
		if val instanceof ctor
			ctorName = ctor.__path__ or ctor.__name__ or ctor.name or ctor
			@fail val, ctorName, msg, 'instanceof', assert.notInstanceOf

assert.lengthOf(*Any* value, *Integer* length, [*String* message])
------------------------------------------------------------------

	assert.lengthOf = (val, length, msg) ->
		unless val?.length is length
			@fail val, length, msg, '.length ===', assert.lengthOf

assert.notLengthOf(*Any* value, *Integer* length, [*String* message])
---------------------------------------------------------------------

	assert.notLengthOf = (val, length, msg) ->
		if val?.length is length
			@fail val, length, msg, '.length !==', assert.notLengthOf

assert.operator(*Any* value1, *String* operator, *Any* value2, [*String* message])
----------------------------------------------------------------------------------

This function is used to compare two values.

```
assert.operator(2, '>', 1);
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
				throw "Unexpected operator `#{operator}`"

		unless pass
			@fail val1, val2, msg, operator, assert.operator

assert.match(*Any* value, *RegExp* regexp, [*String* message])
--------------------------------------------------------------

This function is used to check whether a given value tests given regexp.

```
assert.match('12', /[0-9]+/);
```

	assert.match = (val, regexp, msg) ->
		unless regexp.test val
			@fail val, regexp, msg, 'match', assert.match

assert.notMatch(*Any* value, *RegExp* regexp, [*String* message])
-----------------------------------------------------------------

	assert.notMatch = (val, regexp, msg) ->
		if regexp.test val
			@fail val, regexp, msg, 'not match', assert.match
