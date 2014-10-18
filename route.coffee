'use strict'

utils = require 'utils'
expect = require 'expect'
log = require 'log'

Routing = require 'routing'
Schema = require 'schema'
View = require 'view'

{assert} = console
log = log.scope 'Route'

CONFIG_KEYS = [] # filled by the class properties
HANDLERS = ['rest', 'view']

module.exports = (App) -> class AppRoute

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
	getByPath = (route, val, type, containerName) ->
		expect(route).toBe.any AppRoute
		expect(type).toBe.string()
		expect(containerName).toBe.truthy().string()

		container = utils.get App, containerName

		if typeof val is 'string'
			[name, method] = val.split '.'
			assert container[name]
			, "`#{name}` #{type} doesn't exists; `App.#{containerName}.#{name}` is not provided"

			assert typeof container[name][method] is 'function'
			, "`App.#{containerName}.#{name}.#{method}` #{type} method is not a function"

			container[name][method]
		else
			assert typeof val is 'function'
			, "`#{route.uri}` route #{type} method is not a function"

			val

	###
	Check whether handler function is proper.
	###
	validateHandler = (method) ->
		expect(method).toBe.function()

		assert method.length is 2
		, "Handler method must provides exactly two parameters (`data` and `callback`)"

	constructor: (opts) ->
		expect(@).toBe.any AppRoute
		expect(opts).toBe.simpleObject()

		# check for unprovided options
		assert do ->
			optsKeys = utils.merge Object.keys(opts), CONFIG_KEYS
			utils.isEqual(CONFIG_KEYS, optsKeys)
		, "Unprovided config key has been passed into `App.Route`:\n" +
		  "#{JSON.stringify opts, null, 4}"

		# uri
		setUri @, opts.uri

		# method
		if opts.method?
			setMethod @, opts.method.toLowerCase()

		# schema
		if opts.schema?
			setSchema @, opts.schema

		# controller
		if opts.controller?
			setController @, opts.controller

		# handler
		if opts.handler?
			setHandlersAll @, opts.handler

		# handlers
		if opts.handlers?
			setHandlers @, opts.handlers

		# view
		if opts.view?
			setView @, opts.view

		# template
		if opts.template?
			setTemplate @, opts.template

		# callback
		if opts.callback?
			setCallback @, opts.callback

		# register route in routing
		App.routing.createHandler
			method: @method
			uri: @uri
			schema: @schema
			callback: @_onRequest

		# set object as immutable
		Object.freeze @

	method: Routing.Request.GET

	CONFIG_KEYS.push 'method'

	setMethod = (ctx, val) ->
		expect(ctx).toBe.any AppRoute

		assert utils.has(Routing.Request.METHODS, val)
		, "Routing doesn't provide a `#{val}` method"

		ctx.method = val

	uri: ''

	CONFIG_KEYS.push 'uri'

	setUri = (ctx, val) ->
		expect(ctx).toBe.any AppRoute

		assert val and typeof val is 'string'
		, "App.Route requires non-empty `uri` string; `#{val}` given"

		ctx.uri = val

	schema: null

	CONFIG_KEYS.push 'schema'

	setSchema = (ctx, val) ->
		expect(ctx).toBe.any AppRoute

		if utils.isObject val
			ctx.schema = new Schema val
		else
			assert val instanceof Schema
			, "App.Route expects instance of Schema as schema; `#{val}` given"

			ctx.schema = val

	controller: null

	CONFIG_KEYS.push 'controller'

	setController = (ctx, val) ->
		expect(ctx).toBe.any AppRoute

		ctx.controller = getByPath ctx, val, 'controller', 'controllers'

		assert ctx.controller.length >= 2
		, "`#{ctx.uri}` route controller method must provide at least two parameters " +
		  "(`params` and `callback`; second `data` is optional)"


	handlers: null

	CONFIG_KEYS.push 'handlers'

	setHandlers = (ctx, val) ->
		expect(ctx).toBe.any AppRoute

		assert utils.isObject val
		, "Route `handlers` must be an object; available handlers are `#{HANDLERS}`"

		handlers = {}
		for type, handler of val
			assert utils.has HANDLERS, type
			, "`#{type}` handler is not provided; available handlers are `#{HANDLERS}`"

			method = getByPath ctx, handler, "#{type} handler", "handlers.#{type}"
			validateHandler method
			ctx.handlers[type] = method

		ctx.handlers = handlers

	CONFIG_KEYS.push 'handler'

	setHandlersAll = (ctx, val) ->
		expect(ctx).toBe.any AppRoute

		handlers = {}

		assert val and typeof val is 'string'
		, "`#{ctx.uri}` route handler must be a non-empty string; `#{val}` given"

		findHandlers = 0
		for type in HANDLERS
			handler = utils.tryFunc getByPath, null, [ctx, val, '', "handlers.#{type}"]
			unless handler?
				continue

			findHandlers++

			if handlers[type]?
				continue

			validateHandler handler
			handlers[type] = handler

		assert findHandlers > 0
		, "Not any `#{val}` handler can be found"

		ctx.handlers = handlers

	view: null

	CONFIG_KEYS.push 'view'

	setView = (ctx, val) ->
		expect(ctx).toBe.any AppRoute

		if typeof val is 'string'
			view = App.views[val]

			assert view
			, "`#{val}` view file can't be found"
		else
			assert val instanceof App.View
			, "`#{ctx.uri}` route view is not a App.View instance; `#{val}` given"

			view = val

		ctx.view = view

	template: null

	CONFIG_KEYS.push 'template'

	setTemplate = (ctx, val) ->
		expect(ctx).toBe.any AppRoute

		if typeof val is 'string'
			template = App.templates[val]

			assert template
			, "`#{val}` template file can't be found; " +
			  "check whether js or coffee `templates/#{val}` file exists and "
			  "`cake link` target is run"
		else
			template = val

		assert template instanceof App.Template
		, "`#{ctx.uri}` route template is not an App.Template; `#{val}` given"

		ctx.template = template

	callback: null

	CONFIG_KEYS.push 'callback'

	setCallback = (ctx, val) ->
		expect(ctx).toBe.any AppRoute

		assert typeof val is 'function'
		, "`#{ctx.uri}` route callback is not a function; `#{val}` given"

		assert val.length >= 2
		, "`#{ctx.uri}` route callback must provide at least two parameters " +
		  "(`req` and `res`; `callback` is optional)"

		ctx.callback = val

	_onRequest: (req, res, next) =>
		expect(@).toBe.any AppRoute
		expect(req).toBe.any Routing.Request
		expect(res).toBe.any Routing.Response
		expect(next).toBe.function()

		result = null
		stack = new utils.async.Stack

		masterLogtime = log.time "Handle request"
		logtime = null

		# end loggs on custom response send
		req.onDestroyed ->
			log.end logtime if logtime?
			log.end masterLogtime if masterLogtime?

		# custom callback
		if @callback
			stack.add (callback) =>
				logtime = log.time "Route callback"
				@callback req, res, (err, data) ->
					log.end logtime
					logtime = null

					assert req.pending
					, "Route callback can't send an response and call `next()` also"

					result = data
					callback err, result
				, (err) ->
					log "Route callback wants to omit this request; call next route"
					log.end logtime
					log.end masterLogtime
					logtime = masterLogtime = null

					next err

		# controller
		if @controller
			stack.add (callback) =>
				logtime = log.time "Controller"
				@_callController req, (err, data) ->
					log.end logtime
					logtime = null

					if err? and not result
						return callback err

					if data
						result = data

					callback null, result

		# handler
		if @handlers?[req.type]
			stack.add (callback) =>
				logtime = log.time "Handler (`#{req.type}`)"
				@_callHandler req.type, result, (err, data) ->
					log.end logtime
					logtime = null

					if data
						result = data
					callback err, data

		# view
		if @view or @template
			stack.add (callback) =>
				if result instanceof View
					# TODO: how to destroy this view?
					return callback null, result

				logtime = log.time "View"
				@_renderView req, res, result, (err, data) ->
					log.end logtime
					logtime = null

					if data
						result = data
					callback err, data

		# run all
		stack.runAll (err) ->
			log.end masterLogtime
			masterLogtime = null

			if err?
				return next err

			if not result?
				res.send 404
			else
				res.send 200, result

	_callController: (req, callback) ->
		expect(@).toBe.any AppRoute
		expect(req).toBe.any Routing.Request
		expect(callback).toBe.function()

		assert @controller

		if @controller.length is 2
			@controller req.params, callback
		else
			@controller req.params, req.data, callback

	_callHandler: (type, data, callback) ->
		expect(@).toBe.any AppRoute
		expect().some(HANDLERS).toBe type
		expect(callback).toBe.function()

		handler = @handlers[type]
		assert handler

		handler data, (err, _data) ->
			if _data is undefined
				_data = data

			callback err, _data

	_renderView: (req, res, data, callback) ->
		expect(@).toBe.any AppRoute
		expect(req).toBe.any Routing.Request
		expect(res).toBe.any Routing.Response
		expect(callback).toBe.function()

		# destroy views
		view = renderView @, req, res, data

		callback null, view

	renderView = do ->

		if utils.isNode
			(ctx, req, res, data) ->
				expect(ctx).toBe.any AppRoute
				expect(req).toBe.any Routing.Request
				expect(res).toBe.any Routing.Response

				view = ctx.view.render req, data: data

				if ctx.template
					templateView = ctx.template._render req
					ctx.template._renderTarget templateView, view

				masterView = templateView or view

				res.onSent ->
					masterView.destroy()

				masterView
		else
			currentTemplate = null
			currentTemplateView = null
			lastView = null

			(ctx, req, res, data) ->
				expect(ctx).toBe.any AppRoute
				expect(req).toBe.any Routing.Request
				expect(res).toBe.any Routing.Response

				if currentTemplate isnt ctx.template
					currentTemplateView?.destroy()
					currentTemplate = null
					currentTemplateView = null

					if ctx.template
						currentTemplate = ctx.template
						currentTemplateView = ctx.template._render req

				lastView?.destroy()
				lastView = ctx.view.render req, data: data
				currentTemplate?._renderTarget currentTemplateView, lastView

				currentTemplateView or lastView