'use strict'

[Model] = ['model'].map require

module.exports = (App) -> class AppModel extends Model

	constructor: ->

		@Db = App.Db
		@database = 'project_todo'
		@routing = App.routing

		super
