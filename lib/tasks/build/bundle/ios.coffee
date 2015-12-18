'use strict'

pathUtils = require 'path'
fs = require 'fs-extra'
Mustache = require 'mustache'
coffee = require 'coffee-script'
cp = require 'child_process'
pathUtils = require 'path'

OUT_DIR = './build/ios/'
STATIC_OUT_DIR = "#{OUT_DIR}static"
ANDROID_BUNDLE_DIR = './build/ios/'

{log} = Neft

module.exports = (config, callback) ->
	iosRuntimePath = pathUtils.resolve __dirname, '../../../../node_modules/ios-runtime'

	mustacheFiles = []
	coffeeFiles = []

	logtime = log.time "Copy ios files into '#{OUT_DIR}'"
	if fs.existsSync(OUT_DIR)
		fs.removeSync OUT_DIR
	fs.copySync iosRuntimePath, OUT_DIR,
		filter: (path) ->
			# omit hidden files
			if /\/\./i.test(path)
				return false
			# compile coffee files
			if /\.coffee$/.test(path)
				coffeeFiles.push path
				return false
			# process mustache files later
			if /\.mustache$/.test(path)
				mustacheFiles.push path
				return false
			true
	log.end logtime

	# check whether otfinfo is installed
	checkFonts = false
	try
		cp.execSync 'otfinfo --version', silent: true
		checkFonts = true
	catch
		log.error "Custom fonts are not supported. Install 'lcdf-typetools'; e.g. brew install lcdf-typetools"

	logtime = log.time "Copy static files into '#{STATIC_OUT_DIR}'"
	config.fonts = []
	fs.copySync './static', STATIC_OUT_DIR,
		filter: (path) ->
			# get font PostScript name
			if checkFonts and pathUtils.extname(path) in ['.otf', '.ttf']
				realpath = fs.realpathSync(path)
				name = (cp.execSync("otfinfo -p #{realpath}")+"").trim()
				config.fonts.push
					source: "/#{path}"
					name: name
			true
	if fs.existsSync('./build/static')
		fs.copySync './build/static', STATIC_OUT_DIR
	log.end logtime

	logtime = log.time "Prepare ios files"
	for path in mustacheFiles
		# get file
		file = fs.readFileSync path, 'utf-8'

		# get proper relative path
		relativePath = pathUtils.relative iosRuntimePath, path
		relativePath = relativePath.slice 0, -'.mustache'.length

		# compile coffee files
		if /\.coffee$/.test(relativePath)
			file = coffee.compile file
			relativePath = relativePath.slice 0, -'.coffee'.length
			relativePath += '.js'

		# render file
		file = Mustache.render file, config

		# save file
		fs.writeFileSync pathUtils.join(OUT_DIR, relativePath), file, 'utf-8'

	for path in coffeeFiles
		# get file
		file = fs.readFileSync path, 'utf-8'

		# get proper relative path
		relativePath = pathUtils.relative iosRuntimePath, path

		# compile coffee files
		file = coffee.compile file
		relativePath = relativePath.slice 0, -'.coffee'.length
		relativePath += '.js'

		# save file
		fs.writeFileSync pathUtils.join(OUT_DIR, relativePath), file, 'utf-8'

	log.end logtime
	callback()
