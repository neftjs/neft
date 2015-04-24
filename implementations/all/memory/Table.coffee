'use strict'

utils = require 'utils'

uid = ->
	Math.random().toString(16).slice(2)

module.exports = (Db, impl) ->
	class RethinkTable extends Db.Table
		run: (callback) ->
			impl.data[@name] ?= []
			callback null

		insertData: (doc, callback) ->
			id = uid()
			doc = utils.cloneDeep doc
			doc.id = id
			impl.data[@name].push doc
			callback null, id
