'use strict'

[utils] = ['utils'].map require
[Schema, Routing, View] = ['schema', 'routing', 'view'].map require
[Db, _, _, _] = ['db', 'db-implementation', 'db-schema', 'db-addons'].map require

# TODO: use view-styles only for a client bundle
# if utils.isClient

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
		Template: null
		View: null
		models: opts.models
		controllers: opts.controllers
		handlers: opts.handlers
		routes: opts.routes
		views: opts.views
		templates: opts.templates

	App.Route = require('./route') App
	App.Template = require('./template') App
	App.View = require('./view') App

	# load styles
	require('styles') opts.styles

	# load bootstrap
	if utils.isNode
		require('./bootstrap/route') App

	# load views
	for path, json of App.views
		unless json instanceof View
			App.views[path] = new App.View View.fromJSON path, json

	# loading files helper
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
