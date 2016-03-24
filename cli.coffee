'use strict'

glob = require 'glob'
pathUtils = require 'path'
cp = require 'child_process'
fs = require 'fs'

[_, _, path] = process.argv

runTests = 0
testsCode = 0

runTestFile = (path) ->
	runTests += 1

	opts =
		title: path
		startTime: Date.now()
	optsJSON = JSON.stringify opts

	child = cp.fork path, [optsJSON]
	child.on 'exit', (code) ->
		testsCode ||= code
		if --runTests is 0
			process.exit testsCode

if fs.statSync(path).isFile()
	runTestFile path
else
	glob pathUtils.join(path, '/', '**/*.spec.*'), (err, files) ->
		if err
			throw err

		for file in files
			runTestFile file

		return
