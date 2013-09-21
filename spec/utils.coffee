'use strict'

ready = false

module.exports.isReady = (Db) ->

	describe 'Db', ->

		it 'is ready', ->

			runs ->
				Db.on Db.READY, -> ready = true

			waitsFor -> ready

			runs ->
				expect(ready).toBeTruthy()

module.exports.clean = (Db, database, table) ->

	it 'cleans', ->

		end = false

		runs ->
			new Db(database, table).remove() (err) -> end = not err

		waitsFor -> end

		runs ->
			expect(end).toBe true