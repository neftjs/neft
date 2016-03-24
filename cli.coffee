'use strict'

glob = require 'glob'
pathUtils = require 'path'
cp = require 'child_process'
fs = require 'fs'

[_, _, path] = process.argv

realpath = fs.realpathSync ''

runTestFile = (path) ->
	require pathUtils.join realpath, path

if fs.statSync(path).isFile()
	runTestFile path
else
	glob pathUtils.join(path, '/', '**/*.spec.*'), (err, files) ->
		if err
			throw err

		for file in files
			runTestFile file

		return
