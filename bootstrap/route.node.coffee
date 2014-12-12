'use strict'

utils = require 'utils'
fs = require 'fs'
pathUtils = require 'path'

View = require 'view'
Routing = require 'routing'

module.exports = (App) ->

	APP_JS_URI = 'app.js'
	JS_BUNDLE_FILE_PATH = './build/bundles/browser.js'
	VIEW_NAME = '_app_bootstrap'
	VIEW_FILE = 'view.html'
	TEXT_MODE_URI_PREFIX = 'legacy/'
	TEXT_MODE_COOKIE_NAME = 'textMode'

	view = new App.View do ->
		path = pathUtils.join __dirname, VIEW_FILE
		file = fs.readFileSync path, 'utf-8'
		View.fromHTML VIEW_NAME, file

	reservedUris = ['app.js', 'favicon.ico']
	reservedUrisRe = do =>
		re = ''
		re += "#{utils.addSlashes(uri)}|" for uri in reservedUris
		re = re.slice 0, -1
		new RegExp re

	new App.Route
		uri: APP_JS_URI
		callback: (req, res, callback, next) ->
			fs.readFile JS_BUNDLE_FILE_PATH, 'utf-8', callback

	new App.Route
		uri: 'static/{path*}'
		callback: (req, res, callback, next) ->
			url = pathUtils.join 'static', req.params.path
			unless ///^static.///.test url
				return next()

			fs.readFile req.url, 'utf-8', callback

	new App.Route
		uri: '*'
		view: view
		callback: (req, res, callback, next) ->
			# text mode initialization
			if req.url.indexOf(TEXT_MODE_URI_PREFIX) is 0
				redirect = req.url.slice TEXT_MODE_URI_PREFIX.length
				res.setHeader 'Set-Cookie', "#{TEXT_MODE_COOKIE_NAME}=true; path=/;"
				res.setHeader 'Location', "/#{redirect}"
				res.send Routing.Response.TEMPORARY_REDIRECT
				return

			# text mode
			cookie = req.headers.cookie
			if cookie and cookie.indexOf(TEXT_MODE_COOKIE_NAME) isnt -1
				return next()

			# TODO: consider other robots and clients with legacy browsers
			if req.type isnt Routing.Request.VIEW_TYPE or # omit types other than view
			   reservedUrisRe.test(req.url) or # omit reserved URIs
			   ~req.userAgent.indexOf('Googlebot') # omit google boot
				return next()

			callback null,
				title: App.config.name
				appTextModeUrl: TEXT_MODE_URI_PREFIX + req.url
				filename: App.routing.url + APP_JS_URI
