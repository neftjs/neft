Standard routes @txt
====================

	'use strict'

	utils = require 'utils'
	fs = require 'fs'
	pathUtils = require 'path'
	mmm = require 'mmmagic'

	Document = require 'document'
	Networking = require 'networking'

	Magic = mmm.Magic

	VIEW_HTML = """
	<!doctype html>
	<html>
	<head>
		<meta charset="utf-8">
		<title>${data.title}</title>
		<script type="text/javascript" src="${data.neftFilePath}"></script>
		<script type="text/javascript" src="${data.appFilePath}"></script>
	</head>
	<body>
		<noscript>
			<meta http-equiv="refresh" content="0; url=${data.appTextModeUrl}"></meta>
		</noscript>
	</body>
	</html>
	"""

	module.exports = (app) ->

		APP_JS_URI = 'app.js'
		NEFT_JS_URI = 'neft.js'
		JS_NEFT_FILE_PATH = './neft-browser-release.js'
		JS_BUNDLE_FILE_PATH = './build/app-browser-release.js'
		VIEW_NAME = '_app_bootstrap'
		VIEW_FILE = 'view.html'
		TEXT_MODE_URI_PREFIX = '/legacy/'
		TEXT_MODE_COOKIE_NAME = 'textMode'

		`//<development>`
		JS_NEFT_FILE_PATH = './neft-browser-develop.js'
		JS_BUNDLE_FILE_PATH = './build/app-browser-develop.js'
		`//</development>`

		view = new app.View do ->
			Document.fromHTML VIEW_NAME, VIEW_HTML

		reservedUris = ['app.js', 'favicon.ico']
		reservedUrisRe = do =>
			re = ''
			re += "#{utils.addSlashes(uri)}|" for uri in reservedUris
			re = re.slice 0, -1
			new RegExp re

#### app.js

		new app.Route
			uri: APP_JS_URI
			callback: (req, res, callback) ->
				fs.readFile JS_BUNDLE_FILE_PATH, 'utf-8', callback

#### neft.js

		new app.Route
			uri: NEFT_JS_URI
			callback: (req, res, callback) ->
				fs.readFile JS_NEFT_FILE_PATH, 'utf-8', callback

#### static/{path*}

		magic = new Magic mmm.MAGIC_MIME_TYPE | mmm.MAGIC_MIME_ENCODING
		new app.Route
			uri: 'static/{path*}'
			callback: (req, res, callback) ->
				url = pathUtils.join 'static', req.params.path
				unless ///^static.///.test url
					return callback true

				magic.detectFile './'+req.uri, (err, mime) ->
					if err?
						return callback err
					res.setHeader 'Content-Type', mime
					fs.readFile './'+req.uri, 'utf-8', callback

#### *

		new app.Route
			uri: '*'
			view: view
			callback: (req, res, callback) ->
				# text mode initialization
				if req.uri.indexOf(TEXT_MODE_URI_PREFIX) is 0
					redirect = req.uri.slice TEXT_MODE_URI_PREFIX.length
					res.setHeader 'Set-Cookie', "#{TEXT_MODE_COOKIE_NAME}=true; path=/;"
					res.setHeader 'Location', "/#{redirect}"
					res.send Networking.Response.TEMPORARY_REDIRECT
					return

				# text mode
				cookie = req.headers.cookie
				if cookie and cookie.indexOf(TEXT_MODE_COOKIE_NAME) isnt -1
					return callback true

				# TODO: consider other robots and clients with legacy browsers
				if req.type isnt Networking.Request.HTML_TYPE or # omit types other than html
				   reservedUrisRe.test(req.uri) or # omit reserved URIs
				   ~req.userAgent.indexOf('Googlebot') # omit google boot
					return callback true

				callback null,
					title: app.config.title
					appTextModeUrl: TEXT_MODE_URI_PREFIX + req.uri
					neftFilePath: app.networking.url + NEFT_JS_URI
					appFilePath: app.networking.url + APP_JS_URI
