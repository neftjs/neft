App @framework
===

This module should be considered as a framework and scaffolding for your applications.

Manual access to each neft.io library and engine is still available.
This is just a high-level API for even easier dealing with networking routes,
HTML documents and more.

	'use strict'

	utils = require 'utils'
	log = require 'log'
	signal = require 'signal'
	db = require 'db'
	assert = require 'neft-assert'
	Schema = require 'schema'
	Networking = require 'networking'
	Document = require 'document'
	Renderer = require 'renderer'
	Resources = require 'resources'
	Dict = require 'dict'

	AppRoute = require './route'

	if utils.isNode
		bootstrapRoute = require './bootstrap/route.node'

	pkg = require './package.json'

	exports = module.exports = (opts={}, extraOpts={}) ->
		# Welcome log also for release mode
		(require('log')).ok "Welcome! Neft.io v#{pkg.version}; Feedback appreciated"

		`//<development>`
		log.warn "Use this bundle only in development; type --release when it's ready"
		`//</development>`

		{config} = pkg
		config = utils.merge utils.clone(config), opts.config

		if extraOpts?
			utils.merge config, extraOpts

*Dict* app
----------

		app = new Dict

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
    "type": "app"
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

		app.config = config

*Networking* app.networking
---------------------------

Standard Networking instance used to communicate
with the server and to create local requests.

All routes created by the *App.Route* uses this networking.

HTTP protocol is used by default with the data specified in the *package.json*.

		app.networking = new Networking
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

		app.models = {}

*Object* app.routes = {}
------------------------

Files from the *routes* folder with objects returned by their exported functions.

		app.routes = {}

*Object* app.styles = {}
------------------------

Files from the *styles* folder as *Function*s ready to create [Renderer.Item][]s..

		app.styles = {}

*Object* app.views = {}
-----------------------

Files from the *views* folder as *Document* instances.

		app.views = {}

*Resources* app.resources
-------------------------

		app.resources = if opts.resources then Resources.fromJSON(opts.resources) else new Resources

*Signal* app.onReady()
----------------------

		signal.create app, 'onReady'

		# config.type
		config.type ?= 'app'
		assert.ok utils.has(['app', 'game', 'text'], config.type), "Unexpected app.config.type value. Accepted app/game, but '#{config.type}' got."

		app.Route = AppRoute app

*Dict* app.cookies
------------------

This object refers to the custom cookies implementation.

For a server, this cookies will be added into responses.

By default, client has *clientId* and *sessionId* hashes.

```
app.cookies.onChanged(function(key){
  console.log('cookie changed', key, this.get(key));
});
```

```
<h1>Your clientId</h1>
<em>${app.cookies.clientId}</em>
```

		# cookies
		COOKIES_KEY = '__neft_cookies'
		app.cookies = null
		onCookiesReady = (dict) ->
			app.cookies = dict
			if utils.isClient
				dict.set 'sessionId', utils.uid(16)
		db.get COOKIES_KEY, db.OBSERVABLE, (err, dict) ->
			if dict
				onCookiesReady dict
			else
				if utils.isClient
					cookies = {clientId: utils.uid(16)}
				else
					cookies = {}
				db.set COOKIES_KEY, cookies, (err) ->
					db.get COOKIES_KEY, db.OBSERVABLE, (err, dict) ->
						onCookiesReady dict
		app.networking.onRequest (req, res) ->
			if utils.isClient
				utils.merge req.cookies, app.cookies._data
			else
				utils.merge res.cookies, app.cookies._data
			req.onLoadEnd.listeners.unshift ->
				if utils.isClient
					for key, val of res.cookies
						unless utils.isEqual(app.cookies.get(key), val)
							app.cookies.set key, val
				return
			, null
			return

		# propagate data
		Renderer.resources = app.resources
		Renderer.serverUrl = app.networking.url

		# set styles window item
		if opts.styles?
			for style in opts.styles
				if style.name is 'view'
					windowStyle = style.file._main.getComponent()
					break

		windowStyleItem = windowStyle?.item or new Renderer.Item
		Renderer.window = windowStyleItem

		if opts.styles?
			stylesInitObject =
				app: app
				view: windowStyleItem

			# initialize styles
			for style in opts.styles when style.name?
				style.file._init stylesInitObject
				app.styles[style.name] = style.file

		# load styles
		require('styles')
			windowStyle: windowStyle
			styles: app.styles

		# load bootstrap
		if utils.isNode
			bootstrapRoute app

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
			# load views
			for view in opts.views when view.name?
				app.views[view.name] = Document.fromJSON(view.name, view.file)

			init opts.models, app.models
			init opts.routes, app.routes

			for path, obj of app.routes
				r = {}
				if utils.isObject(obj) and not (obj instanceof app.Route)
					for method, opts of obj
						if utils.isObject(opts)
							route = new app.Route method, opts
							r[route.name] = route
						else
							r[method] = opts
				app.routes[path] = r

			app.onReady.emit()

		# load document extensions
		if utils.isObject(opts.extensions)
			for ext in opts.extensions
				ext app: app

		app

	# link module
	MODULES = ['utils', 'signal', 'dict', 'emitter', 'expect', 'list', 'log', 'resources',
	           'renderer', 'networking', 'schema', 'document', 'styles', 'assert', 'db']
	for name in MODULES
		exports[name] = require name
	exports['neft-assert'] = exports.assert
