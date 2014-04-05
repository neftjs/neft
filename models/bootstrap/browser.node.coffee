'use strict'

[Routing, fs, utils] = ['routing', 'fs', 'utils'].map require

module.exports = (App) -> new class BrowserBootstrapModel extends App.Model.Client().View()

	APP_JS_URI: 'app.js'
	JS_BUNDLE_FILE_PATH: './build/bundles/browser.js'

	reservedUris: ['app.js', 'favicon.ico']
	_reservedUrisRe: do =>
		re = ''
		re += "#{utils.addSlashes(uri)}|" for uri in @::reservedUris
		re = re.slice 0, -1
		new RegExp re

	@view 'bootstrap/browser',
	@client Routing.GET, '*',
	getApp: (id, query, type, callback, req, next) ->

		if req

			# TODO: consider other robots and clients with legacy browsers
			if @_reservedUrisRe.test(req.uri) or # omit reserved URIs
			   ~req.userAgent.indexOf('Googlebot') # omit google boot
				return next()

		callback null,
			title: App.config.name
			appTextModeUrl: '/', # TODO
			filename: App.routing.url + @APP_JS_URI

	@client Routing.GET, @::APP_JS_URI,
	getAppBundle: (id, query, type, callback) ->

		callback null, fs.readFileSync @JS_BUNDLE_FILE_PATH, 'utf-8'
