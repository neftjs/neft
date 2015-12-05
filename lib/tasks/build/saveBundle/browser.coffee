'use strict'

fs = require 'fs-extra'

{utils, log} = Neft

module.exports = (options, callback) ->
	copy = (src) ->
		stack.add fs.copy, fs, [src, "#{out}/#{src}", {}]

	logtime = log.time 'Save bundle'

	{out} = options
	stack = new utils.async.Stack
	fs.ensureDirSync out
	stack.add fs.remove, fs, ["#{out}/(neft-*|app-*|build|static)"]
	copy 'static'

	if fs.existsSync('build/static')
		copy 'build/static'

	mode = if options.release then 'release' else 'develop'
	copy "build/neft-browser-#{mode}.js"
	copy "build/app-browser-#{mode}.js"

	stack.runAll (err) ->
		log.end logtime
		callback err