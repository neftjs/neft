Route @class
============

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	log = require 'log'
	Schema = require 'schema'
	Networking = require 'networking'
	Document = require 'document'
	Dict = require 'dict'

	log = log.scope 'App', 'Route'

	module.exports = (app) -> class Route

		if utils.isNode
			usedTemplates = []
		else
			templates = Object.create null

		lastClientHTMLRoute = null

*Route* Route(*Object* options)
-------------------------------

Access it with:
```javascript
module.exports = function(app){
  var Route = app.Route;
};
```

Acceptable syntaxes:
```javascript
*Route* app.Route(*String* method, *String* uri, *Object* options)
*Route* app.Route(*String* methodWithUri, *Function* getData)
*Route* app.Route(*String* methodWithUri, *Object* options)
*Route* app.Route(*String* uri, *Function* getData)
*Route* app.Route(*String* uri, *Object* options)
*Route* app.Route(*String* method, *String* uri)
*Route* app.Route(*String* uri)
*Route* app.Route(*String* methodWithUri)
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

			for key, val of opts
				@[key] = val
			@__id__ = utils.uid()
			@app = app
			@name ||= getRouteName(@)

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
				r._destroyViewOnEnd = false
				r

		destroyRoute = (route) ->
			assert.instanceOf route, Route

			if lastClientHTMLRoute is route
				lastClientHTMLRoute = null

			route.response.onSend.disconnect onResponseSent, route
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
			if route._destroyViewOnEnd
				route.response.data.destroy()
			routesCache[route.__id__].push Object.getPrototypeOf(route)

		resolveSyncGetDataFunc = (route) ->
			assert.instanceOf route, Route

			try
				data = route.getData()
				if data?
					route.data = data
			catch err
				if route.response.status is 200
					route.response.status = 500
				route.error = err

		resolveAsyncGetDataFuncCallback = (route, err, data) ->
			assert.instanceOf route, Route

			if err?
				if route.response.status is 200
					route.response.status = 500
				if route._dataPrepared and route.error is err
					return false
				route.error = err
			else
				if route._dataPrepared and route.data is data
					return false
				route.data = data
			true

		prepareRouteData = (route) ->
			assert.instanceOf route, Route
			{response} = route

			respData = response.data
			switch route.request.type
				when 'text'
					data = route.toText()
				when 'json'
					data = route.toJSON()
				when 'html'
					data = route.toHTML()
					if respData instanceof Document and route._destroyViewOnEnd
						respData.destroy()
						response.data = null
					if not (data instanceof Document) and response.data is respData
						data = renderViewFromConfig.call route, data
			route._dataPrepared = true
			if data?
				response.data = data
			else if response.data is respData
				response.data = ''

		onResponseSent = ->
			if utils.isNode or @request.type isnt 'html'
				destroyRoute @

				if utils.isNode and utils.has(usedTemplates, @response.data)
					@response.data.destroy()
					utils.remove usedTemplates, @response.data
			return

		finishRequest = (route) ->
			assert.instanceOf route, Route
			if route.response.pending
				route.response.send()
			return

		callNextIfNeeded = (route, next) ->
			unless pendingRoutes[route.__hash__]
				if route.response.pending
					next()
				return true
			false

		handleRequest = (req, res, next) ->
			assert.instanceOf req, Networking.Request
			assert.instanceOf res, Networking.Response
			assert.isFunction next

			route = factoryRoute @
			hash = route.__hash__
			assert.notOk pendingRoutes[hash]

			if utils.isClient
				if lastClientHTMLRoute
					destroyRoute lastClientHTMLRoute
				lastClientHTMLRoute = route

			route.request = req
			route.response = res
			pendingRoutes[hash] = true

			res.onSend onResponseSent, route

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
						if callNextIfNeeded(route, next)
							return
						unless resolveAsyncGetDataFuncCallback(route, err, data)
							return
						prepareRouteData route
						if callNextIfNeeded(route, next)
							return
						finishRequest route
				else
					resolveSyncGetDataFunc route
					if callNextIfNeeded(route, next)
						return
					prepareRouteData route
					if callNextIfNeeded(route, next)
						return
					finishRequest route
			else
				prepareRouteData route
				if callNextIfNeeded(route, next)
					return
				finishRequest route

			if not fakeAsync and callNextIfNeeded(route, next)
				return

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

*Any* Route::error
------------------

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

*Any* Route::toJSON()
---------------------

		toJSON: ->
			if @response.status < 400
				@data?.toJSON?() or @data
			else
				@error.toJSON?() or @error

*String* Route::toText()
------------------------

		toText: ->
			if @response.status < 400
				@data+''
			else
				@error+''

*Document* Route::toHTML()
--------------------------

		renderViewFromConfig = (opts) ->
			viewName = opts?.view or @name or 'index'
			tmplName = opts?.template or 'template'
			useName = opts?.use or 'body'

			logtime = log.time 'Render'
			if viewName isnt tmplName and (tmpl = app.views[tmplName])
				tmplView = Route::getTemplateView.call @, tmplName
				tmplView.use useName, null
			if view = app.views[viewName]
				r = view.render @
			if tmplView
				if r?
					r = tmplView.use(useName, r)
				else
					r = tmplView
				if tmplView.storage.routes.has(useName)
					tmplView.storage.routes.pop useName
				tmplView.storage.routes.set useName, @
				@_destroyViewOnEnd = false
			else
				@_destroyViewOnEnd = true
			log.end logtime
			r

		createToHTMLFromObject = (opts) ->
			-> renderViewFromConfig.call @, opts

		toHTML: createToHTMLFromObject
			view: ''
			template: ''
			use: ''

*Document* Route::getTemplateView(*String* viewName)
----------------------------------------------------

		getTemplateView: do ->
			if utils.isNode
				(name) ->
					tmpl = app.views[name].render(app: app, routes: new Dict)
					usedTemplates.push tmpl
					tmpl
			else
				(name) ->
					templates[name] ?= app.views[name].render(app: app, routes: new Dict)
