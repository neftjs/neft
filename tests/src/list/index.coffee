'use strict'

{utils, unit, assert, List} = Neft
{describe, it, beforeEach, afterEach} = unit

describe 'ctor', ->
	it 'creates new List', ->
		list = List()
		assert.instanceOf list, List

describe 'length', ->
	it 'returns amount of items', ->
		list = List [1, 2]
		assert.is list.length, 2

it 'values are accessed by their keys', ->
	list = List [1, 2]
	assert.is list[0], 1
	assert.is list[1], 2
	assert.is list[2], undefined

describe 'set()', ->
	it 'change existed item value', ->
		list = List [1]
		list.set 0, 2
		assert.is list[0], 2

describe 'append()', ->
	it 'add an item on the end', ->
		list = List [1]
		list.append 2
		assert.isEqual list.toArray(), [1, 2]

describe 'insert()', ->
	it 'insert an item at given position', ->
		list = List [1, 2]
		list.insert 1, 0
		list.insert 0, 2
		assert.isEqual list.toArray(), [2, 1, 0, 2]

describe 'remove()', ->
	it 'remove the first element equal given value', ->
		list = List [0, 1, 1, 2]
		list.remove 1
		assert.isEqual list.toArray(), [0, 1, 2]

describe 'pop()', ->
	it 'remove the last item', ->
		list = List [1, 2]
		list.pop()
		assert.isEqual list.toArray(), [1]

	it 'remove the item at given position', ->
		list = List [1, 2, 3]
		list.pop 1
		assert.isEqual list.toArray(), [1, 3]
		list.pop 0
		assert.isEqual list.toArray(), [3]

describe 'clear()', ->
	it 'remove all items', ->
		list = List [1, 2]
		list.clear()
		assert.isEqual list.toArray(), []

describe 'index()', ->
	it 'return the index of the first item equal given value', ->
		list = List [1, 2, 2]
		assert.is list.index(2), 1
		assert.is list.index(3), -1

describe 'has()', ->
	it 'return true if given value exists in a list', ->
		list = List [1, 2, 2]
		assert.is list.has(2), true
		assert.is list.has(3), false

describe 'onChange signal', ->
	list = listener = null
	ok = false
	args = copy = null

	beforeEach ->
		ok = false
		args = []

		listener = (_args...) ->
			ok = true
			args.push _args
			copy = utils.clone list

	afterEach ->
		assert.ok ok
		list.onChange.disconnect listener

	it 'works with set()', ->
		list = List [1, 2, 3]
		list.onChange listener

		list.set 1, 'a'

		assert.isEqual args, [[2, 1]]
		assert.isEqual copy.toArray(), [1, 'a', 3]

describe 'onInsert signal', ->
	list = listener = null
	ok = false
	args = copy = null

	beforeEach ->
		ok = false
		args = []

		listener = (_args...) ->
			ok = true
			args.push _args
			copy = utils.clone list

	afterEach ->
		assert.ok ok
		list.onInsert.disconnect listener

	it 'works with append()', ->
		list = List [1, 2]
		list.onInsert listener

		list.append 'a'

		assert.isEqual args, [['a', 2]]
		assert.isEqual copy.toArray(), [1, 2, 'a']

	it 'works with insert()', ->
		list = List [1, 2]
		list.onInsert listener

		list.insert 1, 'a'

		assert.isEqual args, [['a', 1]]
		assert.isEqual copy.toArray(), [1, 'a', 2]

describe 'onPop signal', ->
	list = listener = null
	ok = false
	args = copy = null

	beforeEach ->
		ok = false
		args = []

		listener = (_args...) ->
			ok = true
			args.push _args
			copy = utils.clone list

	afterEach ->
		assert.ok ok

	it 'works with pop()', ->
		list = List [1, 2]
		list.onPop listener

		list.pop()

		assert.isEqual args, [[2, 1]]
		assert.isEqual copy.toArray(), [1]

	it 'works with pop(i)', ->
		list = List [1, 2]
		list.onPop listener

		list.pop 0

		assert.isEqual args, [[1, 0]]
		assert.isEqual copy.toArray(), [2]

	it 'works with remove()', ->
		list = List [1, 2]
		list.onPop listener

		list.remove 2

		assert.isEqual args, [[2, 1]]
		assert.isEqual copy.toArray(), [1]

	it 'works with clear()', ->
		list = List [1, 2]
		list.onPop listener

		list.clear()

		assert.isEqual args, [[2, 1], [1, 0]]
		assert.isEqual copy.toArray(), []
