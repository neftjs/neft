'use strict'

utils = require 'utils'

assert = module.exports = (expr, msg) ->
	unless expr
		fail expr, true, msg, '==', assert

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

createFailFunction = (assert) ->
	func = (actual, expected, msg, operator, stackStartFunction) ->
		throw new assert.AssertionError
			actual: actual
			expected: expected
			message: msg
			operator: operator
			scope: assert._scope
			stackStartFunction: stackStartFunction or func

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
assert.ok = assert

assert.notOk = (expr, msg) ->
	if expr
		@fail expr, true, msg, '!=', asset.notOk

assert.is = (actual, expected, msg) ->
	unless utils.is actual, expected
		@fail actual, expected, msg, '===', assert.is

assert.isNot = (actual, expected, msg) ->
	if utils.is actual, expected
		@fail actual, expected, msg, '!==', assert.isNot

assert.isDefined = (val, msg) ->
	unless val?
		@fail val, null, msg, '!=', assert.isDefined

assert.isNotDefined = (val, msg) ->
	if val?
		@fail val, null, msg, '==', assert.isNotDefined

assert.isPrimitive = (val, msg) ->
	unless utils.isPrimitive val
		@fail val, 'primitive', msg, 'is', assert.isPrimitive

assert.isNotPrimitive = (val, msg) ->
	if utils.isPrimitive val
		@fail val, 'primitive', msg, 'isn\'t', assert.isNotPrimitive

assert.isString = (val, msg) ->
	if typeof val isnt 'string'
		@fail val, 'string', msg, 'is', assert.isString

assert.isNotString = (val, msg) ->
	if typeof val is 'string'
		@fail val, 'string', msg, 'isn\'t', assert.isNotString

assert.isFloat = (val, msg) ->
	unless utils.isFloat val
		@fail val, 'float', msg, 'is', assert.isFloat

assert.isNotFloat = (val, msg) ->
	if utils.isFloat val
		@fail val, 'float', msg, 'isn\'t', assert.isNotFloat

assert.isInteger = (val, msg) ->
	unless utils.isInteger val
		@fail val, 'integer', msg, 'is', assert.isInteger

assert.isNotInteger = (val, msg) ->
	if utils.isInteger val
		@fail val, 'integer', msg, 'isn\'t', assert.isNotInteger

assert.isBoolean = (val, msg) ->
	if typeof val isnt 'boolean'
		@fail val, 'boolean', msg, 'is', assert.isBoolean

assert.isNotBoolean = (val, msg) ->
	if typeof val is 'boolean'
		@fail val, 'boolean', msg, 'isn\'t', assert.isNotBoolean

assert.isFunction = (val, msg) ->
	if typeof val isnt 'function'
		@fail val, 'function', msg, 'is', assert.isFunction

assert.isNotFunction = (val, msg) ->
	if typeof val is 'function'
		@fail val, 'function', msg, 'isn\'t', assert.isNotFunction

assert.isObject = (val, msg) ->
	if val is null or typeof val isnt 'object'
		@fail val, 'object', msg, 'is', assert.isObject

assert.isNotObject = (val, msg) ->
	if val isnt null and typeof val is 'object'
		@fail val, 'object', msg, 'isn\'t', assert.isNotObject

assert.isPlainObject = (val, msg) ->
	unless utils.isPlainObject val
		@fail val, 'plain object', msg, 'is', assert.isPlainObject

assert.isNotPlainObject = (val, msg) ->
	if utils.isPlainObject val
		@fail val, 'plain object', msg, 'isn\'t', assert.isNotPlainObject

assert.isArray = (val, msg) ->
	unless Array.isArray val
		@fail val, 'array', msg, 'is', assert.isArray

assert.isNotArray = (val, msg) ->
	if Array.isArray val
		@fail val, 'array', msg, 'isn\'t', assert.isNotArray

assert.instanceOf = (val, ctor, msg) ->
	unless val instanceof ctor
		ctorName = ctor.__path__ or ctor.__name__ or ctor.name or ctor
		@fail val, ctorName, msg, 'instanceof', assert.instanceOf

assert.notInstanceOf = (val, ctor, msg) ->
	if val instanceof ctor
		ctorName = ctor.__path__ or ctor.__name__ or ctor.name or ctor
		@fail val, ctorName, msg, 'instanceof', assert.notInstanceOf

assert.lengthOf = (val, length, msg) ->
	unless val.length is length
		@fail val, length, msg, '.length ===', assert.lengthOf

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

assert.match = (val, regexp, msg) ->
	unless regexp.test val
		@fail val, regexp, msg, 'match', assert.match

assert.notMatch = (val, regexp, msg) ->
	if regexp.test val
		@fail val, regexp, msg, 'not match', assert.match
