'use strict'

fs = require 'fs-extra'
cliUtils = require '../utils'

{utils, log} = Neft

parseApp = require './build/parse'
createBundle = require './build/bundle'
saveBundle = require './build/saveBundle'

clear = (platform, callback) ->
	fs.remove './index.js', callback

module.exports = (platform, options, callback) ->
	unless cliUtils.verifyNeftProject('./')
		return

	# create build folder
	fs.ensureDirSync './build'

	stack = new utils.async.Stack
	args = [platform, options, null]

	# create temporary 'index.js' file
	stack.add ((platform, options, callback) ->
		parseApp platform, options, (err, app) ->
			args[2] = app
			callback err
	), null, args

	# create bundle files
	stack.add createBundle, null, args

	# save output if needed
	if options.out
		stack.add saveBundle, null, args

	# clear
	stack.add clear, null, args

	# run
	stack.runAll callback
