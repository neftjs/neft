'use strict'

[fs, log, utils, cp] = ['fs-extra', 'log', 'utils', 'child_process'].map require
[bundle, links] = ['./cake/bundle.coffee', './cake/links.coffee'].map require

{assert} = console

option '-d', '--development', 'generate bundle for development'
option '-w', '--watch', 'watch files for changes'

OUT = './build/'
BUNDLE_OUT = "#{OUT}bundles/"
VIEWS_OUT = "#{OUT}views"
STYLES_OUT = "#{OUT}styles"
MODELS_OUT = "#{OUT}models"

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

	links input: './views', output: VIEWS_OUT, ext: '.json', (name, html, callback) ->

		view = View.fromHTML name, html
		callback JSON.stringify view, null, 4

	log.ok "Views has been successfully compiled"

task 'compile:styles', 'Compile SVG styles into json format', compileStylesTask = ->

	[svg2styles] = ['svg2styles'].map require

	links input: './styles', output: STYLES_OUT, ext: '.json', (name, svg, callback) ->

		svg2styles svg, null, (err, json) ->

			callback JSON.stringify json, null, 4

	log.ok "Styles has been successfully compiled"

task 'compile', 'Compile views and styles', compileTask = ->

	compileViewsTask()
	compileStylesTask()

task 'link:models', 'Generate list of models', linkModelsTask = ->

	links input: './models', output: MODELS_OUT

	log.ok "Models has been successfully linked"

task 'link', 'Generate needed lists of existed files', linkTask = ->

	linkModelsTask()

task 'build:browser', 'Build bundle for browser environment', buildBrowserTask = (opts) ->

	init opts

	funcs.push build.bind(null, 'browser')

	run()

task 'build', 'Build bundles for all supported environments', buildTask = (opts) ->

	buildBrowserTask opts

task 'all', 'Compile, build and link', allTask = (opts) ->

	compileTask opts
	buildTask opts
	linkTask opts

task 'run', 'Compile, build, link and run index', runTask = (opts) ->

	allTask opts
	funcs.push -> cp.fork './index.coffee'

	run()