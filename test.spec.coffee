'use strict'

utils = require 'neft-utils'
List = require './index'

describe 'ctor', ->

	it 'creates new List', ->
		list = List()
		expect(list).toEqual jasmine.any List

describe 'length', ->

	it 'returns amount of items', ->
		list = List [1, 2]
		expect(list.length).toBe 2

describe 'values are accessed by their keys', ->
	list = List [1, 2]
	expect(list[0]).toBe 1
	expect(list[1]).toBe 2
	expect(list[2]).toBe undefined

describe 'set()', ->

	it 'change existed item value', ->
		list = List [1]
		list.set 0, 2
		expect(list[0]).toBe 2

describe 'append()', ->

	it 'add an item on the end', ->
		list = List [1]
		list.append 2
		expect(list.toArray()).toEqual [1, 2]

describe 'insert()', ->

	it 'insert an item at given position', ->
		list = List [1, 2]
		list.insert 1, 0
		list.insert 0, 2
		expect(list.toArray()).toEqual [2, 1, 0, 2]

describe 'remove()', ->

	it 'remove the first element equal given value', ->
		list = List [0, 1, 1, 2]
		list.remove 1
		expect(list.toArray()).toEqual [0, 1, 2]

describe 'pop()', ->

	it 'remove the last item', ->
		list = List [1, 2]
		list.pop()
		expect(list.toArray()).toEqual [1]

	it 'remove the item at given position', ->
		list = List [1, 2, 3]
		list.pop 1
		expect(list.toArray()).toEqual [1, 3]
		list.pop 0
		expect(list.toArray()).toEqual [3]

describe 'clear()', ->

	it 'remove all items', ->
		list = List [1, 2]
		list.clear()
		expect(list.toArray()).toEqual []

describe 'index()', ->

	it 'return the index of the first item equal given value', ->
		list = List [1, 2, 2]
		expect(list.index 2).toBe 1
		expect(list.index 3).toBe -1

describe 'has()', ->

	it 'return true if given value exists in a list', ->
		list = List [1, 2, 2]
		expect(list.has 2).toBe true
		expect(list.has 3).toBe false

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
		expect(ok).toBeTruthy()
		list.onChange.disconnect listener

	it 'works with set()', ->
		list = List [1, 2, 3]
		list.onChange listener

		list.set 1, 'a'

		expect(args).toEqual [[2, 1]]
		expect(copy.toArray()).toEqual [1, 'a', 3]

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
		expect(ok).toBeTruthy()
		list.onInsert.disconnect listener

	it 'works with append()', ->
		list = List [1, 2]
		list.onInsert listener

		list.append 'a'

		expect(args).toEqual [['a', 2]]
		expect(copy.toArray()).toEqual [1, 2, 'a']

	it 'works with insert()', ->
		list = List [1, 2]
		list.onInsert listener

		list.insert 1, 'a'

		expect(args).toEqual [['a', 1]]
		expect(copy.toArray()).toEqual [1, 'a', 2]

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
		expect(ok).toBeTruthy()

	it 'works with pop()', ->
		list = List [1, 2]
		list.onPop listener

		list.pop()

		expect(args).toEqual [[2, 1]]
		expect(copy.toArray()).toEqual [1]

	it 'works with pop(i)', ->
		list = List [1, 2]
		list.onPop listener

		list.pop 0

		expect(args).toEqual [[1, 0]]
		expect(copy.toArray()).toEqual [2]

	it 'works with remove()', ->
		list = List [1, 2]
		list.onPop listener

		list.remove 2

		expect(args).toEqual [[2, 1]]
		expect(copy.toArray()).toEqual [1]

	it 'works with clear()', ->
		list = List [1, 2]
		list.onPop listener

		list.clear()

		expect(args).toEqual [[2, 1], [1, 0]]
		expect(copy.toArray()).toEqual []
