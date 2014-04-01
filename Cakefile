'use strict'

[fs, log, utils, path] = ['fs-extra', 'log', 'utils', 'path'].map require
[bundle] = ['./cake/bundle.coffee'].map require

{assert} = console

option '-d', '--development', 'generate bundle for development'
option '-w', '--watch', 'watch files for changes'

OUT = './build/'
BUNDLE_OUT = "#{OUT}bundles/"
VIEWS_OUT = "#{OUT}views/"
STYLES_OUT = "#{OUT}styles/"

task = do (_super = global.task) -> (name, desc, callback) ->

	func = ->

		logtime = log.time name
		callback.apply @, arguments
		log.end logtime

	_super.call @, name, desc, func

###
Run registered tasks if needed.
Omit changes in the same tick.
###
funcs = []
immediate = false

run = ->

	return if immediate

	immediate = true
	setImmediate ->
		immediate = false
		func() for func in funcs

###
Called on the beginning for all tasks
###
initialized = false
init = (opts) ->

	assert not initialized
	assert utils.isObject opts

	initialized = true

	# watch changes
	if opts.watch
		log.warn 'Watch feature is not implemented yet'

	# production mode
	if not opts.development
		log.warn "Production mode is not implemented yet"

###
Build bundle file
###
build = (type) ->

	assert ~['qml', 'browser'].indexOf type

	bundle (err, src) ->

		if err then return log.error err

		out = "#{BUNDLE_OUT}#{type}.js"
		fs.outputFileSync out, src

		log.ok "#{utils.capitalize(type)} bundle saved as `#{out}`"

task 'compile:views', 'Compile HTML views into json format', compileViewsTask = ->

	[View] = ['view'].map require

	NAME_RE = ///(.+)\.html///

	names = []

	# compile html into json
	for view in fs.readdirSync './views'
		[_, name] = NAME_RE.exec view
		html = fs.readFileSync "./views/#{view}", 'utf-8'

		view = View.fromHTML name, html
		json = JSON.stringify view, null, 4

		names.push name
		fs.outputFileSync "#{VIEWS_OUT}#{name}.json", json

	# generate `views.coffee` file
	viewsDir = path.relative OUT, VIEWS_OUT
	str = ''
	for name in names
		str += "exports['#{name}'] = require('./#{viewsDir}/#{name}.json');\n"

	fs.outputFileSync "#{OUT}views.coffee", str

	log.ok "Views has been successfully compiled"

task 'compile:styles', 'Compile SVG styles into json format', compileStylesTask = ->

	[svg2styles] = ['svg2styles'].map require

	NAME_RE = ///(.+)\.svg///

	names = []

	# compile svg into json
	for style in fs.readdirSync './styles'
		[_, name] = NAME_RE.exec style
		svg = fs.readFileSync "./styles/#{style}", 'utf-8'
		
		names.push name

		svg2styles svg, null, (err, json) ->

			json = JSON.stringify json, null, 4

			fs.outputFileSync "#{STYLES_OUT}#{name}.json", json

	# generate `views.coffee` file
	stylesDir = path.relative OUT, STYLES_OUT
	str = ''
	for name in names
		str += "exports['#{name}'] = require('./#{stylesDir}/#{name}.json');\n"

	fs.outputFileSync "#{OUT}styles.coffee", str

	log.ok "Styles has been successfully compiled"

task 'compile', 'Compile views and styles', compileTask = ->

	compileViewsTask()
	compileStylesTask()

task 'build:browser', 'Build bundle for browser environment', buildBrowserTask = (opts) ->

	init opts

	funcs.push build.bind(null, 'browser')

	run()

task 'build', 'Build bundles for all supported environments', buildTask = (opts) ->

	buildBrowserTask opts

task 'all', 'Compile and build', (opts) ->

	compileTask opts
	buildTask opts