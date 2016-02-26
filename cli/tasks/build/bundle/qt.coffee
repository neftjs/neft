'use strict'

pathUtils = require 'path'
fs = require 'fs-extra'
Mustache = require 'mustache'
coffee = require 'coffee-script'
cp = require 'child_process'

OUT_DIR = './build/qt/'
STATIC_OUT_DIR = "#{OUT_DIR}static"
QT_BUNDLE_DIR = './build/qt/'

{log, Resources} = Neft

getResourcesPaths = do ->
	onResource = (resource, target) ->
		for _, resolutions of resource.paths
			for _, path of resolutions
				target.push path: path.slice(1)
		return

	onResources = (resources, target) ->
		for prop in Object.keys(resources)
			val = resources[prop]
			if val instanceof Resources.Resource
				onResource val, target
			else if typeof val is 'object'
				onResources val, target
		return

	(resources) ->
		r = []
		onResources resources, r
		r

module.exports = (config, callback) ->
	qtRuntimePath = pathUtils.resolve __dirname, '../../../../node_modules/qt-runtime'

	mustacheFiles = []

	logtime = log.time "Copy qt files into '#{OUT_DIR}'"
	if fs.existsSync(OUT_DIR)
		fs.removeSync OUT_DIR
	fs.copySync qtRuntimePath, OUT_DIR,
		filter: (path) ->
			# omit hidden files
			if /\/\./i.test(path)
				return false
			# process mustache files later
			if /\.mustache$/.test(path)
				mustacheFiles.push path
				return false
			true
	log.end logtime

	logtime = log.time "Copy static files into '#{STATIC_OUT_DIR}'"
	fs.copySync './static', STATIC_OUT_DIR
	if fs.existsSync('./build/static')
		fs.copySync './build/static', STATIC_OUT_DIR
	log.end logtime

	# resources
	config = Object.create config
	config.resources = getResourcesPaths config.app.resources

	logtime = log.time "Prepare qt files"
	for path in mustacheFiles
		# get file
		file = fs.readFileSync path, 'utf-8'

		# get proper relative path
		relativePath = pathUtils.relative qtRuntimePath, path
		relativePath = relativePath.slice 0, -'.mustache'.length

		# compile coffee files
		if /\.coffee$/.test(relativePath)
			file = coffee.compile file, bare: true
			relativePath = relativePath.slice 0, -'.coffee'.length
			relativePath += '.js'

		# render file
		file = Mustache.render file, config

		# save file
		fs.writeFileSync pathUtils.join(OUT_DIR, relativePath), file, 'utf-8'

	log.end logtime
	callback()
