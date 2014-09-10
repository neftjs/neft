[utils] = ['utils'].map require

List = require './index'

describe 'ctor', ->

	it 'creates new List', ->
		list = List()
		expect(list).toEqual jasmine.any List

describe 'length', ->

	it 'returns amount of items', ->
		list = List 1, 2
		expect(list.length).toBe 2

describe 'get()', ->

	it 'return an item at given position', ->
		list = List 1, 2
		expect(list.get 0).toBe 1
		expect(list.get 1).toBe 2
		expect(list.get 2).toBe undefined

describe 'set()', ->

	it 'change existed item value', ->
		list = List 1
		list.set 0, 2
		expect(list.get 0).toBe 2

describe 'items()', ->

	it 'return array of items', ->
		list = List 1, 2
		expect(list.items()).toEqual {0: 1, 1: 2}

	it 'return array of items for ctor-array syntax', ->
		list = List [1, 2]
		expect(list.items()).toEqual {0: 1, 1: 2}

describe 'append()', ->

	it 'add an item on the end', ->
		list = List 1
		list.append 2
		expect(list.items()).toEqual 0: 1, 1: 2

describe 'insert()', ->

	it 'insert an item at given position', ->
		list = List 1, 2
		list.insert 1, 0
		list.insert 0, 2
		expect(list.items()).toEqual 0: 2, 1: 1, 2: 0, 3: 2

describe 'remove()', ->

	it 'remove the first element equal given value', ->
		list = List 0, 1, 1, 2
		list.remove 1
		expect(list.items()).toEqual {0: 0, 1: 1, 2: 2}

describe 'pop()', ->

	it 'remove the last item', ->
		list = List 1, 2
		list.pop()
		expect(list.items()).toEqual 0: 1

	it 'remove the item at given position', ->
		list = List 1, 2, 3
		list.pop 1
		expect(list.items()).toEqual {0: 1, 1: 3}
		list.pop 0
		expect(list.items()).toEqual {0: 3}

describe 'clear()', ->

	it 'remove all items', ->
		list = List 1, 2
		list.clear()
		expect(list.items()).toEqual {}

describe 'index()', ->

	it 'return the index of the first item equal given value', ->
		list = List 1, 2, 2
		expect(list.index 2).toBe 1

describe 'onChanged signal', ->

	list = listener = null
	ok = false
	args = copy = null

	beforeEach ->
		ok = false
		args = []

		listener = (_args...) ->
			ok = true
			args.push _args
			copy = utils.clone list._data

	afterEach ->
		expect(ok).toBeTruthy()
		list.changed.disconnect listener

	it 'works with set()', ->
		list = List 1, 2, 3
		list.onChanged listener

		list.set 1, 'a'

		expect(args).toEqual [[1, 2]]
		expect(copy).toEqual [1, 'a', 3]

describe 'onInserted signal', ->

	list = listener = null
	ok = false
	args = copy = null

	beforeEach ->
		ok = false
		args = []

		listener = (_args...) ->
			ok = true
			args.push _args
			copy = utils.clone list._data

	afterEach ->
		expect(ok).toBeTruthy()
		list.inserted.disconnect listener

	it 'works with append()', ->
		list = List 1, 2
		list.onInserted listener

		list.append 'a'

		expect(args).toEqual [[2]]
		expect(copy).toEqual [1, 2, 'a']

	it 'works with insert()', ->
		list = List 1, 2
		list.onInserted listener

		list.insert 1, 'a'

		expect(args).toEqual [[1]]
		expect(copy).toEqual [1, 'a', 2]

describe 'onPopped signal', ->

	list = listener = null
	ok = false
	args = copy = null

	beforeEach ->
		ok = false
		args = []

		listener = (_args...) ->
			ok = true
			args.push _args
			copy = utils.clone list._data

	afterEach ->
		expect(ok).toBeTruthy()
		list.popped.disconnect listener

	it 'works with pop()', ->
		list = List 1, 2
		list.onPopped listener

		list.pop()

		expect(args).toEqual [[1, 2]]
		expect(copy).toEqual [1]

	it 'works with pop(i)', ->
		list = List 1, 2
		list.onPopped listener

		list.pop 0

		expect(args).toEqual [[0, 1]]
		expect(copy).toEqual [2]

	it 'works with remove()', ->
		list = List 1, 2
		list.onPopped listener

		list.remove 2

		expect(args).toEqual [[1, 2]]
		expect(copy).toEqual [1]

	it 'works with clear()', ->
		list = List 1, 2
		list.onPopped listener

		list.clear()

		expect(args).toEqual [[1, 2], [0, 1]]
		expect(copy).toEqual []