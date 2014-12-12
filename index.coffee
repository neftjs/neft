'use strict'

[utils] = ['utils'].map require
[Schema, Routing, View, Renderer] = ['schema', 'routing', 'view', 'renderer'].map require
[Db, _, _, _] = ['db', 'db-implementation', 'db-schema', 'db-addons'].map require

# build polyfills
# TODO: move it into separated module
if utils.isBrowser
	global.setImmediate = require 'emitter/node_modules/immediate'

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
			protocol: config.protocol
			port: config.port
			host: config.host
			language: config.language
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

	# set styles window item
	windowStyle = opts.styles?.Window?.withStructure()
	windowStyle ?=
		mainItem: new Renderer.Item
		ids: {}
	Renderer.window = windowStyle.mainItem

	# load styles
	require('styles')
		windowStyle: windowStyle
		styles: opts.styles

	# load bootstrap
	if utils.isNode
		require('./bootstrap/route.node') App

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
