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
setHeaders = (obj, headers) ->
	{serverRes} = obj

	for name, value of headers
		unless serverRes.getHeader(name)?
			if typeof value is 'function'
				value = value obj
			serverRes.setHeader name, value

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

prepareData = (type, obj, data) ->
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

	if mimeType? and not obj.serverRes.getHeader('Content-Type')?
		obj.serverRes.setHeader 'Content-Type', "#{mimeType}; charset=utf-8"

	parsedData

###
Send data in server response
###
sendData = do ->
	senders =
		'text': do ->
			send = (obj, data) ->
				if typeof data is 'string'
					len = Buffer.byteLength data
				else
					len = data and data.length

				obj.serverRes.setHeader 'Content-Length', len
				obj.serverRes.end data

			(obj, data, callback) ->
				acceptEncodingHeader = obj.serverReq.headers['Accept-Encoding']
				useGzip = acceptEncodingHeader and utils.has(acceptEncodingHeader, 'gzip')

				unless useGzip
					send obj, data
					return callback()

				zlib.gzip data, (err, gzipData) ->
					if err
						send obj, data
					else
						setHeaders obj, GZIP_ENCODING_HEADERS
						send obj, gzipData
					callback()

		'binary': (obj, data, callback) ->
			# set headers
			setHeaders obj, data.getHeaders()

			# get length
			data.getLength (err, length) ->
				if err
					return callback err
				obj.serverRes.setHeader 'Content-Length', length
				data.pipe obj.serverRes

	(type, obj, data, callback) ->
		sender = senders[type] or senders.text
		sender obj, data, callback

module.exports = (Networking, pending) ->
	exports =
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

		{serverRes} = obj

		# write headers
		setHeaders obj, HEADERS
		if headers = METHOD_HEADERS[obj.serverReq.method]
			setHeaders obj, headers

		# set status
		serverRes.statusCode = res.status

		# cookies
		if cookies = utils.tryFunction(JSON.stringify, null, [res.cookies], null)
			serverRes.setHeader 'X-Cookies', cookies

		# send data
		{type} = res.request
		data = prepareData type, obj, data
		sendData type, obj, data, (err) ->
			callback err

	redirect: (res, status, uri, callback) ->
		exports.send res, null, callback
