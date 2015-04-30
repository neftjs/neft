App @framework
===

This module should be considered as a framework and scaffolding for your applications.

Manual access to each neft.io library and engine is still available.
This is just a high-level API for even easier dealing with networking routes,
HTML documents and more.

	'use strict'

	utils = require 'utils'
	log = require 'log'
	assert = require 'neft-assert'
	Schema = require 'schema'
	Networking = require 'networking'
	Document = require 'document'
	Renderer = require 'renderer'
	Resources = require 'resources'

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

	exports = module.exports = (opts={}, extraOpts={}) ->
		# Welcome log also for release mode
		(require('log')).ok "Welcome! Neft.io v#{pkg.version}; Feedback appreciated"

		`//<trialVersion>`
		(require('log')).warn "This is a trial version. Only for testing on your local machine. Licensing: http://www.neft.io/docs"
		`//</trialVersion>`
		`//<development>`
		log.warn "Use this bundle only in development; type --release when it's ready"
		`//</development>`

		{config} = pkg
		config = utils.merge utils.clone(config), opts.config

		if extraOpts?
			utils.merge config, extraOpts

*Object* app
------------

		app =

*Object* app.config = {}
------------------------

Config object from the *package.json* file.

Can be overriden in the *init.js* file.

- *type* - accepts **app**, **game** and **text**,
  used to detect e.g. which renderer implementation should be used

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
    "language": "en",
    "type": "app",
    "resources": "static/"
  }
}

// init.js
module.exports = function(NeftApp){
  var app = NeftApp({ title: "Overridden title" });
  console.log(app.config);
  // {title: "My first application!", protocol: "http", port: ....}
};
```

#### Use WebGL as a default renderer @snippet

```
// package.json
{
  "config": {
    "type": "game"
  }
}
```

			config: config

*Networking* app.networking
-------------------------------

Standard Networking instance used to communicate
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

// controllers/user.js
module.exports = function(app){
  return {
    get: function(req, res, callback){
      car data = app.models['user/permission'].getPermission(req.params.userId);
      callback(null, data);
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

*Resources* app.resources
-------------------------

			resources: if opts.resources then Resources.fromJSON(opts.resources) else new Resources

		# config.type
		config.type ?= 'app'
		assert.ok utils.has(['app', 'game', 'text'], config.type), "Unexpected app.config.type value. Accepted app/game, but '#{config.type}' got."

		app.Route = AppRoute app
		app.Template = AppTemplate app
		app.View = AppView app

		# unauthorized
		`//<trialVersion>`
		unless ///localhost|\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}///.test app.networking.url
			(require('log')).error "Trial version can be run only locally"
			return
		`//</trialVersion>`

		# propagate data
		Renderer.resources = app.resources
		Renderer.serverUrl = app.networking.url

		# initialize styles
		for style in opts.styles when style.name?
			app.styles[style.name] = style.file app

		# set styles window item
		windowStyle = app.styles?.view?.withStructure()
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
				if typeof file.file isnt 'function'
					continue

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
	MODULES = ['utils', 'signal', 'dict', 'emitter', 'expect', 'list', 'log', 'resources',
	           'renderer', 'networking', 'schema', 'document', 'styles', 'assert', 'db']
	for name in MODULES
		exports[name] = require name
	exports['neft-assert'] = exports.assert
