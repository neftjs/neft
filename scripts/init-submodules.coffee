'use strict'

glob = require 'glob'
utils = require 'neft-utils'
cp = require 'child_process'
fs = require 'fs-extra'

npmInstall = (path, callback) ->
	cp.exec "cd #{path} && npm install --only=prod", callback

glob './node_modules/neft-*', (err, files) ->
	if err
		throw new Error err

	stack = new utils.async.Stack

	for file in files
		stack.add npmInstall, null, [file]

	stack.runAll (err) ->
		if err
			throw new Error err

		fs.remove './node_modules/neft-*/node_modules/neft-*', ->
