'use strict'

glob = require 'glob'
pathUtils = require 'path'
cp = require 'child_process'
fs = require 'fs'

[_, _, path] = process.argv

realpath = fs.realpathSync ''

runTestFile = (path) ->
	try
		require pathUtils.join realpath, path
	catch err
		console.error err

if fs.existsSync(path) and fs.statSync(path).isFile()
	runTestFile path
else
	if fs.statSync(path).isDirectory()
		globPath = pathUtils.join path, '/', '**/*'
	else
		globPath = path

	glob globPath, (err, files) ->
		if err
			throw err

		for file in files
			runTestFile file

		return
