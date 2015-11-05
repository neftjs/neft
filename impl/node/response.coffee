'use strict'

zlib = require 'zlib'
log = require 'log'
utils = require 'utils'
path = require 'path'
Document = require 'document'
expect = require 'expect'
FormData = require 'form-data'

log = log.scope 'Networking'

HEADERS =
	'Host': (obj) ->
		host = ///^(?:[a-z]+):\/\/(.+?)(?:\/)?$///.exec(obj.networking.url)
		if host then host[1] else obj.networking.url
	'Cache-Control': 'no-cache'
	'Content-Language': (obj) -> obj.networking.language
	'X-Frame-Options': 'deny'

METHOD_HEADERS =
	OPTIONS:
		'Access-Control-Allow-Origin': (obj) -> obj.networking.url
		'Allow': 'GET, POST, PUT, DELETE'

GZIP_ENCODING_HEADERS =
	'Content-Encoding': 'gzip'

###
Set headers in the server response
###
setHeaders = (res, headers, ctx) ->
	for name, value of headers
		unless res.getHeader(name)?
			if typeof value is 'function'
				value = value ctx
			res.setHeader name, value

	return

###
Parse passed data into expected type
###
parsers =
	'text': (data) ->
		data + ''
	'json': (data) ->
		if data instanceof Error
			data = utils.errorToObject data
		try
			JSON.stringify data
		catch
			data
	'html': (data) ->
		if data instanceof Document
			data.node.stringify()
		else
			data
	'binary': (data) ->
		formData = new FormData
		for key, val of data
			formData.append key, val
		formData

prepareData = (type, res, data) ->
	# determine data type
	switch type
		when 'text'
			mimeType = 'text/plain; charset=utf-8'
		when 'json'
			mimeType = 'application/json; charset=utf-8'
		when 'html'
			mimeType = 'text/html; charset=utf-8'

	# parse data into expected type
	parsedData = parsers[type](data)

	if mimeType? and not res.getHeader('Content-Type')?
		res.setHeader 'Content-Type', "#{mimeType}; charset=utf-8"

	parsedData

###
Send data in server response
###
sendData = do ->
	senders =
		'text': do ->
			send = (res, data) ->
				if typeof data is 'string'
					len = Buffer.byteLength data
				else
					len = data and data.length

				res.setHeader 'Content-Length', len
				res.end data

			(req, res, data, callback) ->
				acceptEncodingHeader = req?.headers['Accept-Encoding']
				useGzip = acceptEncodingHeader and utils.has(acceptEncodingHeader, 'gzip')

				unless useGzip
					send res, data
					return callback()

				zlib.gzip data, (err, gzipData) ->
					if err
						send res, data
					else
						setHeaders res, GZIP_ENCODING_HEADERS
						send res, gzipData
					callback()

		'binary': (req, res, data, callback) ->
			# set headers
			setHeaders res, data.getHeaders()

			# get length
			data.getLength (err, length) ->
				if err
					return callback err
				res.setHeader 'Content-Length', length
				data.pipe res

	(type, req, res, data, callback) ->
		sender = senders[type] or senders.text
		sender req, res, data, callback

module.exports = (Networking, pending) ->
	exports =
	_prepareData: prepareData
	_sendData: sendData
	setHeader: (res, name, val) ->
		if name? and val?
			# get config obj
			obj = pending[res.request.uid]
			obj.serverRes.setHeader name, val

	send: (res, data, callback) ->
		# get config obj
		obj = pending[res.request.uid]
		return unless obj

		delete pending[res.request.uid]

		{serverReq, serverRes} = obj

		# write headers
		setHeaders serverRes, HEADERS, obj
		if headers = METHOD_HEADERS[serverReq.method]
			setHeaders serverRes, headers

		# set status
		serverRes.statusCode = res.status

		# cookies
		if cookies = utils.tryFunction(JSON.stringify, null, [res.cookies], null)
			serverRes.setHeader 'X-Cookies', cookies

		# send data
		{type} = res.request
		data = prepareData type, serverRes, data
		sendData type, serverReq, serverRes, data, (err) ->
			callback err

	redirect: (res, status, uri, callback) ->
		exports.send res, null, callback
