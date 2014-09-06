'use strict'

[utils] = ['utils'].map require
[Schema, Routing, View] = ['schema', 'routing', 'view'].map require
[Db, _, _, _] = ['db', 'db-implementation', 'db-schema', 'db-addons'].map require

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
		Route: null
		models: opts.models
		controllers: opts.controllers
		handlers: opts.handlers
		routes: opts.routes
		views: opts.views
		templates: opts.templates

	App.Route = require('./route') App

	# load bootstrap
	if utils.isNode
		require('./bootstrap/route') App

	# load views
	for path, json of App.views
		unless json instanceof View
			App.views[path] = View.fromJSON path, json

	# load styles
	if utils.isClient
		for path, json of opts.styles
			View.loadStylesFromJSON path, json

	# load models
	init = (files) ->
		for name, module of files
			files[name] = module App
		files

	init App.models
	init App.controllers
	init App.handlers.rest
	init App.handlers.view
	init App.templates
	init App.routes
