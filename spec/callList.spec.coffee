'use strict'

INIT = ['INIT1', 'INIT2']
CallList = require('../callList.coffee')

describe 'Call List', ->

	ARG1 = 'argument1'
	ARG2 = 'argument2'

	callList = new CallList INIT...

	createFunc = (id) -> (init1, init2, _super) ->
		throw new Error if init1 isnt INIT[0]
		throw new Error if init2 isnt INIT[1]
		throw new Error if typeof _super isnt 'function'

		(a, b, stack) ->
			throw new Error if a isnt ARG1
			throw new Error if b isnt ARG2
			_super arguments...
			stack.push id

	it 'works properly', ->

		callList.add 'second', createFunc(1)
		callList.add 'fourth', createFunc(2)
		callList.add 'first', createFunc(3), before: 'second'
		callList.add 'third', createFunc(4), after: 'second'

		stack = []
		callList.run ARG1, ARG2, stack
		expect(stack).toEqual [3, 1, 4, 2]