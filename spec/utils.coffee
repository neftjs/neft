'use strict'

ready = false

module.exports.isReady = (Db) ->
	describe 'Db', ->
		it 'is ready', ->
			runs ->
				Db.onReady -> ready = true

			waitsFor -> ready

			runs ->
				expect(ready).toBeTruthy()

module.exports.clean = (Db, table) ->
	it 'cleans', ->
		end = false

		runs ->
			new Db(table).remove().run (err) ->
				end = not err

		waitsFor -> end

		runs ->
			expect(end).toBe true