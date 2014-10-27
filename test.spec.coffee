Dict = require './index'

describe 'ctor', ->

	it 'creates new dict', ->
		dict = Dict a: 1
		expect(dict).toEqual jasmine.any Dict

describe 'get()', ->

	it 'returns key value', ->
		dict = Dict a: 1
		expect(dict.get 'a').toBe 1

	it 'returns `undefined` for unknown', ->
		dict = Dict()
		expect(dict.get 'abc').toBe undefined

describe 'set()', ->

	it 'set key value', ->
		dict = Dict()
		dict.set 'a', 1
		expect(dict.get 'a').toBe 1

	it 'overrides keys', ->
		dict = Dict a: 1
		dict.set 'a', 2
		expect(dict.get 'a').toBe 2

describe 'length', ->

	it 'returns amount of keys', ->
		dict = Dict a: 1, b: 2
		expect(dict.length).toBe 2

describe 'pop()', ->

	it 'removes key', ->
		dict = Dict a: 1
		expect(dict.pop 'a').toBe dict
		expect(dict.get 'a').toBe undefined

describe 'keys()', ->

	it 'returns keys as an array', ->
		dict = Dict a: 1, b: 2
		expect(dict.keys()).toEqual ['a', 'b']

	it 'length is const', ->
		dict = Dict a: 1
		keys = dict.keys()
		dict.set 'b', 1
		expect(keys).toEqual ['a']
		expect(dict.keys()).toEqual ['a', 'b']

describe 'values()', ->

	it 'returns key values as an array', ->
		dict = Dict a: 1, b: 2
		expect(dict.values()).toEqual [1, 2]

	it 'length is const', ->
		dict = Dict a: 1
		values = dict.values()
		dict.set 'b', 2
		expect(values).toEqual [1]
		expect(dict.values()).toEqual [1, 2]

describe 'items()', ->

	it 'returns an array of key - value pairs', ->
		dict = Dict a: 1, b: 2
		expect(dict.items()).toEqual [['a', 1], ['b', 2]]

	it 'length is const', ->
		dict = Dict a: 1
		items = dict.items()
		dict.set 'b', 2
		expect(items).toEqual [['a', 1]]
		expect(dict.items()).toEqual [['a', 1], ['b', 2]]

describe 'json stringified', ->

	it 'is a reversed operation', ->
		dict = Dict a: 1, b: 2
		json = JSON.stringify dict
		dict2 = Dict.fromJSON json

		expect(dict2.items()).toEqual dict.items()
		expect(dict2).toEqual jasmine.any Dict

describe 'onChanged signal', ->

	dict = listener = null
	ok = false
	args = items = null


	beforeEach ->
		ok = false
		args = []

		listener = (_args...) ->
			ok = true
			args.push _args
			items = dict.items()

	afterEach ->
		expect(ok).toBeTruthy()
		dict.onChanged.disconnect listener

	it 'works with set() on new item', ->
		dict = Dict()
		dict.onChanged listener
		dict.set 'a', 1
		expect(args).toEqual [['a', undefined]]
		expect(items).toEqual [['a', 1]]

	it 'works with set() on item change', ->
		dict = Dict a: 1
		dict.onChanged listener
		dict.set 'a', 2
		expect(args).toEqual [['a', 1]]
		expect(items).toEqual [['a', 2]]

	it 'works with pop()', ->
		dict = Dict a: 1
		dict.onChanged listener
		dict.pop 'a'
		expect(args).toEqual [['a', 1]]
		expect(items).toEqual []

describe 'properties', ->

	it 'getter/setter works', ->
		NAME = 'abc'
		NAME2 = '123'

		dict = Dict()
		Dict.defineProperty dict, 'name'

		expect(dict.name).toBe undefined
		dict.name = NAME
		expect(dict.name).toBe NAME
		expect(dict.get 'name').toBe NAME

		dict.set 'name', NAME2
		expect(dict.name).toBe NAME2
		expect(dict.get 'name').toBe NAME2

	it 'custom signals are calling', ->
		dict = Dict()
		Dict.defineProperty dict, 'name'

		i = 0
		args = []
		dict.onNameChanged ->
			args.push [arguments...]
			i++

		dict.name = 2
		dict.name = 25

		expect(i).toBe 2
		expect(args).toEqual [[undefined], [2]]