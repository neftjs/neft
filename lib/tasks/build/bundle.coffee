'use strict'

fs = require 'fs'
bundleBuilder = require 'bundle-builder'
pathUtils = require 'path'

{utils, log} = Neft

DEFAULT_LOCAL_FILE =
	android:
		sdkDir: '$ANDROID_HOME'
		compileSdkVersion: 23
		buildToolsVersion: "23"
		dependencies: [
			"com.android.support:appcompat-v7:23.0.0"
		]

module.exports = (platform, options, app, callback) ->
	mode = if options.release then 'release' else 'develop'
	neftFileName = "neft-#{platform}-#{mode}.js"
	neftFilePath = "../../../bundle/neft-#{platform}-#{mode}.js"

	bundleBuilder
		path: 'index.js'
		verbose: true
		platform: platform
		onlyLocal: platform is 'node'
		release: options.release
		minify: options.release
		removeLogs: options.release
		neftFilePath: pathUtils.resolve(__dirname, neftFilePath)
		, (err, file) ->
			if err
				return callback err

			if fs.existsSync('./local.json')
				localFile = JSON.parse fs.readFileSync './local.json', 'utf-8'
				local = {}
				utils.mergeDeep local, DEFAULT_LOCAL_FILE
				utils.mergeDeep local, localFile
			else
				local = DEFAULT_LOCAL_FILE
			fs.writeFileSync './local.json', JSON.stringify(local, null, 4)

			config =
				platform: platform
				release: options.release
				app: app
				mode: mode
				neftFileName: neftFileName
				neftCode: fs.readFileSync pathUtils.resolve(__dirname, neftFilePath), 'utf-8'
				appFileName: "app-#{platform}-#{mode}.js"
				appCode: file
				package: JSON.parse fs.readFileSync('./package.json')
				local: JSON.parse fs.readFileSync('./local.json')

			require("./bundle/#{platform}") config, callback
