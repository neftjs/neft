Standard routes @learn
======================

**neft.io app** comes with few predefined routes.

	'use strict'

	utils = require 'utils'
	log = require 'log'
	fs = require 'fs'
	pathUtils = require 'path'

	Dict = require 'dict'
	Document = require 'document'
	Networking = require 'networking'

	log = log.scope 'App', 'Bootstrap'

	VIEW_HTML = """
	<!doctype html>
	<html>
	<head>
		<meta charset="utf-8">
		<title>${title}</title>
		<script type="text/javascript" src="${neftFilePath}"></script>
		<script type="text/javascript" src="${appFilePath}"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	</head>
	<body>
		<noscript>
			<meta http-equiv="refresh" content="0; url=${appTextModeUrl}"></meta>
		</noscript>
	</body>
	</html>
	"""

	module.exports = (app) ->
		APP_JS_URI = '/app.js'
		NEFT_JS_URI = '/neft.js'
		JS_NEFT_FILE_PATH = './neft-browser-release.js'
		JS_NEFT_GAME_FILE_PATH = './neft-browser-game-release.js'
		JS_BUNDLE_FILE_PATH = './build/app-browser-release.js'
		VIEW_NAME = '_app_bootstrap'
		VIEW_FILE = 'view.html'
		TEXT_MODE_URI_PREFIX = '/neft-type=text'
		TYPE_COOKIE_NAME = 'neft-type'

		`//<development>`
		JS_NEFT_FILE_PATH = './neft-browser-develop.js'
		JS_NEFT_GAME_FILE_PATH = './neft-browser-game-develop.js'
		JS_BUNDLE_FILE_PATH = './build/app-browser-develop.js'
		`//</development>`

		view = Document.fromHTML(VIEW_NAME, VIEW_HTML)

		reservedUris = ['app.js', 'favicon.ico', 'static']
		reservedUrisRe = do =>
			re = ''
			re += "#{utils.addSlashes(uri)}|" for uri in reservedUris
			re = re.slice 0, -1
			new RegExp "^(?:#{re})"

		getType = (req) ->
			{cookie} = req.headers
			if cookie and cookie.indexOf('neft-type') isnt -1
				///neft\-type=([a-z]+)///.exec(cookie)[1]
			else
				app.config.type

#### app.js

Returns build app javascript file.

		`//<production>`
		appFile = fs.readFileSync JS_BUNDLE_FILE_PATH, 'utf-8'
		`//</production>`
		new app.Route
			uri: APP_JS_URI
			getData: (callback) ->
				`//<development>`
				fs.readFile JS_BUNDLE_FILE_PATH, 'utf-8', callback
				`//</development>`
				`//<production>`
				callback null, appFile
				`//</production>`

#### neft.js

Returns neft javascript file.

		`//<production>`
		neftFile = fs.readFileSync JS_NEFT_FILE_PATH, 'utf-8'
		neftGameFile = fs.readFileSync JS_NEFT_GAME_FILE_PATH, 'utf-8'
		`//</production>`
		new app.Route
			uri: NEFT_JS_URI
			getData: (callback) ->
				isGameType = getType(@request) is 'game'

				`//<development>`
				if isGameType
					fs.readFile JS_NEFT_GAME_FILE_PATH, 'utf-8', callback
				else
					fs.readFile JS_NEFT_FILE_PATH, 'utf-8', callback
				`//</development>`
				`//<production>`
				if isGameType
					callback null, neftGameFile
				else
					callback null, neftFile
				`//</production>`

#### favicon.ico

Returns 'static/favicon.ico' file.

		new app.Route
			uri: 'favicon.ico'
			redirect: 'static/favicon.ico'

#### static/{path*}

Returns any file from the static/ folder.

#### neft-type={type}/*

This URI is used by the browsers which doesn't support javascript - in such case always
full HTML document is returned (like for searching robots).

You can use this route in a browser to check whether your HTML document is proper, but
remember to clean your cookies when you finish.

#### Switch between CSS/WebGL and text type @snippet

```
<a href="/neft-type=app/">Use CSS renderer</a>
<a href="/neft-type=game/">Use WebGL renderer</a>
<a href="/neft-type=text/">Use text type (robots)</a>
```

		new app.Route
			uri: 'neft-type={type}/{rest*}'
			getData: (callback) ->
				req = @request
				res = @response
				res.setHeader 'Set-Cookie', "#{TYPE_COOKIE_NAME}=#{req.params.type}; path=/;"
				res.redirect "#{app.networking.url}/#{req.params.rest}"

#### *

It decides whether the full HTML document should be returned (e.g. for the Googlebot or
text browsers) or HTML scaffolding which will run **neft.io** on the client side.

		new app.Route
			uri: '*'
			getData: (callback) ->
				req = @request

				# text mode
				if getType(req) is 'text'
					return @next()

				userAgent = req.headers['user-agent']

				if req.type isnt Networking.Request.HTML_TYPE or # omit types other than html
				   reservedUrisRe.test(req.uri) or # omit reserved URIs
				   utils.has(userAgent, 'bot') or # omit Googlebot, msnbot etc.
				   utils.has(userAgent, 'Baiduspider') or # omit baidu bot
				   utils.has(userAgent, 'facebook') or # omit facebook bot
				   utils.has(userAgent, 'Links') # omit links text browser
					return @next()

				callback null

			destroyHTML: ->
				@response.data.destroy()
					
			toHTML: ->
				view.render
					title: app.config.title
					appTextModeUrl: TEXT_MODE_URI_PREFIX + @request.uri
					neftFilePath: app.networking.url + NEFT_JS_URI
					appFilePath: app.networking.url + APP_JS_URI
