'use strict'

Db = require '../index'
specUtils = require './utils'

Db = Db.create
	type: 'mysql'
	database: 'test'
	config:
		host: 'localhost'
		user: ''
		password: ''

Db.onReady ->
	# Db.mysql.pool.query 'drop table test', ->
	Db.mysql.pool.query 'create table if not exists test (id integer auto_increment primary key, name text, age int, parent text)', ->

specUtils.isReady Db

describe 'Db implementation', ->

	TABLE = 'test'
	DOCUMENT =
		name: 'Test name'
		age: 1
		parent: ''
	UPDATE =
		name: 'Test name two'
		age: 2
		parent: 'nothing'

	id = null

	specUtils.clean Db, TABLE

	it 'saves new document', ->
		runs ->
			new Db(TABLE).insert(DOCUMENT).run (err, arg) ->
				id = arg

		waitsFor -> id?

		runs ->
			expect(id).toBeDefined()

	it 'returns created document', ->
		doc = null

		runs ->
			new Db(TABLE, id).run (err, arg) ->
				doc = arg

		waitsFor -> doc

		runs ->
			expect(Object.keys(doc).length).toBe 4
			expect(doc.id).toBe id
			expect(doc.name).toBe DOCUMENT.name
			expect(doc.age).toBe DOCUMENT.age

	it 'removes document', ->

		end = false
		doc = true

		runs ->
			new Db(TABLE, id).remove().run (err) ->
				end = not err

		waitsFor -> end

		runs ->
			new Db(TABLE, id).run (err, res) ->
				doc = !!res

		waitsFor -> not doc

		runs ->
			expect(end).toBeTruthy()
			expect(doc).toBeFalsy()

	it 'saves multiple times', ->

		N = 4
		end = 0
		elems = null

		runs ->
			for i in [0...N]
				new Db(TABLE).insert(DOCUMENT).run (err) ->
					end += not err

		waitsFor -> end is N

		runs ->
			expect(end).toBe N

		runs ->
			new Db(TABLE).run (err, arg) ->
				elems = arg

		waitsFor -> elems

		runs ->
			expect(elems.length).toBe N

	it 'supports limit and skip commands', ->

		end = false
		elems = null

		runs ->
			new Db(TABLE).skip(1).limit(2).skip(1).update(UPDATE).run (err) ->
				end = not err

		waitsFor -> end

		runs ->
			new Db(TABLE).run (err, arg) ->
				elems = arg

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

	it 'supports where.is', ->

		elems = null

		runs ->
			new Db(TABLE).where('name').is(DOCUMENT.name).run (err, arg) ->
				elems = arg

		waitsFor -> elems

		runs ->
			expect(elems.length).toBe 4

			elems.forEach (elem) ->
				expect(elem.name).toBe DOCUMENT.name
				expect(elem.age).toBe DOCUMENT.age
				expect(elem.parent).not.toBe UPDATE.parent

	it 'supports where lt and gt', ->

		elems = null

		runs ->
			new Db(TABLE).where('age').gt(0).lt(2).run (err, arg) ->
				elems = arg

		waitsFor -> elems

		runs ->
			expect(elems.length).toBe 4

			elems.forEach (elem) ->
				expect(elem.name).toBe DOCUMENT.name
				expect(elem.age).toBe DOCUMENT.age
				expect(elem.parent).not.toBe UPDATE.parent

	it 'cleans table', ->

		end = false
		count = true

		runs ->
			new Db(TABLE).remove().run (err) ->
				end = not err

		waitsFor -> end

		runs ->
			new Db(TABLE).run (err, arg) ->
				count = arg.length

		waitsFor -> not count

		runs ->
			expect(end).toBeTruthy()
			expect(count).toBe 0
