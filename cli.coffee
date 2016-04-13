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

pathIsFile = pathIsDir = false
if fs.existsSync(path)
	pathStat = fs.statSync path
	pathIsFile = pathStat.isFile()
	pathIsDir = pathStat.isDirectory()

if pathIsFile
	runTestFile path
else
	if pathIsDir
		globPath = pathUtils.join path, '/', '**/*'
	else
		globPath = path

	glob globPath, (err, files) ->
		if err
			throw err

		for file in files
			runTestFile file

		return
