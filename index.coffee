'use strict'

utils = require 'utils'
log = require 'log'
Schema = require 'schema'
Routing = require 'routing'
View = require 'view'
Renderer = require 'renderer'
Db = require 'db'
require 'db-implementation'
require 'db-schema'
require 'db-addons'
require 'db/log.coffee'

AppRoute = require './route'
AppTemplate = require './template'
AppView = require './view'

# build polyfills
# TODO: move it into separated module
if utils.isBrowser
	global.setImmediate = require 'emitter/node_modules/immediate'

if utils.isNode
	bootstrapRoute = require './bootstrap/route.node'

pkg = require './package.json'

# TODO
# `//<development>`
# log.warn "Use this bundles only for testing. " +
#          "For production use --release option!"
# `//</development>`

exports = module.exports = (opts={}) ->
	# Welcome log
	log.ok "Welcome! Neft.io v#{pkg.version}; Feedback appreciated"

	# Db
	Db = Db.Impl()
	`//<development>`
	require('db/log.coffee') Db
	`//</development>`

	{config} = pkg

	if opts.config
		config = utils.merge utils.clone(config), opts.config

	App = Object.preventExtensions
		config: config
		routing: new Routing
			protocol: config.protocol
			port: config.port
			host: config.host
			language: config.language
		Route: null
		Template: null
		View: null
		models: opts.models or {}
		controllers: opts.controllers or {}
		handlers: opts.handlers or {}
		routes: opts.routes or {}
		views: opts.views or {}
		templates: opts.templates or {}

	App.Route = AppRoute App
	App.Template = AppTemplate App
	App.View = AppView App

	# initialize styles
	{styles} = opts
	for name, style of styles
		styles[name] = style styles

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
		bootstrapRoute App

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

# link module
MODULES = ['assert', 'db', 'db-addons', 'db-schema', 'dict', 'emitter', 'expect', 'list',
           'log', 'renderer', 'routing', 'schema', 'signal', 'utils', 'view', 'styles']
for name in MODULES
	exports[name] = require name
