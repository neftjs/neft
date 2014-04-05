'use strict'

[Routing, fs] = ['routing', 'fs'].map require

module.exports = (App) -> new class BrowserBootstrapModel extends App.Model.Client().View()

	reservedUris: ['app.js', 'favicon.ico']

	@view 'bootstrap/browser',
	@client Routing.GET, '*',
	getApp: (id, query, type, callback, req, next) ->

		console.log req.userAgent
		if req

			# omit reserved URIs
			if ~@reservedUris.indexOf(req.uri) or
			   ~req.userAgent.indexOf('Googlebot')
				return next()

		callback null,
			title: 'title 123'
			appTextModeUrl: '/',
			filename: 'app.js'

	@client Routing.GET, 'app.js',
	getAppBundle: (id, query, type, callback) ->

		callback null, fs.readFileSync './build/bundles/browser.js', 'utf-8'
