'use strict'

zlib = require 'zlib'
log = require 'log'
path = require 'path'
Document = require 'document'
expect = require 'expect'

log = log.scope 'Networking'

HEADERS =
	'Host': (obj) -> "#{obj.networking.host}:#{obj.networking.port}"
	'Cache-Control': 'no-cache'
	'Content-Language': (obj) -> obj.networking.language
	'X-Frame-Options': 'deny'

METHOD_HEADERS =
	OPTIONS:
		'Access-Control-Allow-Origin': (opts) ->
			"#{opts.networking.protocol}://#{opts.networking.host}:#{opts.networking.port}"
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
isDocument = (data) -> 'text/html' if data instanceof Document

extensions =
	'.js': 'application/javascript'
	'.ico': 'image/x-icon'

parsers =
	'application/json': (data) ->
		try JSON.stringify data
	'text/html': (data) ->
		html = data.node.stringify()
		html

prepareData = (obj, data) ->
	logtime = log.time 'prepare data'

	# determine data type
	type = isDocument(data) or isJSON(data)
	type ?= extensions[path.extname obj.serverReq.url]
	type ?= 'text/plain'

	# parse data into type
	unless parsedData = parsers[type]?(data)
		parsedData = data + ''

	log "Data will be send as `#{type}`"

	unless obj.serverRes.getHeader 'Content-Type'
		obj.serverRes.setHeader 'Content-Type', "#{type}; charset=utf-8"

	log.end logtime

	parsedData

###
Send data in server response
###
sendData = do ->
	send = (obj, data) ->
		if typeof data is 'string'
			len = Buffer.byteLength data
		else
			len = data and data.length

		obj.serverRes.setHeader 'Content-Length', len
		obj.serverRes.end data

	(obj, data, callback) ->
		acceptEncodingHeader = obj.serverReq.headers['accept-encoding']
		useGzip = acceptEncodingHeader and ~acceptEncodingHeader.indexOf 'gzip'

		unless useGzip
			send obj, data
			return callback()

		logtime = log.time "gzip data"

		setHeaders obj, GZIP_ENCODING_HEADERS

		zlib.gzip data, (_, data) ->
			log.end logtime
			send obj, data
			callback()

module.exports = (Networking, pending) ->
	setHeader: (res, name, val) ->
		# get config obj
		obj = pending[res.request.uid]
		obj.serverRes.setHeader name, val

	send: (res, data, callback) ->
		# get config obj
		obj = pending[res.request.uid]
		return unless obj

		delete pending[res.request.uid]

		logtime = log.time "send response by HTTP"

		{serverRes} = obj

		# write headers
		setHeaders obj, HEADERS
		setHeaders obj, headers if headers = METHOD_HEADERS[obj.serverReq.method]

		# set status
		serverRes.statusCode = res.status

		# send data
		data = prepareData obj, data
		sendData obj, data, ->
			log.end logtime
			callback()