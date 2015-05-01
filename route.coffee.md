Route @class
=====

Class known as `app.Route` used to automate dealing with networking.

	'use strict'

	utils = require 'utils'
	log = require 'log'
	assert = require 'neft-assert'

	Networking = require 'networking'
	Schema = require 'schema'
	Document = require 'document'
	Dict = require 'dict'

	log = log.scope 'App', 'Route'

	CONFIG_KEYS = [] # filled by the class properties

	module.exports = (app) -> class AppRoute

		###
		Get function based on its path from the App namespace.

		Parameters:
			- *Route* route - route called this function; used to debug
			- *String|Function* val - Function path or function itself
			- *String* type - type of the container; used to debug
			- *String* containerName - path to the object with functions; must exists in the `App`

		Returns:
			*Function*
		###
		getByPath = (route, val, type, containerName, callback) ->
			assert.instanceOf route, AppRoute
			assert.isString type
			assert.isString containerName

			container = utils.get app, containerName

			if typeof val is 'string'
				[name, method] = val.split '.'

				if typeof container[name]?[method] is 'function'
					callback container[name][method]
				else
					setImmediate ->
						assert container[name]
						, "`#{name}` #{type} doesn't exists; `app.#{containerName}.#{name}` is not provided"

						assert typeof container[name][method] is 'function'
						, "`app.#{containerName}.#{name}.#{method}` #{type} method is not a function"

						callback container[name][method]
			else
				assert typeof val is 'function'
				, "`#{route.uri}` route #{type} method is not a function"

				callback val

		getUriParts = (route) ->
			uri = route.uri._uri
			uri = uri.replace Networking.Uri.NAMES_RE, ''
			uri = uri.replace /\*/g, ''
			uri = uri.replace /\/\//g, ''
			uri = uri.replace /^\//, ''
			uri = uri.replace /\/$/, ''
			uri = uri.split '/'

*Route* Route(*Object* options)
-------------------------------

Access it with:
```
module.exports = function(app){
  var Route = app.Route;
};
```

Acceptable syntaxes:
```
*Route* Route(*String* method, *String* uri)
*Route* Route(*String* uri)
```

		constructor: (method, uri) ->
			if uri is undefined
				if typeof method is 'string'
					opts = uri: method
				else
					opts = method
			else
				opts =
					method: method
					uri: uri

			assert.instanceOf @, AppRoute
			assert.isPlainObject opts

			# check for unprovided options
			assert do ->
				optsKeys = utils.merge Object.keys(opts), CONFIG_KEYS
				utils.isEqual(CONFIG_KEYS, optsKeys)
			, "Unprovided config key has been passed into `app.Route`:\n" +
			  "#{JSON.stringify Object.keys(opts)}"

			# uri
			setUri @, opts.uri

			# method
			if opts.hasOwnProperty('method')
				setMethod @, opts.method.toLowerCase()

			# schema
			if opts.hasOwnProperty('schema')
				setSchema @, opts.schema

			# controller
			setController @, opts.controller

			# view
			setView @, opts.view

			# template
			setTemplate @, opts.template

			# serverResourceUri
			if opts.hasOwnProperty('serverResourceUri')
				setServerResourceUri @, opts.serverResourceUri

			# callback
			if opts.hasOwnProperty('callback')
				setCallback @, opts.callback

			# register route in networking
			app.networking.createHandler
				method: @method
				uri: @uri
				schema: @schema
				callback: @_onRequest

			# set object as immutable
			Object.preventExtensions @
			setImmediate =>
				Object.freeze @

*String* Route::method = 'get'
------------------------------

One of the HTTP [Networking.Request.METHODS][] values.

```
new app.Route({
  method: 'post',
  uri: 'user/create',
  controller: 'user.create'
});
```

		method: Networking.Request.GET

		CONFIG_KEYS.push 'method'

		setMethod = (ctx, val) ->
			assert.instanceOf ctx, AppRoute

			assert utils.has(Networking.Request.METHODS, val)
			, "Networking doesn't provide a `#{val}` method"

			ctx.method = val

*Networking.Uri* Route::uri
---------------------------

Valid [Networking.Uri][].

Passed string will be automatically parsed.

You will find more examples and supported syntax
in the [Networking.Uri][] documentation.

```
new app.Route({
  uri: 'user/{name}',
  controller: 'user.get'
});
```

		uri: null

		CONFIG_KEYS.push 'uri'

		setUri = (ctx, val) ->
			assert.instanceOf ctx, AppRoute

			if typeof val is 'string'
				ctx.uri = new Networking.Uri val
			else
				assert.instanceOf val, Networking.Uri
				ctx.uri = val

*Schema* Route::schema
----------------------

Valid [Schema][] used to validate parameters from the uri.

It's set as [Networking.Handler::uri][].

Passed object will be automatically used to create [Schema][] instance.

```
new app.Route({
  uri: 'user/{name}',
  schema: {
    name: {
      required: true,
      type: 'string',
      regexp: /^[a-zA-Z]{3,}$/
    }
  }
});
```

		schema: null

		CONFIG_KEYS.push 'schema'

		setSchema = (ctx, val) ->
			assert.instanceOf ctx, AppRoute

			if utils.isPlainObject val
				ctx.schema = new Schema val
			else
				assert.instanceOf val, Schema
				ctx.schema = val

*Function* Route::controller
----------------------------

Controller function or a path to the file method.

This function will be called with three parameters:
[Networking.Request][], [Networking.Response][] and *callback*.

First *callback* argument is always an error. If you pass it, next route will be checked.

```
new app.Route({
  uri: 'user/{name}',
  controller: function(req, res, callback){
    if (req.params.name !== 'BigBob'){
      callback(new Error("Who are you?"));
    } else {
      callback(null, app.models.user.getBigBob());
    }
  }
});
```

Passed string will be automatically changed to the corresponding file method.

```
// controllers/user/bigbob.js
module.exports = function(app){
  return {
    get: function(req, res, callback){}
  };
}

// routes/user.js
module.exports = function(app){
  new app.Route({
    uri: 'user/{name}',
    controller: 'user/bigbob.get'
  });
};
```

		controller: null

		CONFIG_KEYS.push 'controller'

		setController = (ctx, val) ->
			assert.instanceOf ctx, AppRoute

			if val is null
				return

			switch typeof val
				when 'string'
					ctx.controller = null
					getByPath ctx, val, 'controller', 'controllers', (val) ->
						ctx.controller = val
				when 'undefined'
					uri = getUriParts ctx
					r = app.controllers[uri.join('/')]?[ctx.method]
					r ?= app.controllers[uri[0...-1].join('/')]?[utils.last(uri)]
					ctx.controller = r
				when 'function'
					ctx.controller = val
			return

*app.View* Route::view
----------------------

Valid [App.View][] or file name from the *views* folder.

		view: null

		CONFIG_KEYS.push 'view'

		setView = (ctx, val) ->
			assert.instanceOf ctx, AppRoute

			if val is null
				return

			switch typeof val
				when 'string'
					view = app.views[val]

					assert view
					, "`#{val}` view file can't be found"
				when 'undefined'
					uri = getUriParts ctx
					r = app.views[uri.join('/')+'/'+ctx.method]
					r ?= app.views[uri.join('/')]
					view = r
				when 'object'
					assert val instanceof app.View
					, "`#{ctx.uri}` route view is not a app.View instance; `#{val}` given"

					view = val

			ctx.view = view
			return

*app.Template* Route::template
------------------------------

[App.Template][] instance or a file name from the *templates* folder.

		template: null

		CONFIG_KEYS.push 'template'

		setTemplate = (ctx, val) ->
			assert.instanceOf ctx, AppRoute

			if val is null
				return

			switch typeof val
				when 'string'
					ctx.template = app.templates[val]
					unless ctx.template instanceof app.Template
						setImmediate ->
							ctx.template = app.templates[val]
							assert ctx.template instanceof app.Template
							, "`#{ctx.uri}` route template is not an app.Template; `#{val}` given"
				when 'undefined'
					uri = getUriParts ctx
					r = app.templates[uri.join('/')]?[ctx.method]
					unless r
						for i in [0...uri.length-1] by 1
							chunk = uri[i]
							if r = app.templates[uri[0...-i].join('/')]
								break
					r ?= app.templates.index
					ctx.template = r
				when 'object'
					assert val instanceof app.Template
					, "`#{ctx.uri}` route template is not an app.Template; `#{val}` given"

					ctx.template = val
			return

*Networking.Uri* Route::serverResourceUri
-----------------------------------------

Special uri used to get data from the server.

Returned data from the server is available under the [Networking.Response::data][]
property.

If server request fails, rest functions (route callback, controller) won't be called.

```
new app.Route({
  uri: 'user/{name}',
  serverResourceUri: 'api/user/{name}',
  controller: function(req, res, callback){
    console.log('Got data for user', res.data.name);
    callback();
  }
})
```

		serverResourceUri: null

		CONFIG_KEYS.push 'serverResourceUri'

		setServerResourceUri = (ctx, val) ->
			assert.instanceOf ctx, AppRoute

			if typeof val is 'string'
				ctx.serverResourceUri = new Networking.Uri val
			else
				assert.instanceOf val, Networking.Uri
				ctx.serverResourceUri = val

*Function* Route::callback
--------------------------

Custom function called before getting data from the server (Route::serverResourceUri) and
before controller function.

It's called with the same parameters as controller, that is 
[Networking.Request][], [Networking.Response][] and *callback*.

		callback: null

		CONFIG_KEYS.push 'callback'

		setCallback = (ctx, val) ->
			assert.instanceOf ctx, AppRoute
			assert.isFunction val
			ctx.callback = val

		lastRes = null
		_onRequest: (req, res, next) =>
			assert.instanceOf @, AppRoute
			assert.instanceOf req, Networking.Request
			assert.instanceOf res, Networking.Response
			assert.isFunction next

			stack = new utils.async.Stack
			viewUsed = false

			masterLogtime = log.time "Handle request"
			logtime = null
			res.data = null

			# end loggs on custom response send
			req.onDestroyed ->
				log.end logtime if logtime?
				log.end masterLogtime if masterLogtime?

			# destroy response
			res.onSent onSent = ->
				if utils.isServer or not viewUsed
					res.destroy()
				else
					lastRes?.destroy()
					lastRes = res

			# clear old view
			if req.type is Networking.Request.HTML_TYPE and (@view or @template)
				clearView @, req, res

			# serverResourceUri
			if @serverResourceUri
				stack.add (callback) =>
					logtime = log.time "Route server resource request"
					app.networking.createRequest
						uri: app.networking.url + @serverResourceUri.toString(req.params)
						onLoaded: (_res) ->
							log.end logtime
							logtime = null

							if _res.isSucceed()
								res.data = _res.data
								callback null
							else
								callback _res.data

			# custom callback
			if @callback
				stack.add (callback) =>
					logtime = log.time "Route callback"
					@callback req, res, (err, data) ->
						log.end logtime
						logtime = null

						if data isnt undefined
							res.data = data

						callback err

			# controller
			if @controller
				stack.add (callback) =>
					logtime = log.time "Controller"
					@controller req, res, (err, data) ->
						log.end logtime
						logtime = null

						if data isnt undefined
							res.data = data

						callback err

			# view
			if req.type is Networking.Request.HTML_TYPE and (@view or @template)
				viewUsed = true
				stack.add (callback) =>
					if res.data instanceof Document
						# TODO: how to destroy this view?
						return callback null, res.data
					else unless res.data?
						res.data = new Dict

					logtime = log.time "View"
					renderView @, req, res, res.data, (err, data) ->
						log.end logtime
						logtime = null

						if data isnt undefined
							res.data = data

						callback err

			# run all
			stack.runAll (err) ->
				log.end masterLogtime
				masterLogtime = null

				if err?
					res.onSent.disconnect onSent
					return next err

				if not res.data? and req.method is Networking.Request.GET
					res.send 404
				else
					res.send 200

		currentTemplate = null
		currentTemplateView = null
		lastView = null

		clearView = do ->
			if utils.isNode
				(ctx, req, res) ->
					assert.instanceOf ctx, AppRoute
					assert.instanceOf req, Networking.Request
					assert.instanceOf res, Networking.Response
			else
				(ctx, req, res) ->
					assert.instanceOf ctx, AppRoute
					assert.instanceOf req, Networking.Request
					assert.instanceOf res, Networking.Response

					if currentTemplate isnt ctx.template
						if currentTemplateView
							currentTemplateView.destroy()
							currentTemplateView = null
							lastView = null
						currentTemplate = null

						if ctx.template
							currentTemplate = ctx.template
							currentTemplateView = ctx.template._render req
					else
						if currentTemplate
							currentTemplate.view._reloadReq req

					if lastView
						lastView.destroy()
						lastView = null
					return

		renderView = do ->
			if utils.isNode
				(ctx, req, res, data, callback) ->
					assert.instanceOf ctx, AppRoute
					assert.instanceOf req, Networking.Request
					assert.instanceOf res, Networking.Response

					view = ctx.view.render req, data

					if ctx.template
						templateView = ctx.template._render req
						ctx.template._renderTarget templateView, view

					masterView = templateView or view

					res.onSent ->
						masterView.destroy()

					callback null, masterView
			else
				(ctx, req, res, data, callback) ->
					assert.instanceOf ctx, AppRoute
					assert.instanceOf req, Networking.Request
					assert.instanceOf res, Networking.Response

					lastView = ctx.view.render req, data
					currentTemplate?._renderTarget currentTemplateView, lastView

					callback null, currentTemplateView or lastView
