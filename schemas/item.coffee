'use strict'

module.exports = (App) -> App.Db.Schema().registerSchema 'project_todo', 'item',
	msg:
		type: 'string'
		min: 1
		required: true
		unique: true
	updated:
		type: 'number'
	created:
		type: 'number'