App
===

This module should be considered as a framework and scaffolding for your applications.

Manual access to each neft.io library and engine is still available.
This is just a high-level API for even easier dealing with networking routes,
HTML documents and more.

	'use strict'

	utils = require 'utils'
	log = require 'log'
	Schema = require 'schema'
	Networking = require 'networking'
	Document = require 'document'
	Renderer = require 'renderer'
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

		{config} = pkg
		config = utils.merge utils.clone(config), opts.config

*Object* app
------------

		app =

*Object* app.config = {}
------------------------

Config object from *package.json* file.

```
// package.json
{
  "name": "neft.io app",
  "version": "0.1.0",
  "config": {
    "title": "My first application!",
    "protocol": "http",
    "port": 3000,
    "host": "localhost",
    "language": "en"
  }
}

// init.js
module.exports = function(NeftApp){
  var app = NeftApp();
  console.log(app.config);
  // {title: "My first application!", protocol: "http", port: ....}
};
```

			config: config

*Networking* app.networking
-------------------------------

Standard [Networking](/docs/networking) instance used to communicate
with the server and to create local requests.

All routes created by the *App.Route* uses this networking.

HTTP protocol is used by default with data specified in the *package.json*.

			networking: new Networking
				type: Networking.HTTP
				protocol: config.protocol
				port: config.port
				host: config.host
				language: config.language

*Object* app.models = {}
------------------------

Files from the *models* folder with objects returned by their exported functions.

```
// models/user/permission.js
module.exports = function(app){
  return {
    getPermission: function(id){}
  };
};

// routes/user.js
module.exports = function(app){
  return {
  	get: function(req, res, callback){
  	  callback(null, app.models['user/permission'].getPermission(req.params.userId));
  	}
  }
};
```

			models: opts.models or {}

*Object* app.controllers = {}
-----------------------------

Files from the *controllers* folder with objects returned by their exported functions.

			controllers: opts.controllers or {}

*Object* app.routes = {}
------------------------

Files from the *routes* folder with objects returned by their exported functions.

			routes: opts.routes or {}

*Object* app.views = {}
-----------------------

Files from the *views* folder as *App.View* instances.

			views: opts.views or {}

*Object* app.templates = {}
---------------------------

Files from the *templates* folder with objects returned by their exported functions.

			templates: opts.templates or {}

		app.Route = AppRoute app
		app.Template = AppTemplate app
		app.View = AppView app

		# initialize styles
		{styles} = opts
		for name, style of styles
			styles[name] = style styles

		# set styles window item
		windowStyle = opts.styles?.window?.withStructure()
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
			bootstrapRoute app

		# load views
		for path, json of app.views
			unless json instanceof Document
				app.views[path] = new app.View Document.fromJSON(path, json)

		# loading files helper
		init = (files) ->
			for name, module of files
				files[name] = module app
			files

		setImmediate ->
			init app.models
			init app.controllers
			init app.routes
			init app.templates

	# link module
	MODULES = ['assert', 'db', 'db-addons', 'db-schema', 'dict', 'emitter', 'expect', 'list',
	           'log', 'renderer', 'networking', 'schema', 'signal', 'utils', 'document', 'styles']
	for name in MODULES
		exports[name] = require name
