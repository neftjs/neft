Standard routes @txt
====================

**neft.io app** comes with few predefined routes.

	'use strict'

	utils = require 'utils'
	log = require 'log'
	fs = require 'fs'
	pathUtils = require 'path'

	Document = require 'document'
	Networking = require 'networking'

	log = log.scope 'App', 'Bootstrap'

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
		APP_JS_URI = '/app.js'
		NEFT_JS_URI = '/neft.js'
		JS_NEFT_FILE_PATH = './neft-browser-release.js'
		JS_BUNDLE_FILE_PATH = './build/app-browser-release.js'
		VIEW_NAME = '_app_bootstrap'
		VIEW_FILE = 'view.html'
		TEXT_MODE_URI_PREFIX = '/legacy'
		TEXT_MODE_COOKIE_NAME = 'textMode'

		`//<development>`
		JS_NEFT_FILE_PATH = './neft-browser-develop.js'
		JS_BUNDLE_FILE_PATH = './build/app-browser-develop.js'
		`//</development>`

		view = new app.View do ->
			Document.fromHTML VIEW_NAME, VIEW_HTML

		reservedUris = ['app.js', 'favicon.ico', 'static']
		reservedUrisRe = do =>
			re = ''
			re += "#{utils.addSlashes(uri)}|" for uri in reservedUris
			re = re.slice 0, -1
			new RegExp "^(?:#{re})"

#### app.js

Returns build app javascript file.

		bundleFile = fs.readFileSync JS_BUNDLE_FILE_PATH, 'utf-8'
		new app.Route
			uri: APP_JS_URI
			callback: (req, res, callback) ->
				`//<development>`
				fs.readFile JS_BUNDLE_FILE_PATH, 'utf-8', callback
				`//</development>`
				`//<production>`
				callback null, bundleFile
				`//</production>`

#### neft.js

Returns neft javascript file.

		neftFile = fs.readFileSync JS_NEFT_FILE_PATH, 'utf-8'
		new app.Route
			uri: NEFT_JS_URI
			callback: (req, res, callback) ->
				callback null, neftFile

#### favicon.ico

Returns 'static/favicon.ico' file.

		new app.Route
			uri: 'favicon.ico'
			callback: (req, res, callback) ->
				res.redirect 'static/favicon.ico'

#### static/{path*}

Returns any file from the static/ folder.

#### *

It decides whether the full HTML document should be returned (e.g. for the Googlebot or
text browsers) or HTML scaffolding which will run **neft.io** on the client side.

#### legacy/*

This URI is used by the browsers which doesn't support javascript - in such case always
full HTML document is returned (like for searching robots).

You can use this route in a browser to check whether your HTML document is proper, but
remember to clean your cookies when you finish.

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
				   utils.has(req.userAgent, 'bot') or # omit Googlebot, msnbot etc.
				   utils.has(req.userAgent, 'Baiduspider') or # omit baidu bot
				   utils.has(req.userAgent, 'facebook') or # omit facebook bot
				   utils.has(req.userAgent, 'Links') # omit links text browser
					return callback true

				callback null,
					title: app.config.title
					appTextModeUrl: TEXT_MODE_URI_PREFIX + req.uri
					neftFilePath: app.networking.url + NEFT_JS_URI
					appFilePath: app.networking.url + APP_JS_URI
