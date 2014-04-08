'use strict'

[Routing, Schema] = ['routing', 'schema'].map require

module.exports = (App) -> new class ItemModel extends App.Model.Db().View().Client()

	@PER_PAGE = 10

	table: 'item'

	linkedDataSchema:
		'@type': 'Action'
		description: 'msg'

	@view 'index',
	@client Routing.GET, {
		uri: 'items/{page}',
		schema: new Schema
			page:
				type: 'number'
				min: 0
				re: ///^[0-9]+$///
	},
	getAll: (id, query, type, callback) ->

		opts = skip: query.page * ItemModel.PER_PAGE, limit: ItemModel.PER_PAGE
		@get opts, callback