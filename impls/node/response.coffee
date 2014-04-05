'use strict'

[zlib, log, path, View] = ['zlib', 'log', 'path', 'view'].map require

log = log.scope 'Routing'

HEADERS =
	'Host': (obj) -> "#{obj.routing.host}:#{obj.routing.port}"
	'Cache-Control': 'no-cache'
	'Content-Language': (obj) -> obj.routing.language
	'X-Frame-Options': 'deny'

METHOD_HEADERS =
	OPTIONS:
		'Access-Control-Allow-Origin': (opts) ->
			"#{opts.routing.protocol}://#{opts.routing.host}:#{opts.protocol.port}"
		'Allow': 'GET, POST, PUT, DELETE'

GZIP_ENCODING_HEADERS =
	'Content-Encoding': 'gzip'

###
Set headers in the server response
###
setHeaders = (obj, headers) ->

	{serverRes} = obj

	for name, value of headers
		if typeof value is 'function'
			value = value obj
		serverRes.setHeader name, value

###
Parse passed data into expected type
###
isObject = (data) -> true if data and typeof data is 'object'
isJSON = (data) -> 'application/json' if isObject data
isView = (data) -> 'text/html' if data instanceof View

extensions =
	'.js': 'application/javascript'
	'.ico': 'image/x-icon'

parsers =
	'application/json': (data) ->
		try JSON.stringify data
	'text/html': (data) ->
		data.node.stringify()

prepareData = (obj) ->

	logtime = log.time 'prepare data'

	{data} = obj.res

	# determine data type
	type = isView(data) or isJSON(data)
	type ?= extensions[path.extname obj.serverReq.url]
	type ?= 'text/plain'

	# parse data into type
	unless data = parsers[type]?(obj.res.data)
		data = obj.res.data + ''

	log "Data will be send as `#{type}`"

	obj.serverRes.setHeader 'Content-Type', "#{type}; charset=utf-8"

	log.end logtime

	data

###
Send data in server response
###
sendData = do ->

	send = (obj, data) ->

		if typeof data is 'string'
			len = Bugger.byteLength data
		else
			len = data and data.length

		obj.serverRes.setHeader 'Content-Length', len
		obj.serverRes.end data

	(obj, data) ->

		useGzip = ~obj.serverReq.headers['accept-encoding'].indexOf 'gzip'

		unless useGzip
			send obj, data
			return

		logtime = log.time "gzip data"

		setHeaders obj, GZIP_ENCODING_HEADERS

		zlib.gzip data, (_, data) ->
			log.end logtime
			send obj, data

module.exports = (pending) ->

	send: ->

		# get config obj
		obj = pending[@req.uid]
		return unless obj?.res
		delete pending[@req.uid]

		logtime = log.time "send response by HTTP"

		{serverRes} = obj

		# write headers
		setHeaders obj, HEADERS

		# set status
		serverRes.statusCode = @status

		# send data
		data = prepareData obj
		sendData obj, data

		log.end logtime