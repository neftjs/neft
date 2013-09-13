'use strict'

Db = require '../index.coffee.md'

describe 'Db', ->

	it 'is ready', ->

		ready = false

		runs ->
			Db.on Db.READY, -> ready = true

		waitsFor -> ready

		runs ->
			expect(ready).toBeTruthy()

describe 'Db implementation', ->

	DATABASE = 'test'
	TABLE = 'test'
	DOCUMENT =
		name: 'Test name'
		age: 1

	id = null

	it 'cleans', ->

		end = false

		runs ->
			new Db(DATABASE, TABLE).remove()().then -> end = true

		waitsFor -> end

	it 'saves new document', ->

		runs ->
			new Db(DATABASE, TABLE).insert(DOCUMENT)().then (arg) -> id = arg

		waitsFor -> id

		runs ->
			expect(id).toEqual jasmine.any String

	it 'returns created document', ->

		doc = null

		runs ->
			new Db(DATABASE, TABLE, id)().then (arg) -> doc = arg

		waitsFor -> doc

		runs ->
			expect(Object.keys(doc).length).toBe 3
			expect(doc.id).toBe id
			expect(doc.name).toBe DOCUMENT.name
			expect(doc.age).toBe DOCUMENT.age

	it 'removes document', ->

		end = false
		doc = true

		runs ->
			new Db(DATABASE, TABLE, id).remove()().then -> end = true

		waitsFor -> end

		runs ->
			new Db(DATABASE, TABLE, id)().then (res) -> doc = !!res

		waitsFor -> not doc

		runs ->
			expect(end).toBeTruthy()
			expect(doc).toBeFalsy()

	it 'saves multiple times', ->

		N = 4

		end = 0

		runs ->
			for i in [0...N]
				new Db(DATABASE, TABLE).insert(DOCUMENT)().then -> ++end

		waitsFor -> end is N

		runs ->
			expect(end).toBe N

	it 'supports limit and skip commands', ->

		UPDATE =
			name: 'Test name two'
			age: 2
			parent: 'nothing'

		end = false
		elems = null

		runs ->
			new Db(DATABASE, TABLE).skip(1).limit(2).skip(1).update(UPDATE)().then -> end = true

		waitsFor -> end

		runs ->
			new Db(DATABASE, TABLE)().then (arg) -> elems = arg

		waitsFor -> elems

		runs ->

			validate = (elem, name, age, parent) ->

				expect(elem.name).toBe name
				expect(elem.age).toBe age
				expect(elem.parent).toBe parent

			expect(elems.length).toBe 4
			validate elems[0], DOCUMENT.name, DOCUMENT.age, undefined
			validate elems[1], DOCUMENT.name, DOCUMENT.age, undefined
			validate elems[2], UPDATE.name, UPDATE.age, UPDATE.parent
			validate elems[3], DOCUMENT.name, DOCUMENT.age, undefined

	it 'cleans table', ->

		end = false
		count = true

		runs ->
			new Db(DATABASE, TABLE).remove()().then -> end = true

		waitsFor -> end

		runs ->
			new Db(DATABASE, TABLE)().then (arg) -> count = arg.length

		waitsFor -> not count

		runs ->
			expect(end).toBeTruthy()
			expect(count).toBe 0