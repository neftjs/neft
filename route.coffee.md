Route @class
============

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	Schema = require 'schema'
	Networking = require 'networking'
	Document = require 'document'

	module.exports = (app) -> class Route

*Object* Route.templates
------------------------

		@templates = Object.create null

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
*Route* Route(*String* method, *String* uri, *Object* options)
*Route* Route(*String* methodWithUri, *Function* getData)
*Route* Route(*String* methodWithUri, *Object* options)
*Route* Route(*String* uri, *Function* getData)
*Route* Route(*String* uri, *Object* options)
*Route* Route(*String* method, *String* uri)
*Route* Route(*String* uri)
*Route* Route(*String* methodWithUri)
```

		constructor: (method, uri, opts) ->
			if utils.isObject(method)
				# opts
				opts = method
			else if utils.isObject(uri)
				opts = uri
			else unless utils.isObject(opts)
				opts = {}

			if typeof method is 'string' and typeof uri isnt 'string'
				opts.uri = method
			else if typeof method is 'string' and typeof uri is 'string'
				opts.method ?= method
				opts.uri ?= uri
			if typeof uri is 'function'
				opts.getData ?= uri

			assert.isObject opts
			opts = utils.clone opts

			if typeof opts.uri is 'string'
				# support methodWithUri e.g. 'get /home'
				spaceIndex = opts.uri.indexOf ' '
				if spaceIndex isnt -1
					opts.method ?= opts.uri.slice 0, spaceIndex
					opts.uri = opts.uri.slice spaceIndex+1
				opts.uri = new Networking.Uri opts.uri
			assert.instanceOf opts.uri, Networking.Uri

			opts.method ?= 'get'
			assert.isString opts.method
			opts.method = opts.method.toLowerCase()
			assert.ok utils.has(Networking.Request.METHODS, opts.method)
			, "Networking doesn't provide a `#{opts.method}` method"

			if opts.schema?
				if utils.isPlainObject(opts.schema)
					opts.schema = new Schema opts.schema
				assert.instanceOf opts.schema, Schema

			if opts.redirect?
				if typeof opts.redirect is 'string'
					opts.redirect = new Networking.Uri opts.redirect
				else
					assert.isFunction opts.redirect

			if utils.isObject(opts.toHTML)
				opts.toHTML = createToHTMLFromObject opts.toHTML

			utils.merge @, opts
			@__id__ = utils.uid()
			@app = app
			@name = getRouteName(@)

			app.networking.createHandler
				method: @method
				uri: @uri
				schema: @schema
				callback: utils.bindFunctionContext(handleRequest, @)

		getRouteName = (route) ->
			assert.instanceOf route, Route

			uri = route.uri._uri
			uri = uri.replace Networking.Uri.NAMES_RE, ''
			uri = uri.replace /\*/g, ''
			while uri.indexOf('//') isnt -1
				uri = uri.replace /\/\//g, '/'
			uri = uri.replace /^\//, ''
			uri = uri.replace /\/$/, ''
			uri

		routesCache = Object.create null
		pendingRoutes = Object.create null
		renderedRoutes = Object.create null

		factoryRoute = do ->
			createInstance = (route) ->
				r = Object.create route
				r.__hash__ = utils.uid()
				r.factory?()
				r

			(route) ->
				assert.instanceOf route, Route

				id = route.__id__
				routesCache[id] ?= []
				r = routesCache[id].pop() or createInstance(route)
				r = Object.create r
				r.request = r.response = null
				r.route = r
				r._dataPrepared = false
				r

		destroyRoute = (route) ->
			assert.instanceOf route, Route

			route.response.onSent.disconnect onResponseSent, route
			pendingRoutes[route.__hash__] = false
			route.destroy?()
			if route._dataPrepared
				switch route.request.type
					when 'text'
						route.destroyText?()
					when 'json'
						route.destroyJSON?()
					when 'html'
						route.destroyHTML?()
			routesCache[route.__id__].push Object.getPrototypeOf(route)

		resolveSyncGetDataFunc = (route) ->
			assert.instanceOf route, Route

			try
				route.data = route.getData()
			catch err
				if route.response.status is 200
					route.response.status = 500
				route.data = err

		resolveAsyncGetDataFuncCallback = (route, err, data) ->
			assert.instanceOf route, Route

			if err?
				if route.response.status is 200
					route.response.status = 500
				route.data = err
			else
				route.data = data

		prepareRouteData = (route) ->
			assert.instanceOf route, Route

			switch route.request.type
				when 'text'
					data = route.toText()
				when 'json'
					data = route.toJSON()
				when 'html'
					data = route.toHTML()
			route._dataPrepared = true
			unless data?
				data = ''
			route.response.data = data

		onResponseSent = ->
			if utils.isNode or @request.type isnt 'html' or not renderedRoutes[@__hash__]
				destroyRoute @

		finishRequest = (route) ->
			assert.instanceOf route, Route
			route.response.send()

		unless utils.isNode
			Document.onRender (file) ->
				if file.storage instanceof Route and file.constructor is Document
					renderedRoutes[file.storage.__hash__] = file

			Document.onRevert (file) ->
				if file.storage instanceof Route and file.constructor is Document and renderedRoutes[file.storage.__hash__] is file
					renderedRoutes[file.storage.__hash__] = null
					destroyRoute file.storage

		handleRequest = (req, res, next) ->
			assert.instanceOf req, Networking.Request
			assert.instanceOf res, Networking.Response
			assert.isFunction next

			route = factoryRoute @
			hash = route.__hash__
			assert.notOk pendingRoutes[hash]

			route.request = req
			route.response = res
			pendingRoutes[hash] = true

			res.onSent onResponseSent, route

			# init
			route.init?()

			unless pendingRoutes[hash]
				return next()

			# redirect
			{redirect} = route
			if typeof redirect is 'function'
				redirect = route.redirect()
				unless pendingRoutes[hash]
					return next()
			if typeof redirect is 'string'
				redirect = new Networking.Uri redirect
			if redirect instanceof Networking.Uri
				res.redirect redirect.toString(req.params)
				return

			# getData
			{getData} = route
			fakeAsync = false
			if typeof getData is 'function'
				if getData.length is 1
					route.getData (err, data) ->
						fakeAsync = true
						unless pendingRoutes[hash]
							return next()
						resolveAsyncGetDataFuncCallback route, err, data
						prepareRouteData route
						unless pendingRoutes[hash]
							return next()
						finishRequest route
				else
					resolveSyncGetDataFunc route
					unless pendingRoutes[hash]
						return next()
					prepareRouteData route
					unless pendingRoutes[hash]
						return next()
					finishRequest route
			else
				prepareRouteData route
				unless pendingRoutes[hash]
					return next()
				finishRequest route

			if not fakeAsync and not pendingRoutes[hash]
				return next()

*String* Route::method = 'get'
------------------------------

*Networking.Uri* Route::uri
---------------------------

*App* Route::app
----------------

*Route* Route::route
--------------------

*String* Route::name
--------------------

*Schema* Route::schema
----------------------

*Any* Route::data
-----------------

*Function* Route::factory()
---------------------------

*Function* Route::init()
------------------------

*Function* Route::getData([*Function* callback])
------------------------------------------------

*Function* Route::destroy()
---------------------------

*Function* Route::destroyJSON()
-------------------------------

*Function* Route::destroyText()
-------------------------------

*Function* Route::destroyHTML()
-------------------------------

*Function|Networking.Uri* Route::redirect
-----------------------------------------

*Networking.Request* Route::request
-----------------------------------

*Networking.Response* Route::response
-------------------------------------

*Function* Route::next()
------------------------

		next: ->
			assert.ok pendingRoutes[@__hash__]
			destroyRoute @

*Function* Route::toJSON
------------------------

		toJSON: ->
			@data?.toJSON?() or @data

*Function* Route::toText
------------------------

		toText: ->
			@data+''

*Function* Route::toHTML
------------------------

		createToHTMLFromObject = (opts) ->
			->
				viewName = opts.view or @name
				tmplName = opts.template or 'index'
				useName = opts.use or 'body'

				if view = app.views[viewName]
					r = view.render @
				if tmpl = app.views[tmplName]
					tmplView = Route.templates[tmplName] ?= tmpl.render(app: app)
					if r?
						r = tmplView.use(useName, r)
					else
						r = tmplView
				r

		toHTML: createToHTMLFromObject
			view: ''
			template: ''
			use: ''
