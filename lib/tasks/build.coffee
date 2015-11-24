'use strict'

fs = require 'fs-extra'
cliUtils = require '../utils'

{utils, log} = Neft

parseApp = require './build/parse'
createBundle = require './build/bundle'
saveBundle = require './build/saveBundle'

clear = (platform, callback) ->
	fs.remove './index.js', callback

module.exports = (platform, options) ->
	unless cliUtils.verifyNeftProject('./')
		return

	# create build folder
	fs.ensureDirSync './build'

	stack = new utils.async.Stack

	# create temporary 'index.js' file
	stack.add parseApp, null, [platform, options]

	# create bundle files
	stack.add createBundle, null, [platform, options]

	# save output if needed
	if options.out
		stack.add saveBundle, null, [platform, options]

	# clear
	stack.add clear, null, [platform, options]

	# run
	stack.runAll (err) ->
		if err
			return log.error err?.stack or err

		# debug log
		unless options.release
			log.warn "Use this bundles only for testing. " +
				"For production use --release option"
