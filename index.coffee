'use strict'

[utils] = ['utils'].map require
[Schema, Routing, View] = ['schema', 'routing', 'view'].map require
[Db, _, _, _] = ['db', 'db-implementation', 'db-schema', 'db-addons'].map require
[_, _, _, _, _, AppModel] = ['model', 'model-db', 'model-client', 'model-linkeddata',
                             'model-view', './model.coffee'].map require

# TODO: use view-styles only for a client bundle
# if utils.isClient
[_] = ['view-styles'].map require

Db = Db.Impl()

`//<development>`
require('db/log.coffee') Db
`//</development>`

module.exports = (opts={}) ->

	pkg = require './package.json'
	{config} = pkg

	if opts.config
		config = utils.merge utils.clone(config), opts.config

	App =
		config:
			name: pkg.title
		routing: new Routing
			protocol: pkg.config.protocol
			port: pkg.config.port
			host: pkg.config.host
			language: pkg.config.language
		Routing: Routing
		Schema: Schema
		Model: null
		Db: Db
		View: View

	App.Model = AppModel App

	# load views
	viewFiles = []
	viewFiles.push View.fromJSON path, json for path, json of opts.views

	# load styles
	if utils.isClient
		for path, json of opts.styles
			View.loadStylesFromJSON path, json

	# load models
	models = {}
	models[name] = model App for name, model of opts.models