'use strict'

pathUtils = require 'path'
fs = require 'fs-extra'
Mustache = require 'mustache'
coffee = require 'coffee-script'
cp = require 'child_process'

OUT_DIR = './build/android/'
STATIC_OUT_DIR = "#{OUT_DIR}app/src/main/assets/static"
ANDROID_BUNDLE_DIR = './build/android/'

{log} = Neft

module.exports = (config, callback) ->
	androidRuntimePath = pathUtils.resolve __dirname, '../../../../node_modules/android-runtime'

	mustacheFiles = []

	logtime = log.time "Copy android files into '#{OUT_DIR}'"
	if fs.existsSync(OUT_DIR)
		fs.removeSync OUT_DIR
	fs.copySync androidRuntimePath, OUT_DIR,
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

	logtime = log.time "Prepare android files"
	for path in mustacheFiles
		# get file
		file = fs.readFileSync path, 'utf-8'

		# get proper relative path
		relativePath = pathUtils.relative androidRuntimePath, path
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

	# main activity
	androidPackagePath = config.package.android.package.replace /\./g, '/'
	classFrom = "#{ANDROID_BUNDLE_DIR}app/src/main/java/__MainActivity__.java"
	classTo = "#{ANDROID_BUNDLE_DIR}app/src/main/java/#{androidPackagePath}/MainActivity.java"
	fs.move classFrom, classTo, (err) ->
		log.end logtime
		if err
			return callback err

		logtime = log.time 'Create android APK file'
		apkMode = if config.release then 'release' else 'debug'
		# gradlewMode = if config.release then 'assembleRelease' else 'assembleDebug'
		gradlewMode = 'assembleDebug'
		if /^win/.test(process.platform)
			exec = "cd #{ANDROID_BUNDLE_DIR} && ./gradlew.bat #{gradlewMode}"
		else
			exec = "cd #{ANDROID_BUNDLE_DIR} && chmod +x gradlew && ./gradlew #{gradlewMode}"
		cp.exec exec, (err) ->
			log.end logtime
			callback err
