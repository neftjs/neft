'use strict'

fs = require 'fs'
bundleBuilder = require 'bundle-builder'
pathUtils = require 'path'

{log} = Neft

DEFAULT_LOCAL_FILE =
	android:
		ndkDir: ''
		sdkDir: ''

module.exports = (platform, options, callback) ->
	mode = if options.release then 'release' else 'develop'
	neftFileName = "neft-#{platform}-#{mode}.js"
	neftFilePath = "../../../bundle/neft-#{platform}-develop.js"

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

			unless fs.existsSync('./local.json')
				fs.writeFileSync './local.json', JSON.stringify(DEFAULT_LOCAL_FILE, null, 4)

			config =
				platform: platform
				release: options.release
				mode: mode
				neftFileName: neftFileName
				neftCode: fs.readFileSync pathUtils.resolve(__dirname, neftFilePath), 'utf-8'
				appFileName: "app-#{platform}-#{mode}.js"
				appCode: file
				package: JSON.parse fs.readFileSync('./package.json')
				local: JSON.parse fs.readFileSync('./local.json')

			require("./bundle/#{platform}") config, callback
