'use strict'

###
TODO:
	- Db: default database
	- DbAddonsSchema: do not require `created` and `updated` in schema
	- DbAddons: parse timestamps into Date
###

[utils] = ['utils'].map require
[Schema, Routing, View] = ['schema', 'routing', 'view'].map require
[Db, _, _, _] = ['db', 'db-implementation', 'db-schema', 'db-addons'].map require
[_, _, _, _, _, AppModel] = ['model', 'model-db', 'model-client', 'model-linkeddata',
                             'model-view', './model.coffee'].map require

Db = Db.Impl()

`//<development>`
require('db/log.coffee') Db
`//</development>`

App =
	routing: new Routing
		protocol: 'http'
		port: 3000
		host: 'localhost'
		language: 'en'
	Schema: Schema
	Model: null
	Db: Db
	View: View
	views: {}

App.Model = AppModel App

# load views
views = require './build/views.coffee'
for path, json of views
	App.views[path] = View.fromJSON path, json

# load models
App.models =
	item: require('./models/item.coffee') App

if utils.isNode
	App.models.dev = require('./models/dev.node.coffee') App

module.exports = App
