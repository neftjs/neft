'use strict'

[Routing] = ['routing'].map require

module.exports = (App) ->

	class IndexModel extends App.Model.Client().View()

		@view 'index',
		@client Routing.GET, '',
		getWelcome: (id, query, type, callback) ->

			callback()

	new IndexModel