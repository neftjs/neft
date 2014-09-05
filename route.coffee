utils = require 'utils'
expect = require 'expect'
log = require 'log'

Routing = require 'routing'
Schema = require 'schema'
View = require 'view'

{assert} = console
log = log.scope 'Route'

CONFIG_KEYS = ['method', 'uri', 'schema', 'controller', 'handler', 'handlers', 'render', 'callback']
HANDLERS = ['rest', 'view']

module.exports = (App) -> class Route

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
		expect(route).toBe.any Route
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
		expect(@).toBe.any Route
		expect(opts).toBe.simpleObject()

		# check for unprovided options
		assert do ->
			optsKeys = utils.merge Object.keys(opts), CONFIG_KEYS
			utils.isEqual(CONFIG_KEYS, optsKeys)
		, "Unprovided config key has been passed into `App.Route`:\n#{JSON.stringify opts, null, 4}"

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
		App.routing.on @method,
			uri: @uri
			schema: @schema
		, @_onRequest

		# set object as not mutable
		Object.freeze @

	method: Routing.GET

	setMethod = (ctx, val) ->
		expect(ctx).toBe.any Route

		assert utils.has(Routing.METHODS, val)
		, "Routing doesn't provide a `#{val}` method"

		ctx.method = val

	uri: ''

	setUri = (ctx, val) ->
		expect(ctx).toBe.any Route

		assert val and typeof val is 'string'
		, "App.Route requires non-empty `uri` string; `#{val}` given"

		ctx.uri = val

	schema: null

	setSchema = (ctx, val) ->
		expect(ctx).toBe.any Route

		if utils.isObject val
			ctx.schema = new Schema val
		else
			assert val instanceof Schema
			, "App.Route expects instance of Schema as schema; `#{val}` given"

			ctx.schema = val

	controller: null

	setController = (ctx, val) ->
		expect(ctx).toBe.any Route

		ctx.controller = getByPath ctx, val, 'controller', 'controllers'

		assert ctx.controller.length >= 2
		, "`#{ctx.uri}` route controller method must provide at least two parameters " +
		  "(`params` and `callback`; second `data` is optional)"


	handlers: null

	setHandlers = (ctx, val) ->
		expect(ctx).toBe.any Route

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

	setHandlersAll = (ctx, val) ->
		expect(ctx).toBe.any Route

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

	view: ''

	setView = (ctx, val) ->
		expect(ctx).toBe.any Route

		if typeof val is 'string'
			assert App.views[val]
			, "`#{val}` view file can't be found"
		else
			assert val instance View
			, "`#{ctx.uri}` route view is not a View instance; `#{val}` given"

		ctx.view = val

	template: null

	setTemplate = (ctx, val) ->
		expect(ctx).toBe.any Route

		if typeof val is 'string'
			ctx.template = App.templates[val]

			assert ctx.template
			, "`#{val}` template file can't be found"
		else
			assert utils.isObject val
			, "`#{ctx.uri}` route template is not an object; `#{val}` given"

		ctx.template = val

	callback: null

	setCallback = (ctx, val) ->
		expect(ctx).toBe.any Route

		assert typeof val is 'function'
		, "`#{ctx.uri}` route callback is not a function; `#{val}` given"

		assert val.length >= 2
		, "`#{ctx.uri}` route callback must provide at least two parameters " +
		  "(`req` and `res`; `callback` is optional)"

		ctx.callback = val

	_onRequest: (req, res, next) =>
		expect(@).toBe.any Route
		expect(req).toBe.any Routing.Request
		expect(res).toBe.any Routing.Response
		expect(next).toBe.function()

		result = null
		stack = new utils.async.Stack

		masterLogtime = log.time "Handle request"

		# custom callback
		if @callback
			stack.add (callback) =>
				logtime = log.time "Route callback"
				@callback req, res, (err, data) ->
					log.end logtime

					assert req.pending
					, "Route callback can't send an response and call `next()` also"

					result = data
					callback err, result

		# controller
		if @controller
			stack.add (callback) =>
				logtime = log.time "Controller"
				@_callController req, (err, data) ->
					log.end logtime

					if err? and not result
						return callback err

					if data
						result = data

					callback null, result

		# handler
		if @handlers[req.type]
			stack.add (callback) =>
				logtime = log.time "Handler (`#{req.type}`)"
				@_callHandler req.type, result, (err, data) ->
					log.end logtime

					if data
						result = data
					callback err, data

		# view
		if @view or @template
			stack.add (callback) =>
				logtime = log.time "View"
				@_renderView req, result, (err, data) ->
					log.end logtime

					if data
						result = data
					callback err, data

		# run all
		stack.runAll (err) ->
			log.end masterLogtime

			if err?
				return next err

			if not result?
				res.send 404
			else
				res.send 200, result

	_callController: (req, callback) ->
		expect(@).toBe.any Route
		expect(req).toBe.any Routing.Request
		expect(callback).toBe.function()

		assert @controller

		if @controller.length is 2
			@controller req.params, callback
		else
			@controller req.params, req.data, callback

	_callHandler: (type, data, callback) ->
		expect(@).toBe.any Route
		expect().some(HANDLERS).toBe type
		expect(callback).toBe.function()

		handler = @handlers[type]
		assert handler

		handler data, (err, _data) ->
			if _data is undefined
				_data = data

			callback err, _data

	_renderView: (req, data, callback) ->
		expect(@).toBe.any Route
		expect(req).toBe.any Routing.Request
		expect(callback).toBe.function()

		view = View.factory @view

		view.storage =
			data: data

		view.render()

		callback null, view