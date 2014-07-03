'use strict'

[fs, log, utils, cp, groundskeeper, coffee, glob, path] = ['fs-extra', 'log', 'utils', 'child_process',
	'groundskeeper', 'coffee-script', 'glob', 'path'].map require
[bundle, links] = ['./cake/bundle.coffee', './cake/links.coffee'].map require

{assert} = console

option '-r', '--release', 'generate bundle for release'

OUT = './build/'
BUNDLE_OUT = "#{OUT}bundles/"
QML_BUNDLE_OUT = "#{BUNDLE_OUT}qml/"
VIEWS_OUT = "#{OUT}views"
STYLES_OUT = "#{OUT}styles"
MODELS_OUT = "#{OUT}models"

initialized = false

###
Called on the beginning for all tasks
###
init = (opts) ->
	assert not initialized
	assert utils.isObject opts

	initialized = true

###
Override global cake `task`.
Call `init()` on initialize and log tasks.
###
task = do (_super = global.task) -> (name, desc, callback) ->

	func = (opts, taskCallback) ->

		unless initialized then init opts

		onEnd = -> 
			log.end logtime
			taskCallback?()

		logtime = log.time name
		callback.call @, opts, onEnd

		onEnd() if callback.length < 2

	_super.call @, name, desc, func

	func

###
Build bundle file
###
build = (type, opts, callback) ->

	assert ~['qml', 'browser'].indexOf type

	PROPS_DEFS = ///utils\.defProp\(([a-z@]+),\s?'([a-zA-Z0-9_]+)',\s?'([a-z]*)',\s?([^,]+)\);///

	bundle type, (err, src) ->

		if err then return log.error err

		out = opts?.out or "#{BUNDLE_OUT}#{type}.js"

		# release mode
		if opts?.release

			# remove `expect`s
			cleaner = groundskeeper
				namespace: ['expect']
				replace: 'true'
			cleaner.write src
			src = cleaner.toString()

			# change properties definitions into simple assignments
			lines = src.split "\n"
			for line, i in lines
				if PROPS_DEFS.test line
					lines[i] = line.replace PROPS_DEFS, '$1.$2 = $4;'
			src = lines.join "\n"

		fs.outputFileSync out, src

		log.ok "#{utils.capitalize(type)} bundle saved as `#{out}`"

		callback()

compileViewsTask = task 'compile:views', 'Compile HTML views into json format', ->

	[View] = ['view'].map require

	links input: './views', output: VIEWS_OUT, ext: '.json', (name, html, write) ->

		View.fromHTML name, html

		for filePath, view of View._files
			json = JSON.stringify view, null, 4
			write json, filePath

		utils.clear View._files

	log.ok "Views has been successfully compiled"

compileTask = task 'compile', 'Compile views and styles', ->

	compileViewsTask()

linkModelsTask = task 'link:models', 'Generate list of models', ->

	links input: './models', output: MODELS_OUT, (name, file, callback) -> callback()

	log.ok "Models has been successfully linked"

linkStylesTask = task 'link:styles', 'Generate list of styles', ->

	links
		input: './styles'
		output: STYLES_OUT
		ext: '.json'
		test: (filePath, stat) ->
			path.extname(filePath) is '.json'
		callback: (name, file, callback) ->
			callback()

	log.ok "Styles has been successfully linked"

linkTask = task 'link', 'Generate needed lists of existed files', ->

	linkModelsTask()
	linkStylesTask()

buildBrowserTask = task 'build:browser', 'Build bundle for browser environment', (opts, callback) ->

	build 'browser', release: opts.release, callback

buildQmlTask = task 'build:qml', 'Build bundle for qml environment', (opts, callback) ->

	stack = new utils.async.Stack

	# generate script
	stack.add null, (callback) ->
		build 'qml', release: opts.release, out: "#{QML_BUNDLE_OUT}script.js", callback

	stack.add null, (callback) ->
		# copy qml files
		fs.copySync './cake/bundle/qml', QML_BUNDLE_OUT

		# compile coffee files
		glob "#{QML_BUNDLE_OUT}**/*.coffee", (err, files) ->
			if err then return log.error err

			for filePath in files
				file = fs.readFileSync filePath, 'utf-8'
				js = coffee.compile file, bare: true
				jsFilePath = filePath.replace '.coffee', '.js'
				fs.writeFileSync jsFilePath, js
				fs.unlinkSync filePath

		callback()

	stack.runAllSimultaneously callback

buildTask = task 'build', 'Build bundles for all supported environments', (opts, callback) ->

	stack = new utils.async.Stack
	stack.add null, buildBrowserTask, opts
	stack.add null, buildQmlTask, opts
	stack.runAll callback

allTask = task 'all', 'Compile, build, link and run index', (opts, callback) ->

	compileTask opts
	linkTask opts
	buildTask opts, callback

runTask = task 'run', 'Run server', (opts, callback) ->

	cp.fork './index.coffee'
	callback()