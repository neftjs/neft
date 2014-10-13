'use strict'

[fs, log, utils, cp, groundskeeper, coffee, glob, path] = ['fs-extra', 'log', 'utils', 'child_process',
	'groundskeeper', 'coffee-script', 'glob', 'path'].map require
[bundle, LinksBuilder] = ['./cake/bundle.coffee', './cake/links.coffee'].map require

{assert} = console

option '-r', '--release', 'generate bundle for release'

OUT = './build/'
BUNDLE_OUT = "#{OUT}bundles/"
QML_BUNDLE_OUT = "#{BUNDLE_OUT}qml/"
VIEWS_OUT = "#{OUT}views"
STYLES_OUT = "#{OUT}styles"

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

	# TODO: compile with styles only for a client bundle
	# [View, _] = ['view', 'view-styles'].map require
	[View] = ['view'].map require

	View.on View.ERROR, (name) ->
		filePath = "#{name}.html"
		html = fs.readFileSync "./views/#{filePath}", 'utf-8'
		View.fromHTML name, html

	builder = new LinksBuilder
		output: VIEWS_OUT
		ext: '.json'

	builder.cleanOutput()
	builder.findFiles './views'

	for file in builder.files
		unless View._files[file.name]
			View.fromHTML file.name, file.data

	utils.clear builder.files

	for name, view of View._files
		json = JSON.stringify view, null, 4
		file = new LinksBuilder.File
			name: name
			filepath: "./views/#{name}.json"
			data: json
		builder.addFile file
		builder.writeFile file

	builder.save()

	log.ok "Views has been successfully compiled"

compileStylesTask = task 'compile:styles', 'Compile styles into json format', ->

	compiler = require './cake/styles'

	builder = new LinksBuilder
		input: './styles'
		output: STYLES_OUT
		ext: '.coffee'
		onFile: (file) ->
			path.extname(file.filepath) is '.coffee'

	builder.cleanOutput()
	builder.findFiles()

	for file in builder.files
		file.data = compiler.compile file.data, file.filename
		builder.writeFile file

	for file in builder.files
		file.data = compiler.finish file.data, file.filename
		builder.writeFile file

	builder.save()

	log.ok "Styles has been successfully compiled"

compileTask = task 'compile', 'Compile views and styles', ->

	compileViewsTask()
	compileStylesTask()

FOLDERS = [
	{
		src: 'controllers'
		capitalize: true
	},
	{
		src: 'handlers/rest'
		capitalize: true
	},
	{
		src: 'handlers/view'
		capitalize: true
	},
	{
		src: 'models'
		capitalize: true
	},
	{
		src: 'routes'
	},
	{
		src: 'templates'
	}
]
linkTask = task 'link', 'Generate needed lists of existed files', ->

	capitalizeFileName = (file) ->
		file.name = utils.capitalize file.name

	for folder in FOLDERS
		LinksBuilder.build
			input: folder.src
			output: "#{OUT}#{folder.src}"
			onFile: if folder.capitalize then capitalizeFileName else null

	log.ok "Files has been successfully linked"

buildBrowserTask = task 'build:browser', 'Build bundle for browser environment', (opts, callback) ->

	build 'browser', release: opts.release, callback

buildQmlTask = task 'build:qml', 'Build bundle for qml environment', (opts, callback) ->

	stack = new utils.async.Stack

	# generate script
	stack.add (callback) ->
		build 'qml', release: opts.release, out: "#{QML_BUNDLE_OUT}script.js", callback

	stack.add (callback) ->
		# copy qml files
		fs.copySync './node_modules/app/cake/bundle/qml', QML_BUNDLE_OUT

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