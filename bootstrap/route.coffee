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
		uri: '*'
		view: view
		callback: (req, res, callback, next) ->
			# app js uri
			if req.uri is APP_JS_URI
				res.send Routing.Response.OK, fs.readFileSync(JS_BUNDLE_FILE_PATH, 'utf-8')
				return

			# text mode initialization
			if req.uri.indexOf(TEXT_MODE_URI_PREFIX) is 0
				redirect = req.uri.slice TEXT_MODE_URI_PREFIX.length
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
			   reservedUrisRe.test(req.uri) or # omit reserved URIs
			   ~req.userAgent.indexOf('Googlebot') # omit google boot
				return next()

			callback null,
				title: App.config.name
				appTextModeUrl: TEXT_MODE_URI_PREFIX + req.uri
				filename: App.routing.url + APP_JS_URI