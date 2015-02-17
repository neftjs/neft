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

	exports = module.exports = (opts={}, extraOpts={}) ->
		# Welcome log
		log.ok "Welcome! Neft.io v#{pkg.version}; Feedback appreciated"

		{config} = pkg
		config = utils.merge utils.clone(config), opts.config

		if extraOpts?
			utils.merge config, extraOpts

*Object* app
------------

		app =

*Object* app.config = {}
------------------------

Config object from *package.json* file and from the *init.js* file.

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
  var app = NeftApp({ title: "Overridden title" });
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

HTTP protocol is used by default with the data specified in the *package.json*.

			networking: new Networking
				type: Networking.HTTP
				protocol: config.protocol
				port: parseInt(config.port, 10)
				host: config.host
				url: config.url
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

			models: {}

*Object* app.controllers = {}
-----------------------------

Files from the *controllers* folder with objects returned by their exported functions.

			controllers: {}

*Object* app.routes = {}
------------------------

Files from the *routes* folder with objects returned by their exported functions.

			routes: {}

*Object* app.styles = {}
------------------------

Files from the *styles* folder as *Function*s ready to create [Renderer.Item][]s..

			styles: {}

*Object* app.views = {}
-----------------------

Files from the *views* folder as *App.View* instances.

			views: {}

*Object* app.templates = {}
---------------------------

Files from the *templates* folder with objects returned by their exported functions.

			templates: {}

		app.Route = AppRoute app
		app.Template = AppTemplate app
		app.View = AppView app

		# propagate data
		Renderer.serverUrl = app.networking.url

		# initialize styles
		for style in opts.styles when style.name?
			app.styles[style.name] = style.file app.styles

		# set styles window item
		windowStyle = app.styles?.window?.withStructure()
		windowStyle ?=
			mainItem: new Renderer.Item
			ids: {}
		Renderer.window = windowStyle.mainItem

		# load styles
		require('styles')
			windowStyle: windowStyle
			styles: app.styles

		# load bootstrap
		if utils.isNode
			bootstrapRoute app

		# load views
		for view in opts.views when view.name?
			app.views[view.name] = new app.View Document.fromJSON(view.name, view.file)

		# loading files helper
		init = (files, target) ->
			for file in files when file.name?
				fileObj = file.file app

				if target[file.name]?
					if utils.isPlainObject(target[file.name]) and utils.isPlainObject(fileObj)
						fileObj = utils.merge Object.create(target[file.name]), fileObj

				target[file.name] = fileObj
			return

		setImmediate ->
			init opts.models, app.models
			init opts.controllers, app.controllers
			init opts.routes, app.routes
			init opts.templates, app.templates

	# link module
	MODULES = ['assert', 'db', 'db-addons', 'db-schema', 'dict', 'emitter', 'expect', 'list',
	           'log', 'renderer', 'networking', 'schema', 'signal', 'utils', 'document', 'styles']
	for name in MODULES
		exports[name] = require name
